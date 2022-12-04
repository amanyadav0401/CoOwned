//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721Upgradeable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

interface IRentToken {
    function mint(address _to, uint256 _tokenId, string memory _uri) external;
    function burn(uint tokenId) external;
}

interface ICoOwned {
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract CoOwnedRental is ERC721URIStorageUpgradeable, ReentrancyGuard {

    IERC721Upgradeable rentable;
    IERC721Upgradeable rentToken;
    ICoOwned CoOwned;
    uint totalRentals;
    uint rentalReceiptNo;

    struct RentalList{
       address owner;
       uint tokenId;
       uint rentAmount;
       uint time;
       bool listingOver;
    }

    struct RentReceipt{
        uint rentalNo;
        address owner;
        uint tokenId;
        uint claimBackTIme;
    }

    function initialize(
        string memory _name,
        string memory _symbol,
        IERC721Upgradeable _rentable,
        IERC721Upgradeable _rentToken
    ) external initializer {
       
        __ERC721_init_unchained(_name, _symbol);
        rentable = _rentable;
        rentToken =_rentToken;
        CoOwned = ICoOwned(address(_rentable));
    }


    mapping(uint=>RentalList) public RentalListing;

    mapping(uint=>RentReceipt) public RentInvoicing;

    // rent amount will be sent in BP with multiplicaation of 100.

    function listRental(uint _tokenId, uint _rentAmount, uint _time) external {
        RentalList storage rentalList = RentalListing[totalRentals];
        rentalList.owner= msg.sender;
        rentalList.tokenId = _tokenId;
        rentalList.rentAmount = _rentAmount*10**16;
        rentalList.time= _time;
        totalRentals++;
    }

    function rent(uint _rentalNumber) external payable {
        RentalList storage rentalList = RentalListing[_rentalNumber];
        RentReceipt storage rentreceipt = RentInvoicing[rentalReceiptNo];
        require(msg.value>=rentalList.rentAmount,"Price exceeds amount.");
        rentable.safeTransferFrom(rentalList.owner, address(this), rentalList.tokenId);
        _mint(rentalList.owner, rentalReceiptNo);
        rentreceipt.rentalNo = rentalReceiptNo;
        rentreceipt.owner= rentalList.owner;
        rentreceipt.tokenId = rentalList.tokenId;
        rentreceipt.claimBackTIme = block.timestamp+rentalList.time;
        rentalReceiptNo++;
        uint fee = msg.value/100;
        uint amount = msg.value-fee;
        (bool sent, bytes memory data) = rentalList.owner.call{value: amount}("");
        string memory tokenURI = CoOwned.tokenURI(rentalList.tokenId);   
        IRentToken RentToken;
        RentToken = IRentToken(address(rentToken));
        RentToken.mint(msg.sender, rentalList.tokenId, tokenURI);
    }

    function claimRentalBack(uint _rentalNumber, uint rentalReceiptNo) external {
        RentalList storage rentalList = RentalListing[_rentalNumber];
        RentReceipt storage rentreceipt = RentInvoicing[rentalReceiptNo];
        require(msg.sender==rentalList.owner,"You are not the owner!");
        require(block.timestamp>rentreceipt.claimBackTIme,"Rental time not over.");
        _burn(rentalReceiptNo);
       rentable.safeTransferFrom(address(this), msg.sender, rentreceipt.tokenId);
       IRentToken RentToken;
       RentToken = IRentToken(address(rentToken));
       RentToken.burn(rentreceipt.tokenId);
    }






}
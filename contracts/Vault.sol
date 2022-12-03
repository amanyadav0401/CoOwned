// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/utils/ERC721HolderUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Vault is ERC20Upgradeable, ERC721HolderUpgradeable {
    address public admin;
    address public taxWallet;
    address public marketFeeWallet;
    address public token721;
    uint256 public fractionPrice;
    uint256 public tokenID;
    uint256 public fractionSupply;
    uint256 private tokenAmount;
    uint256 public offerNumber;
    uint256 public finalOfferredAmount;
    bool primaryBuyEnd;
    bool NFTSold;

    struct offer {
        address offerrer;
        uint256 offerred;
        uint256 fractionAcquired;
        bool offeredAmountClaimed;
    }
    mapping(uint256 => offer) private offerredAmounts;
    mapping(address => bool) public excludeFee;
    modifier onlyAdmin() {
        require(msg.sender == admin, "NA"); //Not Admin
        _;
    }

    function initialize(
        string memory _name,
        string memory _symbol,
        uint256 _tokenSupply,
        address _token721,
        uint256 _tokenID
    ) external initializer {
        // __Ownable_init();
        __ERC721Holder_init();
        __ERC20_init_unchained(_name, _symbol);
        // admin = _admin;
        token721 = _token721;
        // usdt = IUSDT(_usdt);
        // fractionPrice = _fractionPrice;
        tokenID = _tokenID;
        mint(token721, _tokenSupply);
        fractionSupply = totalSupply();
        // offerNumber = 1;
        // taxWallet = _taxWallet;
        // marketFeeWallet = _marketFeeWallet;
        excludeFee[address(this)] = true;
    }

    function mint(address _to, uint256 _amount) internal {
        //  require(totalSupply()+_amount<=tokenSupply,"IA");//Invalid amount
        _mint(_to, _amount);
    }

    // function buyFractions(uint256 _fractionAmount) external {
    //     require(!primaryBuyEnd, "AFS"); //All Fractions Sold
    //     require(fractionSupply >= _fractionAmount, "NES"); //Not Enough Supply
    //     uint256 amount = (_fractionAmount * fractionPrice)/10e18;
    //     IUSDT(usdt).transferFrom(
    //         msg.sender,
    //         marketFeeWallet,
    //         (amount * 1) / 100
    //     );
    //     IUSDT(usdt).transferFrom(
    //         msg.sender,
    //         admin,
    //         (amount - ((amount * 1) / 100))
    //     );
    //     _transfer(address(this), msg.sender, _fractionAmount);
    //     tokenAmount = tokenAmount + balanceOf(msg.sender);
    //     fractionSupply = fractionSupply - _fractionAmount;
    //     if (fractionSupply == 0) primaryBuyEnd = true;
    // }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20Upgradeable) {
        require(to != address(0), "ZA"); //zero address
        super._transfer(from,to,amount);
    }

    // function sellFraction(uint256 _offerNumber, uint256 _amount) external {
    //     require(!NFTSold, "NAS"); //NFT already sold
    //     require(balanceOf(msg.sender) != 0, "NF"); //No Fractions
    //     require(msg.sender != offerredAmounts[_offerNumber].offerrer, "ONA"); //Offerrer not allowed

    //     offerredAmounts[_offerNumber].fractionAcquired += _amount;

    //     uint256 payOut = _amount * offerredAmounts[_offerNumber].offerred;
    //     IUSDT(usdt).transfer(
    //         address(this),
    //         marketFeeWallet,
    //         (payOut * 1) / 100
    //     ); //Platform Fee
    //     _transfer(msg.sender, offerredAmounts[_offerNumber].offerrer, _amount);
    //     IUSDT(usdt).transfer(
    //         address(this),
    //         msg.sender,
    //         (payOut - ((payOut * 1) / 100))
    //     );
    // }


    // }
}

//SPDX-License Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract RentalNFT is ERC721URIStorageUpgradeable {
    address lender;
    function initialize(string memory _name, string memory symbol, address _lender) external initializer{
        __ERC721_init_unchained(_name, symbol);
        lender = _lender;
    }

    function mint(address _to, uint256 _tokenId,string memory _uri) external {
        require(msg.sender == lender,"NO");//Not Owner
        _mint(_to,_tokenId);
        _setTokenURI(_tokenId,_uri);

    }

    function transferFrom(address from,
        address to,
        uint256 tokenId) public override(ERC721Upgradeable) {
            require(msg.sender == lender,"NO");//Not Owner
            _transfer(from,to,tokenId);
        }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public  override (ERC721Upgradeable){
        require(msg.sender == lender,"NO");//Not Owner
        safeTransferFrom(from,to,tokenId,"");
    }   

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public override (ERC721Upgradeable){
        require(msg.sender == lender,"NO");//Not Owner
        safeTransferFrom(from,to,tokenId,"");
    }   

    function burn(uint256 tokenId) external {
        require(msg.sender == lender,"NO");//Not Owner
        _burn(tokenId);
    }
    }
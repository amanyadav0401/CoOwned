//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

interface IVaultfactory {
    function initialize(address _vault) external;

    function createVault(
        string memory _name,
        string memory _symbol,
        uint256 _tokenSupply,
        address _token721,
        uint256 _tokenID
    ) external returns (address _vault);

    function updateVault(address _vault) external;

    function viewVault(uint256 _tokenID) external;
}

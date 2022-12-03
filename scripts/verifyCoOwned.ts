const hre = require("hardhat");
import {
    expandTo18Decimals,
    expandTo6Decimals,
  } from "../test/utilities/utilities";

async function main() {

    console.log("after");
  
    await hre.run("verify:verify", {
        // address: "0x8640f97E894d782b9f4Bd6992e2bA0270488D3a7",
        // constructorArguments: [],
        // contract: "contracts/CoOwnNFT.sol:CoOwnNFT",

        // address: "0x27729F7480f08CA5bD6F0C553C14F0c794eA9E00",
        // constructorArguments: [],
        // contract: "contracts/VaultFactory.sol:VaultFactory",

        address: "0x70510074122146B589DEd90B0ff8e8d5E2Ad710A",
        constructorArguments: [],
        contract: "contracts/Vault.sol:Vault",
      });
    
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
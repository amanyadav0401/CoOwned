import { SignerWithAddress } from "../node_modules/@nomiclabs/hardhat-ethers/signers";
import { ethers, network } from "hardhat";
import {
  expandTo18Decimals,
  expandTo6Decimals,
} from "../test/utilities/utilities";
import {Vault, VaultFactory, CoOwnNFT, CoOwnedRental } from "../typechain";

function sleep(ms: any) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

async function main() {
    const coNFT = await ethers.getContractFactory("CoOwnNFT");
    const CoNFT = await coNFT.deploy();
    await sleep(2000);
    console.log("CONFT Address- "+CoNFT.address);

    // await sleep(2000);
    // const vaultFactory = await ethers.getContractFactory("VaultFactory");
    // const VaultFactor = await vaultFactory.deploy();
    // await sleep(2000);
    // console.log("Vault factory Address- "+VaultFactor.address);

    // await sleep(2000);
    // const vault = await ethers.getContractFactory("Vault");
    // const VAult = await vault.deploy();
    // await sleep(2000);
    // console.log("Vault Address- "+VAult.address);

}  

main()
.then(()=>process.exit(0))
.catch((error)=>{
    console.error(error);
    process.exit(1);
}) ;


/*
CONFT Address- 0x1e6BC221E6B9EB3D2A6d12deAB9Efd278bdF5Fb9
Vault factory Address- 0x68F4ca14B249F38272a9cD2f7E7505e126920510
Vault Address- 0xfB2d9162DF0465a9d58CF964a5e9C46c9A4236cC

NEW
CONFT Address- 0x8a2996bd8808c885846692F4d99fceFe2D3e815c
Vault factory Address- 0x27729F7480f08CA5bD6F0C553C14F0c794eA9E00
Vault Address- 0x70510074122146B589DEd90B0ff8e8d5E2Ad710A
*/
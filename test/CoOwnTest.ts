import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers"
import { ethers } from "hardhat"
import { CoOwnNFT, CoOwnNFT__factory, Vault, VaultFactory, VaultFactory__factory, Vault__factory } from "../typechain"
import { expandTo18Decimals } from "./utilities/utilities"

describe("Test", ()=>{

    let owner : SignerWithAddress
    let signers : SignerWithAddress[]
    let nft : CoOwnNFT
    let factory : VaultFactory
    let vault : Vault

    beforeEach(async()=>{
        signers = await  ethers.getSigners();
        owner = signers[0];
        nft = await new CoOwnNFT__factory(owner).deploy();
        factory = await new VaultFactory__factory(owner).deploy();
        vault = await new Vault__factory(owner).deploy();
        await factory.connect(owner).initialize(vault.address);
        await nft.connect(owner).initialize("CoOwned","COW",factory.address);
    })

    it("Test add property", async()=>{
        await nft.connect(owner).addProperty("House","HOW","HOUSE",4,expandTo18Decimals(3));
        console.log("Property: ", await nft.Properties(1));
        await nft.connect(signers[1]).buyFraction(1,2,{value: expandTo18Decimals(6)});
        console.log("Fractions Sold", await nft.Properties(1));
        await nft.connect(owner).addProperty("House","HOW","HOUSE",4,expandTo18Decimals(3));
        console.log("Property: ", await nft.Properties(2));
        console.log("Total properties listed",await nft.totalPropertiesListed(owner.address));
        console.log("Total properties owned",await nft.totalPropertiesOwned(signers[1].address));
        console.log("Fractions Owned", await nft.fractionsOwnedInProperty(1,signers[1].address));



    })

})
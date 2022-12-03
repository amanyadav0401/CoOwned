// import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers"
// import { ethers } from "hardhat"
// import { Alcazar, Alcazar__factory, Lottery, Lottery__factory } from "../typechain"
// import { expandTo18Decimals } from "./utilities/utilities"

// describe("Alcazar Lottery Testing",()=>{
//      let owner : SignerWithAddress
//      let signer : SignerWithAddress[]
//      let alcazar : Alcazar
//      let lottery : Lottery
     
//      beforeEach (async()=>{
//           signer = await ethers.getSigners();
//           owner = signer[0];
//           alcazar = await new Alcazar__factory(owner).deploy();
//           lottery = await new Lottery__factory(owner).deploy(alcazar.address);
//           console.log("AlcazarAddress",alcazar.address);


//           //Creating a raffle to start the staking for lottery rewards.
//           await lottery.connect(owner).createRaffle(10, false, expandTo18Decimals(1), 1669010831,1700546830,alcazar.address,2000);
//             let raffleStruct = await lottery.Raffle(1);
//             let raffleNo = await lottery.totalRaffles();
//             console.log("raffleNo : "+raffleNo,"details are :",raffleStruct);
//      })

//      describe("Lottery testing",async()=>{
        
//         it.only("Creating raffle", async()=>{
//             await lottery.connect(owner).createRaffle(10, false, expandTo18Decimals(1), 1669010831,1700546830,alcazar.address,2000);
//             let raffleStruct = await lottery.Raffle(1);
//             let raffleNo = await lottery.totalRaffles();
//             console.log("raffleNo : "+raffleNo,"details are :",raffleStruct);

//             await lottery.connect(owner).createRaffle(10,true,expandTo18Decimals(1),1669010831,1700546830,alcazar.address,3000);
//             let raffleStruct2 = await lottery.Raffle(2);
//             console.log("details are :",raffleStruct2);

//         })
        




//      })
    
// })
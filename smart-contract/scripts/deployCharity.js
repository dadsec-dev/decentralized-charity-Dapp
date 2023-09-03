const hre = require("hardhat");

async function main() {
    // const crowdfunding = await ethers.deployContract("charity");
    // const _crowdfunding = await crowdfunding.waitForDeployment();

    // console.log(`Crowdfunding address deployed to ${_crowdfunding.target}`);

    // const rewardToken = await ethers.deployContract("charityRewardToken");
    // const _rewardToken = await rewardToken.waitForDeployment("Charity Token", "CT");

    // console.log(`reward token address deployed to ${_rewardToken.target}`);


    // const DAO = await ethers.deployContract("charityDAO");
    // const _DAO = await DAO.waitForDeployment();

    // console.log(`DAO token address ${_DAO.target}`);

    // console.log(`verifying reward token address.....`);


    // await hre.run("verify:verify", {
    //     address: "0xD59B9D05b351EF8934EEb959027F8362857295FB",
    //     constructorArguments: []
    // });

    // console.log(`verification done. hurray!!`);

    // console.log(`.....`);

    // console.log(`verifying DAO token address.....`);

    // await hre.run("verify:verify", {
    //     address: "0x8C564032697D03815A2C42Cc385FcA371173e94C",
    //     constructorArguments: []
    // });

    // console.log(`verification done .. Hurray !!!`);

    // console.log(`.......`)

    // console.log(`veryfying Crowding address.....`)

    // await hre.run("verify:verify", {
    //     address: "0xdBD05b974D36c12fa941D0427DBfe1a5241DC18b",
    //     constructorArguments: []
    // });

    // console.log(`verification done...`)

    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);
  
    const charity = await ethers.deployContract("charity");
    const cAddress = await charity.getAddress();
  
    console.log("Token address:", cAddress);


    //https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-verify
    //npx hardhat verify --network sepolia 0x2F74ca1Ad1c5b66f48cC883412fD6d14D67F9E01
    //https://hardhat.org/tutorial/deploying-to-a-live-network



}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
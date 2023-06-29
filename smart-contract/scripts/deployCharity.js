const hre = require("hardhat");

async function main() {
    const crowdfunding = await ethers.deployContract("charity");
    const _crowdfunding = await crowdfunding.waitForDeployment();
    // await _crowdfunding.deployed();


    console.log(`Crowdfunding address deployed to ${_crowdfunding.target}`);

    await hre.run("verify:verify", {
        address: Contract.address,
        constructorArguments: []
    })


}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
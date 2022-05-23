const { ethers } = require("hardhat");


const main = async () => {
    const metadataURL = "ipfs://Qmbygo38DWF1V8GttM1zy89KzyZTPU2FLUzQtiDvB7q6i5/";

    const LW3PunksFactory = await ethers.getContractFactory("LW3Punks");
    const LW3Punks = await LW3PunksFactory.deploy(metadataURL);
    await LW3Punks.deployed();
    console.log(`LW3Token contract deployed to: ${LW3Punks.address}`);

    console.log("Sleeping...");

    await sleep(10000);

    await hre.run("verify:verify", {
        address: LW3Punks.address,
        constructorArguments: [metadataURL],
    });


}

function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    })
const { ethers, utils } = require("ethers");
const rpc_url = ""; // add your rpc here
const provider = new ethers.providers.JsonRpcProvider(rpc_url);

async function start() {
    const contractAddress = 123; // add your contract here
    const slot = 123; // add the storage slot of contract you want to access
    const data = await provider.getStorageAt(contractAddress, slot);
    console.log(data);
}

start();

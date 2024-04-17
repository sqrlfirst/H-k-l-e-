const { verify } = require("@nomiclabs/hardhat-etherscan");

const 

async function main() {
    // TODO 
    // 1. get Contracts through JSON objects
    // { ShitCoin: "0x228...228"}
    // 2. format comparison results as 
    //  ShitCoin: - Contract is the same
    //            - Contract is not found 
    //            

    
    const contractAddress = "0x..."; // Deployed contract address
    const contractName = "MyContract"; // Contract name in Hardhat project

    await verify(contractName, contractAddress);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

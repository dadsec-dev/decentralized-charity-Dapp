// import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");


require('dotenv').config();

const {PRIVATE_KEY_1, PRIVATE_KEY_2, ETHERSCAN_APIKEY} = process.env;

module.exports = {

  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },

  defaultNetwork: "sepolia",
  networks: {
    hardhat: {},
    sepolia: {
      url: `https://sepolia.infura.io/v3/8bc6a127f3f44587a87c232219da3876`,
      accounts: [PRIVATE_KEY_1, PRIVATE_KEY_2],
    },




},

etherscan: {
  apiKey: process.env.ETHERSCAN_APIKEY
}
}

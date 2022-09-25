require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config({ path: ".env" });

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;

const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY;

module.exports = {
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  networks: {
    goerli: {
      url: ALCHEMY_API_KEY_URL,
      accounts: [GOERLI_PRIVATE_KEY],
    },
    
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },

};
require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-etherscan");


const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const POLYGOSCAN_KEY = process.env.POLYGOSCAN_KEY;


/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    mumbai: {
      url: ALCHEMY_API_KEY_URL,
      accounts: [PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: {
      polygonMumbai: POLYGOSCAN_KEY,
    }
  }
};

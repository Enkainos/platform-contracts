/**
 * More information about configuration can be found at:
 * https://trufflesuite.com/docs/advanced/configuration
 */

require('dotenv').config();
const goerliMnemonic = process.env["GOERLI_MNEMONIC"];
const infuraKey = process.env["INFURA_KEY"];
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  contracts_build_directory: './build/ethereum-contracts',
  contracts_directory: './contracts',

  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    local_ethereum: {
      network_id: 31337,
      host: '127.0.0.1',
      port: 9545,
      gasPrice: 0
    },
    // goerli: {
    //   network_id: 5,
    //   chain_id: 5,
    //   provider: function() {
    //     return new HDWalletProvider(goerliMnemonic, "https://goerli.infura.io/v3/" + infuraKey, 0, 1);
    //   }
    // },
    dashboard: {
      host: "127.0.0.1",
      port: 24012,
      network_id: "*"
    }
  },

  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.13",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },
  db: {
    enabled: false
  }
};

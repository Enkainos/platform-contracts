# Enkainos Platform Smart Contracts

- [Setup](#setup)
  * [Using the .env File](#using-the-env-file)
  * [New Configuration File](#new-configuration-file)
  * [New Directory Structure for Artifacts](#new-directory-structure-for-artifacts)
- [Optimistic Ethereum](#optimistic-ethereum)
  * [Compiling](#compiling)
  * [Migrating](#migrating)
  * [Basic Commands](#basic-commands)
  * [Testing](#testing)
  * [Communication Between Ethereum and Optimism Chains](#communication-between-ethereum-and-optimism-chains)
- References
  * [Optimism](http://community.optimism.io/docs/developers)
  * [OP vs ETH compiler](https://github.com/ethereum-optimism/solidity/compare/27d51765c0623c9f6aef7c00214e9fe705c331b1...develop-0.6).

## Setup

Ensure you have truffle installed.
```npm install --global truffle```

### Using the env File

You will need at least one mnemonic to use with the network. The `.dotenv` npm package has been installed for you, and you will need to create a `.env` file for 
storing your mnemonic and any other needed private information. You can access it from other files with `require('dotenv').config()` and refer to the variable 
you need with `process.env['<YOUR_VARIABLE>']`.

1) Copy the `.env.example` file to `.env`
2) Open the `.env` file in your preferred IDE or text editor
3) Fill in the required values and save the file - this `.env` file will be ignored by git.

### New Configuration File

A new configuration file exists in this project: `truffle-config.ovm.js`. This file contains a reference to the new file location of the `contracts_build_directory` and `contracts_directory` for Optimism contracts and lists several networks for running the Optimism Layer 2 network instance (see [below](#migrating)).

Please note, the classic `truffle-config.js` configuration file is included here as well, because you will eventually want to deploy contracts to Ethereum as well. All normal truffle commands (`truffle compile`, `truffle migrate`, etc.) will use this config file and save built files to `build/ethereum-contracts`. You can save Solidity contracts that you wish to deploy to Ethereum in the `contracts/ethereum` folder.

### New Directory Structure for Artifacts

When you compile or migrate, the resulting `json` files will be at `build/optimism-contracts/`. This is to distinguish them from any Ethereum contracts you build, which will live in `build/ethereum-contracts`. As we have included the appropriate `contracts_build_directory` in each configuration file, Truffle will know which set of built files to reference!

## Optimistic Ethereum

### Compiling

To compile your code for Optimistic Ethereum, run the following in your terminal:

```
npm run compile:ovm
```

This script lets Truffle know to use the `truffle-config.ovm.js` configuration file, which references the directory in which we'll save your compiled contracts. When adding new contracts to compile, you may find some discrepancies and errors, so please remember to keep an eye on [differences between solc and optimistic solc](https://github.com/ethereum-optimism/solidity/compare/27d51765c0623c9f6aef7c00214e9fe705c331b1...develop-0.6)!

If you would like to recompile previously compiled contracts, you can manually run this command with `truffle compile --config truffle-config.ovm.js` and add the `--all` flag.

### Migrating

To migrate on an Optimistic Layer 2, run:

```
npm run migrate:ovm --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)
```

(remember to choose a network from these options!).

You have several Optimistic Layer 2 networks to choose from, prepackaged in this box (note: Layer 1 networks associated with Optimism are included in the regular `truffle-config.js` file, to aid you with further development. But here we'll just go through the Layer 2 deployment options available):

- `optimistic_ethereum`: This network is the default Layer 1/Layer 2 integration provided by Optimism for testing your Optimistic Ethereum code. Documentation about this setup can be found [here](https://github.com/ethereum-optimism/optimism).
  * You will need to install the code for this network in this box in order to use the scripts associated with it. To install it, run `npm run installLocalOptimism`. You should only need to run this initiation command once. It will create an `optimism` directory in this project that will house the repository you need. If at any point you want to update to the latest optimism docker image, you can delete your `optimism` directory and run this command again.
  * If you wish to use this network, be sure to run `npm run startLocalOptimism` so that the optimism test ecosystem docker image can be served. For our purposes, you should be able to compile, migrate, and test against this network once the docker image is fully running. See [documentation and updates](https://github.com/ethereum-optimism/optimism/tree/develop/ops) about this docker container for additional information.
  * Please note, after running `npm run startLocalOptimism` it can take several minutes for the test ecosystem to be up and running on your local machine. The first time you run this command, it will take a bit longer for everything to be set up. Future runs will be quicker!
  * To stop the local docker container, use `npm run stopLocalOptimism` in a new terminal tab to ensure graceful shutdown.
- `ganache`: This network uses an optimistic ganache instance for migrations. The usage is essentially identical to use of regular ganache. *Note:* This optimistic ganache instance is no longer actively maintained. We recommend using `optimistic_ethereum` for local testing. Stay tuned for additional ganache resources in the future!
- `optimistic_goerli`: Optimism has deployed a testnet to the Goerli network. The RPC endpoint is https://optimism-goerli.infura.io/v3/. In order to access this node for testing, you will need to connect a wallet (we suggest [MetaMask](https://metamask.io/)). Save your seed phrase in a `.env` file as `GOERLI_MNEMONIC`. Using an `.env` file for the mnemonic is safer practice because it is listed in `.gitignore` and thus will not be committed.
  * You will need Goerli ETH in an Optimistic Goerli wallet to deploy contracts using this network. In order to deploy to Optimistic Goerli, you will need to acquire Optimistic Goerli ETH. As of this writing, there is not an Optimistic Goerli ETH faucet. In order to get Optimistic Goerli ETH, follow these steps:
    1) Acquire ETH for your Goerli wallet on MetaMask using a [Goerli faucet](https://faucet.paradigm.xyz/).
    2) Optimism's gateway still doesn't support Goerli, but if you transfer Goerli ETH to [0x636Af16bf2f682dD3109e60102b8E1A089FedAa8](https://goerli.etherscan.io/address/0x636Af16bf2f682dD3109e60102b8E1A089FedAa8) (opens new window), you will get it on Optimistic Goerli.

  _Note: You may get an error about the block limit being exceeded. The Truffle team is working on this issue, but in the meantime you can add this line before the deployment in your `migrations/1_deploy_contracts.js` file: `SimpleStorage.gasMultiplier = 0.9;`_

Layer 1 networks are included in the `truffle-config.js` file, but it is not necessary to deploy your base contracts to Layer 1 right now. Eventually, you will likely have a Layer 2 contract that you want to connect with a Layer 1 contract (they do not have to be identical!). One example is an ERC20 contract that is deployed on an Optimistic Ethereum network. At some point the user will wish to withdraw their funds into Ethereum. There will need to be a contract deployed on Layer 1 that can receive the message from Layer 2 to mint the appropriate tokens on Layer 1 for the user. More information on this system can be found [here](http://community.optimism.io/docs/developers/integration.html#bridging-l1-and-l2).

If you would like to migrate previously migrated contracts on the same network, you can run `truffle migrate --config truffle-config.ovm.js --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)` and add the `--reset` flag.

## Basic Commands

The code here will allow you to compile, migrate, and test your code against an Optimistic Ethereum instance. The following commands can be run (more details on each can be found in the next section):

 To compile:
 ```
 npm run compile:ovm
 ```

 To migrate:
 ```
 npm run migrate:ovm --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)
 ```

 To test:
 ```
 npm run test:ovm --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)
 ```

 To run a script:
 ```
 npm run exec:ovm script --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)
 ```
Using `truffle exec` gives your script access to the instance of web3 you have running, via `web3`, and also includes your contracts as global objects when executing the script. 
For more information on this command, see [here](https://trufflesuite.com/docs/truffle/reference/truffle-commands/#exec).  

### Testing

Currently, this box supports testing via Javascript/TypeScript tests. In order to run the test currently in the boilerplate, use the following command:

```
npm run test:ovm --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)
```

Remember that there are some differences between the EVM and the OVM, and refer to the Optimism documentation if you run into test failures.

### Running Scripts

You can write scripts that have access to your Truffle configuration and a web3 instance that is connected to the network indicated using `truffle exec` using the following command:

```
npm run exec:ovm script --network=(ganache | optimistic_ethereum | optimistic_goerli | dashboard)
```

Remember that there are some differences between the EVM and the OVM, and refer to the Optimism documentation if you run into failures.

### Communication Between Ethereum and Optimism Chains

The information above should allow you to deploy to the Optimism Layer 2 chain. This is only the first step! Once you are ready to deploy your own contracts to function on Layer 1 using Layer 2, 
you will need to be aware of the [ways in which Layer 1 and Layer 2 interact in the Optimism ecosystem](https://community.optimism.io/docs/developers/bridge/messaging). We have 
an [Optimism Bridge Box](https://trufflesuite.com/blog/introducing-the-optimism-bridge-truffle-box/?utm_source=github&utm_medium=devcommunity&utm_campaign=2022_Jul_optimism-box-readme_tutorial_content) that 
shows you just how to do that!
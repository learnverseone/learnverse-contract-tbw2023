## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

### Testnet deploy

# run opbnb in local

```
anvil --balance 1000000000 --fork-url https://opbnb-testnet-rpc.bnbchain.org --chain-id 5611 --fork-block-number 15471590 --block-base-fee-per-gas 0
```

deploy to local

```
forge script script/MysteryBoxMinter.s.sol --rpc-url http://127.0.0.1:8545 --legacy --broadcast
```

```
cast send minter_contract_addresss "mint(address,uint256)" my_wallet_address 1 --rpc-url http://127.0.0.1:8545 --private-key <pk>
```

# Deploy to testnet

```
source .env
forge script script/MysteryBoxMinter.s.sol --rpc-url $OPBNB_TESTNET_RPC_URL --broadcast --legacy --verify
```

MysteryBox: 0x6Ba65778cc154856C17aC9685B2d80a5a091e68b
Minter: 0x2e14DaCAcAc28DFeD1dCfa3AeBa1B3333B8D78A1

```
$ cast send 0x7F842217F90ac9B48C5dB2C9791FF5c7C952369c "mint(address,uint256)" 0x34f4a12863Cc75DCd961590AC9FfdFBe18eb3bde 1 --rpc-url https://opbnb-testnet-rpc.bnbchain.org --private-key <pk>
```

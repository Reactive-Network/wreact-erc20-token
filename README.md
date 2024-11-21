# Foundry

Foundry is a blazing fast, portable and modular toolkit for Ethereum application development, written in Rust.

## Foundry components

- **Forge**: An Ethereum testing framework, similar to Truffle, Hardhat, and DappTools.
- **Cast**: A Swiss army knife for interacting with EVM smart contracts, sending transactions, and retriving blockchain data.
- **Anvil**: A local Ethereum node, comparable to Ganache or Hardhat Network.
- **Chisel**: A fast, utilitarian, and verbose solidity REPL (Read-Eval-Print Loop).

## Documentation

Find detailed documentation at [Foundry Book](https://book.getfoundry.sh/).

## Usage Commands

### Build

```bash
forge build
```

### Test

```bash
forge test
```

### Format Code

```bash
forge fmt
```

### Gas Snapshots

```bash
forge snapshot
```

### Run a Local Node

```bash
anvil
```

### Deploy a Contract

```bash
forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Use Cast

```bash
cast <subcommand>
```

### Get Help

```bash
forge --help
anvil --help
cast --help
```

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/*
*     ____  _________   _________________    ________
*    / __ \/ ____/   | / ____/_  __/  _/ |  / / ____/
*   / /_/ / __/ / /| |/ /     / /  / / | | / / __/
*  / _, _/ /___/ ___ / /___  / / _/ /  | |/ / /___
* /_/ |_/_____/_/  |_\____/ /_/ /___/  |___/_____/
*
* This file is part of Reactive Network, an interoperability solution and ecosystem
* that closes the reactivity gap in blockchain technology.
* It enables smart contracts (and analogues in non-EVM ecosystems)
* to operate based on previously unactionable events.
*
* Developers, developers, developers, developers, developers! (c) Steven Anthony Ballmer
*
* @title WrappedReact
* @author PARSIQ Technologies Pte Ltd
* @notice This Smart Contract represents wrapped, ERC20 version of native $REACT coin and can only be minted by authorized bridge / minter when funds are deposited & locked on Reactive Network.
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {AuthorizedMinter} from "./AuthorizedMinter.sol";

contract WrappedReact is ERC20, Ownable, AuthorizedMinter {
    constructor() ERC20("Wrapped REACT", "wREACT") Ownable(msg.sender) {}

    function authorizeMinter(address minter) public onlyOwner {
        _authorizeMinter(minter);
    }

    function deAuthorizeMinter(address minter) public onlyOwner {
        _deAuthorizeMinter(minter);
    }

    function mint(address to, uint256 amount) public onlyAuthorizedMinter {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyAuthorizedMinter {
        _burn(from, amount);
    }
}

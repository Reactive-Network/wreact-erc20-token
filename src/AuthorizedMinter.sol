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
* @author PARSIQ Technologies Pte Ltd
*/

import "@openzeppelin/contracts/utils/Context.sol";

abstract contract AuthorizedMinter is Context {
    mapping(address => bool) public authorizedMinters;

    event MinterAuthorized(address minter);
    event MinterDeAuthorized(address minter);

    error MinterAlreadyAuthorized(address);
    error MinterAlreadyDeAuthorized(address);

    error MinterUnauthorized(address);

    modifier onlyAuthorizedMinter() {
        __checkAuthorizedMinter();
        _;
    }

    function __checkAuthorizedMinter() internal view virtual {
        if (!authorizedMinters[_msgSender()] == true) {
            revert MinterUnauthorized(_msgSender());
        }
    }

    function _authorizeMinter(address minter) internal {
        if (authorizedMinters[minter]) {
            revert MinterAlreadyAuthorized(minter);
        }

        authorizedMinters[minter] = true;

        emit MinterAuthorized(minter);
    }

    function _deAuthorizeMinter(address minter) internal {
        if (!authorizedMinters[minter]) {
            revert MinterAlreadyDeAuthorized(minter);
        }

        authorizedMinters[minter] = false;

        emit MinterDeAuthorized(minter);
    }
}

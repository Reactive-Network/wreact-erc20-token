// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/utils/Context.sol";

abstract contract AuthorizedMinter is Context {
    mapping(address => bool) public authorizedMinters;

    event MinterAuthorized(address minter);
    event MinterDeAuthorized(address minter);

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
        authorizedMinters[minter] = true;

        emit MinterAuthorized(minter);
    }

    function _deAuthorizeMinter(address minter) internal {
        authorizedMinters[minter] = false;

        emit MinterDeAuthorized(minter);
    }
}

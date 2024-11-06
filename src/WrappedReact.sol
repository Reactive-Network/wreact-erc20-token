// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./AuthorizedMinter.sol";

contract WrappedReact is ERC20, Ownable, AuthorizedMinter {
    constructor()
        ERC20("Wrapped REACT", "wREACT")
        Ownable(msg.sender)
    {}

    function authorizeMinter(address minter) public onlyOwner {
        _authorizeMinter(minter);
    }

    function deAuthorizeMinter(address minter) public onlyOwner {
        _deAuthorizeMinter(minter);
    }
 
    function mint(address to, uint256 amount) public onlyAuthorizedMinter {
        _mint(to, amount);
    }

    function burn(address from, uint amount) public onlyAuthorizedMinter {
        _burn(from, amount);
    }
}

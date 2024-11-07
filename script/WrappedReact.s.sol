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

import {Script} from "forge-std/Script.sol";
import {WrappedReact} from "../src/WrappedReact.sol";

contract WrappedReactDeployer is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        new WrappedReact();
        vm.stopBroadcast();
    }
}

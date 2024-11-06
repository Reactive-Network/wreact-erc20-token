// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {WrappedReact} from "../src/WrappedReact.sol";
import {Test} from "forge-std/Test.sol";

contract WrappedReactTest is Test {
    event MinterAuthorized(address minter);
    event MinterDeAuthorized(address minter);

    // random addresses from etherscan
    // not related / significant to project in any way
    address someAddress = 0x95222290DD7278Aa3Ddd389Cc1E1d165CC4BAfe5;
    address otherAddress = 0x23f4569002a5A07f0Ecf688142eEB6bcD883eeF8;

    WrappedReact token;

    function setUp() public {
        token = new WrappedReact();
    }

    function testFail_AuthorizeOnlyByOwner() public {
        vm.prank(someAddress);

        token.authorizeMinter(otherAddress);
    }

    function testFail_DeAuthorizeOnlyByOwner() public {
        vm.prank(someAddress);

        token.deAuthorizeMinter(otherAddress);
    }

    function test_AuthorizeActorAndMint() public {
        vm.expectEmit();
        emit MinterAuthorized(someAddress);
        token.authorizeMinter(someAddress);

        vm.prank(someAddress);

        token.mint(otherAddress, 200 * (10 ** 18));
    }

    function test_DeAuthorizeActor() public {
        token.authorizeMinter(someAddress);

        vm.expectEmit();
        emit MinterDeAuthorized(someAddress);
        token.deAuthorizeMinter(someAddress);
    }

    function testFail_MintByNonAuthorizedActor() public {
        token.mint(otherAddress, 200);
    }
}

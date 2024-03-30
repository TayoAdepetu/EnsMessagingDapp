// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {EnsChat} from "../contracts/EnsChat.sol";

contract EnsChatTest is Test {
    EnsChat _EnsChat;

    address A = address(0xa);
    address B = address(0xb);
    address C = address(0xc);

    function setUp() public {
        _EnsChat = new EnsChat();

        A = mkaddr("user A");
        B = mkaddr("user B");
        C = mkaddr("user C");
    }

    function testRegisterNameService() public {
        switchSigner(A);

        _EnsChat.registerNameService("test", "test");
        assert(_EnsChat.nameToAddress("test") != address(0));

        (string memory _domainName, , address _owner) = _EnsChat
            .getEnsDetails("test");
        assert(
            keccak256(abi.encodePacked(_domainName)) ==
                keccak256(abi.encodePacked("test"))
        );
        assert(_owner == A);
    }

    function testRegisterNameServiceEmitEvent() public {
        switchSigner(A);

        // assert event emitted
        vm.expectEmit(true, true, false, false);
        _EnsChat.registerNameService("test", "test");
    }

    function testRegisterNameTwiceRevert() public {
        switchSigner(A);

        _EnsChat.registerNameService("test", "test");

        switchSigner(B);
        // assert revert
        vm.expectRevert(
            abi.encodeWithSelector(LibENSErrors.EnsAlreadyTaken.selector)
        );
        _EnsChat.registerNameService("test", "avatarTest");
    }

    function testGetDomainDetails() public {
        switchSigner(A);
        _EnsChat.registerNameService("test", "test");

        (
            string memory _domainName,
            string memory _avatarURI,
            address _owner
        ) = _EnsChat.getEnsDetails("test");

        assert(
            keccak256(abi.encodePacked(_domainName)) ==
                keccak256(abi.encodePacked("test"))
        );
        assert(
            keccak256(abi.encodePacked(_avatarURI)) ==
                keccak256(abi.encodePacked("test"))
        );
        assert(_owner == A);
    }

    function testGetDomainDetailsFailForUnregisteredDomains() public {
        vm.expectRevert(
            abi.encodeWithSelector(LibENSErrors.EnsNotRegistered.selector)
        );
        _EnsChat.getEnsDetails("test");
    }

    function testUpdateAvatarURI() public {
        switchSigner(A);
        _EnsChat.registerNameService("test", "test");

        _EnsChat.updateEnsDP("test", "ipfs://newAvatar.jpg");

        (, string memory _avatarURI, ) = _EnsChat.getEnsDetails(
            "test"
        );

        assert(
            keccak256(abi.encodePacked(_avatarURI)) ==
                keccak256(abi.encodePacked("ipfs://newAvatar.jpg"))
        );
    }
    function testUpdateAvatarURIFailWhenCalledForDomainNotOwned() public {
        _EnsChat.registerNameService("test", "test");

        switchSigner(A);

        vm.expectRevert(
            abi.encodeWithSelector(LibENSErrors.NotEnsOwner.selector)
        );
        _EnsChat.updateEnsDP("test", "ipfs://newAvatar.jpg");
    }

    function testUpdateAvatarURIFailForUnregigsteredDomains() public {
        switchSigner(A);

        vm.expectRevert(
            abi.encodeWithSelector(LibENSErrors.EnsNotRegistered.selector)
        );
        _EnsChat.updateEnsDP("test", "ipfs://newAvatar.jpg");
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
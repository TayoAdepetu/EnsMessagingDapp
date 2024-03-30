// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../contracts/TeeWhyChat.sol";
import "../contracts/EnsChat.sol";

contract TeeWhyChatScript is Script {
    EnsChat _EnsChat;
    TeeChat _TeeChat;
    function setUp() public {}

    function run()  external {
        vm.startBroadcast();

        _EnsChat = new EnsChat();

        _TeeChat = new TeeChat(address(_EnsChat));

        console2.log(address(_EnsChat));
        console2.log(address(_TeeChat));
    

        vm.stopBroadcast();
    }
}
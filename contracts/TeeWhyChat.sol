// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TeeWhyChat {

    struct TheChat {
        address sender; 
        string content; 
        uint256 timestamp; 
    }

    mapping(string => TheChat[]) public userChatHistory;

    function sendMessage(string memory username, string memory content) public {
        TheChat memory message = TheChat({
            sender: msg.sender,
            content: content,
            timestamp: block.timestamp
        });
        
        userChatHistory[username].push(message);
    }

    function getChatHistory(string memory username) public view returns (TheChat[] memory) {
        return userChatHistory[username];
    }
}

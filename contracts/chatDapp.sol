// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ChatDapp {
    // Struct to represent a message

    struct ChatMe {
        address sender; // Address of the sender
        string content; // Content of the message
        uint256 timestamp; // Timestamp when the message was sent
    }

    // Mapping of user ENS names to their chat history
    mapping(string => ChatMe[]) public chatHistory;

    // Function to send a message to another user
    function sendMessage(string memory recipientENSName, string memory content) public {
        // Create a new message object
        ChatMe memory message = ChatMe({
            sender: msg.sender,
            content: content,
            timestamp: block.timestamp
        });
        
        // Add the message to recipient's chat history
        chatHistory[recipientENSName].push(message);
    }

    // Function to retrieve chat history for a user
    function getChatHistory(string memory userENSName) public view returns (ChatMe[] memory) {
        return chatHistory[userENSName];
    }
}

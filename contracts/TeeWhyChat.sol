// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./IENS.sol";

contract TeeWhyChat {
    struct Message {
        string content;
        string sender;
        string recipient;
    }

    IENS internal ENS;

    // Mapping from a concatenated string of sender and recipient names to an array of messages
    mapping(string => Message[]) public conversations;

    // string conversationId;

    constructor(address _ensAddress) {
        ENS = IENS(_ensAddress);
    }

    function sendMessage(string memory content, string memory recipient)
        public
    {
        string memory _sender = ENS.getNameByAddress(msg.sender);
        string memory conversationId = string.concat(_sender, recipient);
        // conversationId =  _sender + recipient ;

        // Create a new message
        Message memory newMessage = Message({
            content: content,
            sender: _sender,
            recipient: recipient
        });

        // Add the message to the conversation
        string memory _reverseConversationId = string.concat(
            recipient,
            _sender
        );

        if (conversations[_reverseConversationId].length > 0) {
            conversations[_reverseConversationId].push(newMessage);
        } else {
            conversations[conversationId].push(newMessage);
        }
    }

    function getMessages(string memory _sender, string memory _recipient)
        public
        view
        returns (Message[] memory)
    {
        string memory _conversationId = string.concat(_sender, _recipient);
        string memory _reverseConversationId = string.concat(
            _recipient,
            _sender
        );

        if (conversations[_reverseConversationId].length > 0) {
            return conversations[_reverseConversationId];
        } else {
            return conversations[_conversationId];
        }
    }
}
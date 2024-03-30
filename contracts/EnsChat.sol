// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EnsChat {
    struct UserData {
        string name;
        string imageIPFSHash;
        string email;
        string gender;
    }
    //mapping of ENS names to user data
    mapping(string => UserData) public users;

    //events that will trigger when a new user registers
    event UserRegistered(
        string indexed ensName,
        string name,
        string imageIPFSHash,
        string email
    );

    constructor() {}

    // Function to register a new ENS name with associated user data
    function registerUser(
        string memory ensName,
        string memory name,
        string memory imageIPFSHash,
        string memory email
    ) public {
        require(
            bytes(users[ensName].name).length == 0,
            "ENS name already registered"
        );
        users[ensName] = UserData(ensName, name, imageIPFSHash, email);
        emit UserRegistered(ensName, name, imageIPFSHash, email);
    }

    // Function to update user data
    function updateUser(
        string memory ensName,
        string memory name,
        string memory imageIPFSHash,
        string memory email
    ) public {
        require(
            bytes(users[ensName].name).length != 0,
            "ENS name not registered"
        );
        users[ensName].name = name;
        users[ensName].imageIPFSHash = imageIPFSHash;
        users[ensName].email = email; // Update email field
    }

    // Function to retrieve user data based on ENS name
    function getUserData(
        string memory ensName
    ) public view returns (string memory, string memory, string memory) {
        return (
            users[ensName].name,
            users[ensName].imageIPFSHash,
            users[ensName].email
        );
    }
}

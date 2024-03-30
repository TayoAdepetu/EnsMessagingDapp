// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EnsChat {
    struct UserInfo {
        string name;
        string imageUrl;
        address userAddress;
    }

    mapping(string => address) public ensMapping;
    mapping(address => UserInfo) public userMapping;
    mapping(address => string) public reverseEnsMapping;
    UserInfo[] public users;

    modifier nameAndUserNotExists(string memory name) {
        require(ensMapping[name] == address(0), "Name already in use");
        require(bytes(reverseEnsMapping[msg.sender]).length == 0, "User already created");
        _;
    }

    function createENS(string memory name, string memory imageUrl) public nameAndUserNotExists(name) {
        UserInfo memory userInfo = UserInfo(name, imageUrl, msg.sender);
        ensMapping[name] = msg.sender;
        userMapping[msg.sender] = userInfo;
        reverseEnsMapping[msg.sender] = name;

        users.push(userInfo);
    }

    function getAddressByName(string memory name) public view returns (address) {
        return ensMapping[name];
    }

    function getNameByAddress(address addr) public view returns (string memory) {
        return reverseEnsMapping[addr];
    }

    function getUserInfo(address addr) public view returns (string memory, string memory) {
        UserInfo memory userInfo = userMapping[addr];
        return (userInfo.name, userInfo.imageUrl);
    }

    function getUserInfoByName(string memory name) public view returns (string memory, string memory) {
        address addr = ensMapping[name];
        require(addr != address(0), "Name does not exist");
        UserInfo memory userInfo = userMapping[addr];
        return (userInfo.name, userInfo.imageUrl);
    }

    function userExists(address addr) public view returns (bool) {
        return bytes(reverseEnsMapping[addr]).length != 0;
    }

    function nameExists(string memory name) public view returns (bool) {
        return ensMapping[name] != address(0);
    }

    function getAllUsers() public view returns (UserInfo[] memory) {
        return users;
    }
}
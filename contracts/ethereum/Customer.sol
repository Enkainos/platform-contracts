// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Customer {
  string[] private name;

  function setName(string memory _name, uint256 calldata id) public {
    name[id] = _name;
  }

  function getName(uint256 calldata id) public view returns (string memory) {
    return name[id];
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Material { //access control - only Enkainos can add new materials
  string[] private name;
  string[] private measuredIn;

  function setName(string memory _name, uint256 calldata id) public {
    name[id] = _name;
  }

  function getName(uint256 calldata id) public view returns (string memory) {
    return name[id];
  }
}

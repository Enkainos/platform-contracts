// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface IMaterial is IAccessControl {

  function create(string memory _name, string memory _unit, uint8 _precision) external
  returns (uint256 materialId);

  function get(uint256 id) external view
  returns (string memory name, string memory unit, uint8 precision);
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ICustomer is IAccessControl {

  function create(string memory _name) external
  returns (uint256 customerId);

  function get(uint256 id) external view
  returns (string memory name, uint256[] memory operations);

  function addOperation(uint256 id, uint256 operationId) external;

  function removeOperation(uint256 id, uint256 index) external;
}

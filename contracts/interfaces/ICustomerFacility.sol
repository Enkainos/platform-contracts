// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ICustomerFacility is IAccessControl {

  function create(string memory _name, uint256 _customerId) external
  returns (uint256 customerFacilityId);

  function get(uint256 id) external view
  returns (string memory name, uint256 customerId);
}

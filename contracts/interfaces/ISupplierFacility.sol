// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ISupplierFacility is IAccessControl {

  function create(string memory _name, uint256 _supplierId) external
  returns (uint256 facilityId);

  function get(uint256 id) external view
  returns (string memory name, uint256 supplierId);
}

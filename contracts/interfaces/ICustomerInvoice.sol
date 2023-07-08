// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ICustomerInvoice is IAccessControl {

  function create(
    uint256 _customerId,
    uint256 _operationId,
    uint256 _facilityId,
    uint256[] memory _materials,
    uint256[] memory _quantities,
    uint256 _timestamp
  ) external
  returns (uint256 customerInvoiceId);

  function get(uint256 id) external view
  returns (
    uint256 customerId,
    uint256 operationId,
    uint256 facilityId,
    uint256[] memory materials,
    uint256[] memory quantities,
    uint256 timestamp
  );
}

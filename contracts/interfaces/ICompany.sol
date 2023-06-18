// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ICompany is IAccessControl {
    function create(string memory _name) external
    returns (uint256 companyId);

    function get(uint256 id) external view
    returns (string memory name);
}
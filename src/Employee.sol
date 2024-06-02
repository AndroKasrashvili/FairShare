//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {OrgUnit} from "./OrgUnit.sol";

contract Employee {
    address employeeAddress;
    OrgUnit unit;
    bool isHead;
}

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Employee} from "./Employee.sol";

contract OrgUnit {
    OrgUnit[] children; // department1, 2 ...
    Employee headOfUnit;
    OrgUnit parent;
    //roles //responsibilities
    string name; //fairshare
    Employee[] employees;
}

// pragma solidity ^0.8.19;

// //import {OrgUnit} from "./OrgUnit.sol";
// contract Organization {
//     string private s_name;

//     struct OrgUnit {
//         uint256[] childrenUnits; // ids of units(department1, 2 ...)
//         uint256 headOfUnit; // id of employee who is head of unit (0 means not assigned)
//         uint256 parentUnit; //id of parent unit (0 means not assigned)
//         //roles //responsibilities
//         string name; //fairshare
//         uint256[] employees; //list of employee ids who work in the unit
//         // Role[] roles;
//         bool active;
//     }

//     struct Employee {
//         address payable employeeAddress;
//         uint256 unitId;
//         uint256[] roles; //employee role ids
//         bool active;
//     }

//     struct Responsibility {
//         string name;
//         bool active;
//     }

//     struct Role {
//         uint256[] responsibilities; //list of responsibility ids assigned to role
//         string name;
//         bool active;
//     }

//     mapping(uint256 => OrgUnit) private s_units;
//     uint256 private s_unitCounter;

//     mapping(uint256 => Employee) private s_employees;
//     uint256 private s_employeeCounter;

//     mapping(uint256 => Role) private s_roles;
//     uint256 private s_roleCounter;

//     mapping(uint256 => Responsibility) private s_responsibilities;
//     uint256 private s_responsibilityCounter;

//     constructor(string memory name) {
//         s_name = name;
//         s_unitCounter = 0;
//         s_employeeCounter = 1;
//         s_roleCounter = 1;
//         s_responsibilityCounter = 1;
//     }

//     function addResponsibility(string memory name) public returns (uint256 id) {
//         s_responsibilities[s_responsibilityCounter] = Responsibility(
//             name,
//             true
//         );
//         id = s_responsibilityCounter;
//         s_responsibilityCounter++;
//     }

//     function deleteResponsibility(uint256 responsibilityId) public {
//         s_responsibilities[responsibilityId].active = false;
//     }

//     function addEmployee(
//         address payable _employeeAddress
//     ) public returns (uint256 id) {
//         Employee memory employee;
//         employee.employeeAddress = _employeeAddress;
//         s_employees[s_employeeCounter] = employee;
//         id = s_employeeCounter;
//         s_employeeCounter++;
//     }
// }

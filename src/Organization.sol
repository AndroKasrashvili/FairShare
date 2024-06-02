// //SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Organization {
    string private s_name;

    struct OrgUnit {
        uint256[] childrenUnits;
        uint256 headOfUnit;
        uint256 parentUnit;
        string name;
        uint256[] employees;
        bool active;
    }

    struct Employee {
        address payable employeeAddress;
        uint256 unitId;
        uint256[] roles;
        bool active;
    }

    struct Responsibility {
        string name;
        bool active;
    }

    struct Role {
        uint256[] responsibilities;
        string name;
        bool active;
    }

    mapping(uint256 => OrgUnit) private s_units;
    uint256 private s_unitCounter;

    mapping(uint256 => Employee) private s_employees;
    uint256 private s_employeeCounter;

    mapping(uint256 => Role) private s_roles;
    uint256 private s_roleCounter;

    mapping(uint256 => Responsibility) private s_responsibilities;
    uint256 private s_responsibilityCounter;

    constructor(string memory name) {
        s_name = name;
        s_unitCounter = 1;
        s_employeeCounter = 1;
        s_roleCounter = 1;
        s_responsibilityCounter = 1;
    }

    // Add methods
    function addOrgUnit(
        uint256[] memory childrenUnits,
        uint256 headOfUnit,
        uint256 parentUnit,
        string memory name,
        uint256[] memory employees,
        bool active
    ) public returns (uint256 id) {
        s_units[s_unitCounter] = OrgUnit({
            childrenUnits: childrenUnits,
            headOfUnit: headOfUnit,
            parentUnit: parentUnit,
            name: name,
            employees: employees,
            active: active
        });
        id = s_unitCounter;
        s_unitCounter++;
    }

    function addEmployee(
        address payable employeeAddress,
        uint256 unitId,
        uint256[] memory roles,
        bool active
    ) public returns (uint256 id) {
        s_employees[s_employeeCounter] = Employee({
            employeeAddress: employeeAddress,
            unitId: unitId,
            roles: roles,
            active: active
        });
        id = s_employeeCounter;
        s_employeeCounter++;
    }

    function addResponsibility(
        string memory name,
        bool active
    ) public returns (uint256 id) {
        s_responsibilities[s_responsibilityCounter] = Responsibility({
            name: name,
            active: active
        });
        id = s_responsibilityCounter;
        s_responsibilityCounter++;
    }

    function addRole(
        uint256[] memory responsibilities,
        string memory name,
        bool active
    ) public returns (uint256 id) {
        s_roles[s_roleCounter] = Role({
            responsibilities: responsibilities,
            name: name,
            active: active
        });
        id = s_roleCounter;
        s_roleCounter++;
    }

    // Delete methods
    function deleteOrgUnit(uint256 unitId) public {
        s_units[unitId].active = false;
    }

    function deleteEmployee(uint256 employeeId) public {
        s_employees[employeeId].active = false;
    }

    function deleteResponsibility(uint256 responsibilityId) public {
        s_responsibilities[responsibilityId].active = false;
    }

    function deleteRole(uint256 roleId) public {
        s_roles[roleId].active = false;
    }

    // OrgUnit getters and setters
    function getOrgUnitChildrenUnits(
        uint256 unitId
    ) public view returns (uint256[] memory) {
        return s_units[unitId].childrenUnits;
    }

    function setOrgUnitChildrenUnits(
        uint256 unitId,
        uint256[] memory childrenUnits
    ) public {
        s_units[unitId].childrenUnits = childrenUnits;
    }

    function getOrgUnitHeadOfUnit(
        uint256 unitId
    ) public view returns (uint256) {
        return s_units[unitId].headOfUnit;
    }

    function setOrgUnitHeadOfUnit(uint256 unitId, uint256 headOfUnit) public {
        s_units[unitId].headOfUnit = headOfUnit;
    }

    function getOrgUnitParentUnit(
        uint256 unitId
    ) public view returns (uint256) {
        return s_units[unitId].parentUnit;
    }

    function setOrgUnitParentUnit(uint256 unitId, uint256 parentUnit) public {
        s_units[unitId].parentUnit = parentUnit;
    }

    function getOrgUnitName(
        uint256 unitId
    ) public view returns (string memory) {
        return s_units[unitId].name;
    }

    function setOrgUnitName(uint256 unitId, string memory name) public {
        s_units[unitId].name = name;
    }

    function getOrgUnitEmployees(
        uint256 unitId
    ) public view returns (uint256[] memory) {
        return s_units[unitId].employees;
    }

    function setOrgUnitEmployees(
        uint256 unitId,
        uint256[] memory employees
    ) public {
        s_units[unitId].employees = employees;
    }

    function getOrgUnitActive(uint256 unitId) public view returns (bool) {
        return s_units[unitId].active;
    }

    function setOrgUnitActive(uint256 unitId, bool active) public {
        s_units[unitId].active = active;
    }

    // Employee getters and setters
    function getEmployeeAddress(
        uint256 employeeId
    ) public view returns (address payable) {
        return s_employees[employeeId].employeeAddress;
    }

    function setEmployeeAddress(
        uint256 employeeId,
        address payable employeeAddress
    ) public {
        s_employees[employeeId].employeeAddress = employeeAddress;
    }

    function getEmployeeUnitId(
        uint256 employeeId
    ) public view returns (uint256) {
        return s_employees[employeeId].unitId;
    }

    function setEmployeeUnitId(uint256 employeeId, uint256 unitId) public {
        s_employees[employeeId].unitId = unitId;
    }

    function getEmployeeRoles(
        uint256 employeeId
    ) public view returns (uint256[] memory) {
        return s_employees[employeeId].roles;
    }

    function setEmployeeRoles(
        uint256 employeeId,
        uint256[] memory roles
    ) public {
        s_employees[employeeId].roles = roles;
    }

    function getEmployeeActive(uint256 employeeId) public view returns (bool) {
        return s_employees[employeeId].active;
    }

    function setEmployeeActive(uint256 employeeId, bool active) public {
        s_employees[employeeId].active = active;
    }

    // Responsibility getters and setters
    function getResponsibilityName(
        uint256 responsibilityId
    ) public view returns (string memory) {
        return s_responsibilities[responsibilityId].name;
    }

    function setResponsibilityName(
        uint256 responsibilityId,
        string memory name
    ) public {
        s_responsibilities[responsibilityId].name = name;
    }

    function getResponsibilityActive(
        uint256 responsibilityId
    ) public view returns (bool) {
        return s_responsibilities[responsibilityId].active;
    }

    function setResponsibilityActive(
        uint256 responsibilityId,
        bool active
    ) public {
        s_responsibilities[responsibilityId].active = active;
    }

    // Role getters and setters
    function getRoleResponsibilities(
        uint256 roleId
    ) public view returns (uint256[] memory) {
        return s_roles[roleId].responsibilities;
    }

    function setRoleResponsibilities(
        uint256 roleId,
        uint256[] memory responsibilities
    ) public {
        s_roles[roleId].responsibilities = responsibilities;
    }

    function getRoleName(uint256 roleId) public view returns (string memory) {
        return s_roles[roleId].name;
    }

    function setRoleName(uint256 roleId, string memory name) public {
        s_roles[roleId].name = name;
    }

    function getRoleActive(uint256 roleId) public view returns (bool) {
        return s_roles[roleId].active;
    }

    function setRoleActive(uint256 roleId, bool active) public {
        s_roles[roleId].active = active;
    }
}

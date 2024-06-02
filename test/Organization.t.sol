// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Organization.sol";
import "../script/DeployOrganization.s.sol";

contract OrganizationTest is Test {
    DeployOrganization private deployer;
    Organization private organization;
    address private addr1 = address(0x123);
    address private addr2 = address(0x456);

    function setUp() public {
        deployer = new DeployOrganization();
        organization = deployer.run();
    }

    function testAddAndGetResponsibility() public {
        uint256 responsibilityId = organization.addResponsibility(
            "Test Responsibility",
            true
        );

        string memory responsibilityName = organization.getResponsibilityName(
            responsibilityId
        );
        bool responsibilityActive = organization.getResponsibilityActive(
            responsibilityId
        );

        assertEq(responsibilityName, "Test Responsibility");
        assertTrue(responsibilityActive);

        organization.setResponsibilityName(
            responsibilityId,
            "Updated Responsibility"
        );
        organization.setResponsibilityActive(responsibilityId, false);

        string memory updatedResponsibilityName = organization
            .getResponsibilityName(responsibilityId);
        bool updatedResponsibilityActive = organization.getResponsibilityActive(
            responsibilityId
        );

        assertEq(updatedResponsibilityName, "Updated Responsibility");
        assertFalse(updatedResponsibilityActive);
    }

    function testAddAndGetEmployee() public {
        uint256[] memory roles = new uint256[](0);
        uint256 employeeId = organization.addEmployee(
            payable(addr1),
            0,
            roles,
            true
        );

        address payable employeeAddress = organization.getEmployeeAddress(
            employeeId
        );
        bool employeeActive = organization.getEmployeeActive(employeeId);

        assertEq(employeeAddress, addr1);
        assertTrue(employeeActive);

        organization.setEmployeeAddress(employeeId, payable(addr2));
        organization.setEmployeeActive(employeeId, false);

        address payable updatedEmployeeAddress = organization
            .getEmployeeAddress(employeeId);
        bool updatedEmployeeActive = organization.getEmployeeActive(employeeId);

        assertEq(updatedEmployeeAddress, addr2);
        assertFalse(updatedEmployeeActive);
    }

    function testSetAndGetOrgUnitProperties() public {
        uint256 unitId = 1;
        uint256[] memory childrenUnits = new uint256[](2);
        childrenUnits[0] = 2;
        childrenUnits[1] = 3;
        uint256[] memory employees = new uint256[](2);
        employees[0] = 1;
        employees[1] = 2;

        organization.addOrgUnit(
            childrenUnits,
            1,
            0,
            "Development",
            employees,
            true
        );

        uint256[] memory retrievedChildrenUnits = organization
            .getOrgUnitChildrenUnits(unitId);
        uint256 headOfUnit = organization.getOrgUnitHeadOfUnit(unitId);
        uint256 parentUnit = organization.getOrgUnitParentUnit(unitId);
        string memory name = organization.getOrgUnitName(unitId);
        uint256[] memory retrievedEmployees = organization.getOrgUnitEmployees(
            unitId
        );
        bool active = organization.getOrgUnitActive(unitId);

        assertEq(retrievedChildrenUnits.length, 2);
        assertEq(retrievedChildrenUnits[0], 2);
        assertEq(retrievedChildrenUnits[1], 3);
        assertEq(headOfUnit, 1);
        assertEq(parentUnit, 0);
        assertEq(name, "Development");
        assertEq(retrievedEmployees.length, 2);
        assertEq(retrievedEmployees[0], 1);
        assertEq(retrievedEmployees[1], 2);
        assertTrue(active);

        organization.setOrgUnitName(unitId, "Research");
        string memory updatedName = organization.getOrgUnitName(unitId);
        assertEq(updatedName, "Research");

        organization.deleteOrgUnit(unitId);
        bool updatedActive = organization.getOrgUnitActive(unitId);
        assertFalse(updatedActive);
    }

    function testSetAndGetRoleProperties() public {
        uint256 roleId = 1;
        uint256[] memory responsibilities = new uint256[](2);
        responsibilities[0] = 1;
        responsibilities[1] = 2;

        organization.addRole(responsibilities, "Manager", true);

        uint256[] memory retrievedResponsibilities = organization
            .getRoleResponsibilities(roleId);
        string memory name = organization.getRoleName(roleId);
        bool active = organization.getRoleActive(roleId);

        assertEq(retrievedResponsibilities.length, 2);
        assertEq(retrievedResponsibilities[0], 1);
        assertEq(retrievedResponsibilities[1], 2);
        assertEq(name, "Manager");
        assertTrue(active);

        organization.setRoleName(roleId, "Senior Manager");
        string memory updatedName = organization.getRoleName(roleId);
        assertEq(updatedName, "Senior Manager");

        organization.deleteRole(roleId);
        bool updatedActive = organization.getRoleActive(roleId);
        assertFalse(updatedActive);
    }
}

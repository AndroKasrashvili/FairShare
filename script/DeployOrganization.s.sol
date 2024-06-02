// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Organization} from "../src/Organization.sol";

contract DeployOrganization is Script {
    function run() public returns (Organization) {
        vm.startBroadcast();
        Organization organization = new Organization("My Org");
        vm.stopBroadcast();
        return organization;
    }
}

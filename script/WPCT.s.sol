// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import "../src/wPCTCollateral.sol";
import {CollateralConfig} from "../src/FiatCollateral.sol";
import {AggregatorV3Interface} from "../src/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract DeployWPCTScript is Script {
    AggregatorV3Interface internal priceFeed;
    IERC20Metadata internal wPCTToken;

    function setUp() public {
        priceFeed = AggregatorV3Interface(0xfD9D5D27Ea03e7Fd5D897F267518A8C396c7b483);
        wPCTToken = IERC20Metadata(0x414AC1853329b3704DF0caF7749Cd296C7f3b750);
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        CollateralConfig memory collateralConfig = CollateralConfig(
            604800,
            priceFeed,
            1,
            wPCTToken,
            1e6,
            3600,
            bytes32('USD'),
            2,
            86400
        );
        wPCTCollateral collateral = new wPCTCollateral(collateralConfig, 0);
        vm.stopBroadcast();
    }
}

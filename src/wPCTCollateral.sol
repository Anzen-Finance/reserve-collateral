// SPDX-License-Identifier: BlueOak-1.0.0
pragma solidity ^0.8.20;

import "./AppreciatingFiatCollateral.sol";
import "./libraries/Fixed.sol";

interface IWPCT {
    function exchangeRate() external view returns (uint256);
}

/**
 * @title wPCT Collateral
 * @notice Collateral plugin for wrapped PCT (wPCT)
 * tok = wPCT (non-rebasing ERC20)
 * ref = PCT
 * tar = USD
 * UoA = USD
 */
contract wPCTCollateral is AppreciatingFiatCollateral {
    // solhint-disable no-empty-blocks

    /// @param config.chainlinkFeed {UoA/ref} price of wPCT in USD terms
    constructor(CollateralConfig memory config, uint192 revenueHiding)
        AppreciatingFiatCollateral(config, revenueHiding)
    {}

    // solhint-enable no-empty-blocks

    /// @return {ref/tok} Actual quantity of whole reference units per whole collateral tokens
    function _underlyingRefPerTok() internal view override returns (uint192) {
        return toFix(IWPCT(address(erc20)).exchangeRate());
    }
}

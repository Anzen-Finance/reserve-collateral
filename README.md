# Anzen Wrapped Private Credit Token (wPCT) Collateral Plugin

For use of Anzen Private Credit Token as stablecoin collateral

## Summary

This plugin allows `wPCT` (Anzen Wrapped Private Credit Token) holders to use their tokens as collateral in the Reserve Protocol.

`wPCT` is a non-upgradeable ERC20 token that earns the user the right to an increasing quantity of Anzen Private Credit Token (PCT) over time. Anzen PCT is a rebasing ERC20 that earns yield from off-chain real world assets (RWA). It is always backed by 1 USD worth of real world assets as collateral. At all times, `wPCT` can be redeemed at the specified exchange rate for `PCT`. `wPCT` can be swapped on Uniwap via a `wPCT/USDC` pool, or can be redeemd for `PCT` which can subsequently be redeemed for 1 USDC from the protocol directly.

In the background, the Anzen protocol as a borrower of defi capital deploys deposited USDC in credit assets, and pays an interest rate to wPCT holders.

The redeemable PCT amount per wPCT can be retrieved by calling `exchangeRate()` on the wPCT contract deployed on Ethereum mainnet at `0x414ac1853329b3704df0caf7749cd296c7f3b750`.

No function needs be called in order to update `refPerTok()`. `totalAssets()` is already a function of the block timestamp and increases as time passes.

No rewards other than the ever-increasing exchange rate.

`wPCT` contract: <https://etherscan.io/token/0x414ac1853329b3704df0caf7749cd296c7f3b750#code>

## Implementation

### Units

| tok   | ref  | target | UoA |
| ----- | ---- | ------ | --- |
| wPCT  | PCT | USD    | USD |

### Functions

#### refPerTok {ref/tok}

`return divuu(IStakedFrax(address(erc20)).totalAssets(), IStakedFrax(address(erc20)).totalSupply());`
# Create an ERC20 Token

## Technologies

- Truffle

- Ganache

> All ERC 20 Tokens must define the following attributes and methods:

- **totalSupply:** Displays the total number of tokens that are currently in circulation.

- **balanceOf:** It takes an Ethereum address as a parameter and returns the tokens allocated to that address.

- **transfer:** Transfers tokens from one address to another at the request of respective token holders

- **transferFrom:** Used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies.

- **approve:** Approve an amount for a spender address to withdraw from your account.

- **allowance:** Returns the amount which a spender address is still allowed to withdraw from owner

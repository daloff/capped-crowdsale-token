## Daryna Aloff
## CSC 4980 | Blockchain & Applications | Assignment 3
### Description
This program builds a capped crowdsale with a mintable token using the openzeppelin library

### Prerequisites
* Please make sure you have the following components installed, in order to run this program:
    * [Node.js | npm](https://www.npmjs.com/get-npm)
        * *`npm`* is used to install components below
    * [Solidity](https://www.npmjs.com/package/solc)
    * [Truffle](https://www.npmjs.com/package/truffle)
    * [Openzeppelin](https://openzeppelin.org/)
* Please follow this [guide](https://medium.com/crowdbotics/how-to-build-a-simple-capped-crowdsale-token-using-openzeppelin-library-part-1-2789ec642308) that has instructions on how to install them.
    * Note that even thought the guide is using an older version of Solidity, 
* Once you have these components installed, you should see the following versions if *`truffle version`* command is run.
```sh
> truffle version
Truffle v5.0.7 (core: 5.0.7)
Solidity v0.5.0 (solc-js)
Node v11.11.0
```
-------
### Changes from Solidity 0.4.24 to 0.5.0
The guide uses an older version of Solidity (0.4.24), while this program uses a newer one (0.5.0). In order to make the new version work, it was necessary to modify some of the code and include these additional commands when running the program:

* *`let accounts = await web3.eth.getAccounts()`*
    * Initializes accounts for later use
* *`token.addMinter(sale.address)`*
    * Allows crowdsale's owner to buy tokens

-------
### Homework Solution
> Steps completed: 
1. Changed the minimum contribution to 5 Ether
2. Added method, getTokensLeft(), to report how many tokens are left
3. Added the needed functionality to not allow more than 1 purchase per account

> Problem answers and solution runthrough
1) Try to buy tokens with 2.5 ether
    > This produces an error because 2.5 ether is less then the minimum cap of 5 ether
2) Buy tokens with 15 ether
    > This is a success as 15 ether is within the [5 - 50] ether cap range
3) Return how many tokens are left
    > There are 60750 tokens left after the previous transactions
4) Buy tokens (again) with 25 Ether
    > This produces an error because each account is allowed a maximum of 1 purchase, and this account has already had a purchase made

```sh
> truffle compile
> truffle develop
> migrate --reset

> let accounts = await web3.eth.getAccounts()

> ExampleToken.new("CSC4980 Token", "GSU", 18).then((t) => {token = t;})

> ExampleTokenCrowdsale.new(450, accounts[0], token.address, new web3.utils.BN(web3.utils.toWei('150'))).then((t) => {sale = t;})

> token.transferOwnership(sale.address)
> token.addMinter(sale.address)

> sale.getTokensLeft().then(result => result.toNumber())
 # 67500 -> number of available tokens (before the sale)

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('2.5')), from: accounts[1]})
# Error: contribution amount must be between 5 and 50 ether

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('15')), from: accounts[1]})
# Success

> sale.getTokensLeft().then(result => result.toNumber())
# 60750

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('25')), from: accounts[1]})
# Error: this account has already made a purchase. Purchase limit is 1
```
-------
### Testing transactions from the [tutorial](https://medium.com/crowdbotics/how-to-build-a-simple-capped-crowdsale-token-using-openzeppelin-library-part-1-2789ec642308)
```sh
> truffle compile
> truffle develop
> migrate --reset
> let accounts = await web3.eth.getAccounts()

> ExampleToken.new("Example Token", "EXM", 18).then((t) => {token = t;})

> ExampleTokenCrowdsale.new(500, accounts[0], token.address, new web3.utils.BN(web3.utils.toWei('200'))).then((t) => {sale = t;})

> token.transferOwnership(sale.address)
> token.addMinter(sale.address)

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('1')), from: accounts[1]})
# Error: contribution amount must be between 5 and 50 ether

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('2')), from: accounts[1]})
# Success

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('48')), from: accounts[1]})
# Success

> sale.buyTokens(accounts[1], {value: new web3.utils.BN(web3.utils.toWei('1')), from: accounts[1]})
# Error: contribution amount must be between 5 and 50 ether
```


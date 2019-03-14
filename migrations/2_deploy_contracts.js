const ExampleToken = artifacts.require("ExampleToken.sol")
const ExampleTokenCrowdsale = artifacts.require("ExampleTokenCrowdsale.sol")

module.exports = async function(deployer) {
  
    let accounts = await web3.eth.getAccounts();

    deployer.deploy(ExampleToken, "CSC4980 Token", "GSU", 18)
        .then(() => ExampleToken.deployed())
        .then(token => deployer.deploy(
            ExampleTokenCrowdsale,
            500,
            accounts[0],
            token.address,
            new web3.utils.BN(web3.utils.toWei('1'))
        ));
  };
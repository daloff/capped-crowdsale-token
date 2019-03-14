pragma solidity ^0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title DetailedERC20 token
 * @dev The decimals are only for visualization purposes.
 * All the operations are done using the smallest and indivisible token unit,
 * just as on Ethereum all the operations are done in wei.
 */
contract ExampleToken is ERC20Mintable, ERC20Detailed, Ownable {

    //We inherited the ERC20Detailed 
    constructor(
        string memory _name, 
        string memory _symbol, 
        uint8 _decimals
    ) 
    ERC20Detailed(_name, _symbol, _decimals)
    public {
    }
}
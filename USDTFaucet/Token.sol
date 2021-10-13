// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;

import "./BEP20Token.sol";

contract Token is BEP20Token {

    constructor() {
    _name = "USD Faucet";
    _symbol = "USDFAUCET";
    _decimals = 18;
    _totalSupply = 10000000 * 10 ** 18;
    _balances[msg.sender] = _totalSupply;

    emit Transfer(address(0), msg.sender, _totalSupply);
  }

}
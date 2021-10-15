// SPDX-License-Identifier: MIT
pragma solidity 0.8.3;

import "./IBEP20.sol";
import "./Ownable.sol";

/*

*/

contract TokenSwap is Ownable{
    IBEP20 public token1;
    address public owner1;
    IBEP20 public token2;

    constructor() {
        token1 = IBEP20(0xa8f8C76CE1528a20e6E837B9d3f53FDFEe0dCD32); //ZFAUCET
        owner1 = 0x8A3DA0982DF04988ad04536D92FeFe88701619Bc; //WALLET ZFAUCET - Teste1 tetnet
        token2 = IBEP20(0xEdA7631884Ee51b4cAa85c4EEed7b0926954d180); //USDFALCET
    }

    function swap(uint256 amount1, uint256 amount2) public {
        
        //require(owner2[msg.sender], "Not authorized");  //user 
        require(
            token1.allowance(owner1, address(this)) >= amount1,  // wallet zeex
            "Token1 allowance too low"
        );
        require(
            token2.allowance(msg.sender, address(this)) >= amount2,  //USDT
            "Token2 allowance too low"
        );

        _safeTransferFrom(token2, msg.sender, owner1, amount2);
        _safeTransferFrom(token1, owner1, msg.sender, amount1);
    }

    function _safeTransferFrom (
        IBEP20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }

    function setParams(address tk1, address own1, address tk2) external onlyOwner {
        token1 = IBEP20(tk1);
        owner1 = own1;
        token2 = IBEP20(tk2);
    }


}
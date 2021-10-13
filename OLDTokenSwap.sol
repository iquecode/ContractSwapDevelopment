// SPDX-License-Identifier: MIT
pragma solidity 0.8.3;

import "./IBEP20.sol";
import "./Ownable.sol";

/*

*/
contract TokenSwap is Ownable{
    IBEP20  internal _token1;
    address internal _owner1;
    IBEP20  internal _token2;

    uint256 _valueTK1  = 100000;  // 1Tk1 = 0.1ZZZ  se ZZZ tiver 6 casas decimais 
    //uint8 decimalsTk2 = 6;

    constructor() {
        _token1 = IBEP20(0xCBE6793495A3b389628E7E850C5C60BB4E45B937); //IKE
        _owner1 = 0x0FF062e683Cf0682A6c2F01864C4AEe2B17728bC; //WALLET IKE Accont1 testnet firefox
        _token2 = IBEP20(0x8E8Ac19F90Ad1CF1764D4559B522e219a5B9eC21); //ZZZ
    }

    function swap(uint256 amountTK2) public {
        uint256 _amountTK1 = (amountTK2 / _valueTK1) * (10 ** 6);
        //require(owner2[msg.sender], "Not authorized");  //user 
        require(
            _token1.allowance(_owner1, address(this)) >= _amountTK1,  // wallet zeex
            "Token1 allowance too low"
        );
        require(
            _token2.allowance(msg.sender, address(this)) >= amountTK2,  //USDT
            "Token2 allowance too low"
        );
        _safeTransferFrom(_token2, msg.sender, _owner1, amountTK2);
        _safeTransferFrom(_token1, _owner1, msg.sender, _amountTK1);
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

    function setParams(address token1, address owner1, address token2, uint256 valueTK1) external onlyOwner {
        _token1 = IBEP20(token1);
        _owner1 = owner1;
        _token2 = IBEP20(token2);
        _valueTK1 = valueTK1;  
    }

    function getParams() external view returns (IBEP20, address, IBEP20, uint256) {
        return (_token1, _owner1, _token2, _valueTK1); 
    }

}
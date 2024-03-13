// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 미리 컨트랙트에 1타비 
// 해시값으로 랜덤 숫자 생성해서, 1의 자리 값이 홀수면, 승리, 짝수면 패배
// 승리면 두배, 패배면 몰수

// deposit 인원들은 스테이킹 시간 계산해서, 그에따라 ERC20 토큰 지급

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TabiGamble is IERC20 {

    event NewGamble(address gambler, uint256 amount);
    event GambleResult(address gambler, bool result);

    uint256 nonce = 0;

    function GenerateRandNum() public returns (uint256) {
        uint randNum = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce)));
        nonce++;
        return randNum;
    }

    function CheckResult() public returns (bool) {
        uint256 randNum = GenerateRandNum();
        bool result = false;
        if (randNum % 2 != 0 || randNum != 0){
            result = true;    
        }
        emit GambleResult(msg.sender, result);
        return result;
    }

    function NewGamble(uint256 amount) public payable  {
        require(amount <= 0.1, "max amount have to lower than 0.1");
        require(amount <= address(this).balance, "exceeded contract wallet's amount");
        require(amount <= msg.sender.balance, "exceeded your wallet amount");

        emit NewGamble(gambler, amount);
        
        if(CheckResult()){
            address.this -> msg.sender 에게 두배비용
        }
        
    }

}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// 미리 컨트랙트에 1타비 
// 해시값으로 랜덤 숫자 생성해서, 1의 자리 값이 홀수면, 승리, 짝수면 패배
// 승리면 두배, 패배면 몰수

// deposit 인원들은 스테이킹 시간 계산해서, 그에따라 ERC20 토큰 지급

contract TabiGamble {

    event NewGamble(address gambler, uint256 amount);
    event GambleResult(address gambler, bool result);
    event NewRandomNumber(uint256 randNum);

    uint256 eth2wei = 1e18;
    uint256 _maxStake = 1e17;
    uint256 _nonce = 0;

    function _generateRandNum() public returns (uint256) {
        uint256 randNum = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, _nonce)));
        _nonce++;
        emit NewRandomNumber(randNum);
        return randNum;
    }

    function CheckResult() public returns (bool) {
        uint256 randNum = _generateRandNum();
        bool result = false;
        if (randNum % 2 != 0){
            result = true;    
        }
        emit GambleResult(msg.sender, result);
        return result;
    }

    function CheckValue() public payable returns (uint256) {
        return msg.value;
    }

    function GambleStart() public payable  {
        require(msg.value <= _maxStake, "gamble amount have to lower than 0.1");
        require(msg.value <= address(this).balance, "exceeded contract wallet's amount");
        require(msg.value <= msg.sender.balance, "exceeded your wallet amount");
        emit NewGamble(msg.sender, msg.value); 

        if(CheckResult()){
            uint256 prize = 2 * msg.value;
            (bool sent, ) = payable(msg.sender).call{value: prize}("");
            require(sent, "Failed to send Ether");
        }
    }
}

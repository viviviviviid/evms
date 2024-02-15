// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 24시간마다 당첨자를 선정
// 우승자에게 모든 인원의 로또 금액을 합친뒤 90%의 비용을 전달
// 가스 최적화, 리플레이 방지기능 추가
// 아이아아ㅏ앙아ㅏ
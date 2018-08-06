/*
   블록체인 - 웹 연결
*/
pragma solidity ^0.4.20;

import "installed_contracts/oraclize-api/contracts/usingOraclize.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract IndexDataFeed {

	structure {

		
	}

	/*
	  * 계약주소:URL
	 */
	mapping (address => string)	public reqUrl;
	mapping (string => bool)		public endFlg;
	string[] public requestStack;

	event LogConstructor(string log);

	constructor() public payable {
		emit LogConstructor("IndexDataFeed 생성");
	}

	function queryUrl(string url)  public {

		require(url != "");

		// 처리URL 누적
		requestStack.push(url);

	}

	function processStart()  public returns (string[])  {

		// 처리URL 전달
		return requestStack;

	}

	function processEnd()  public returns (bool)  {

		// 처리URL 전달
		return requestStack;

	}

}

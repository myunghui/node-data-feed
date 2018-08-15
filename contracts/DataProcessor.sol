pragma solidity ^0.4.22;

contract DataProcessor {

	constructor() public {}
	struct Request {
		string url;
		function(bytes memory) external callback;
	}
	Request[] public jsonRequest;
	uint constant MAX_LENGTH =  10;
	
	event LogPush(uint idx, string url);
	function queryJson(string url, function(bytes memory) external callback) public {
	
		require(jsonRequest.length < MAX_LENGTH);
		
		jsonRequest.push(Request(url, callback));
		
		emit LogPush(jsonRequest.length - 1, url);
		
	}
	
	function reply(uint idx, bytes response) public {
		jsonRequest[idx].callback(response);
		delete jsonRequest[idx];
	}
	
}
/*
contract DataService {

	constructor() public {
	}
	
	DataProcessor constant processor = new DataProcessor();
	
	function getJsonData(string jsonUrl, function(bytes memory) external callback) public {
	
		// TODO parameter check
		
		processor.queryJson(jsonUrl, callback);
		
	}
	
}
*/

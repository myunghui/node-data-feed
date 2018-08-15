const DataProcessor     = artifacts.require("./DataProcessor.sol");

contract("DataProcessor", function(accounts) {
	
	const ownerAcct   = accounts[0];
	const customer_1 = accounts[1];
	const customer_2 = accounts[2];
	console.log(">>>	ownerAcct=" + ownerAcct);
	console.log(">>>	customer_1=" + customer_1);
	console.log(">>>	customer_2=" + customer_2);
	
	it("Case 1", function() {
		
		let instance;
		
		let num=1;
		let assertBalance=0;
		let tranArg = [];
		tranArg.push({from:customer_1, url:"http://localhost:4000/KOSPI"});
		tranArg.push({from:customer_2, url:"http://localhost:4000/KOSDAQ"});
		assertBalance += tranArg[0].value;
		assertBalance += tranArg[1].value;
		
		DataProcessor.deployed().then(function(_instance) {
			instance = _instance;	
			console.log(">>>	_instance=" + JSON.stringify(_instance));
			return instance.jsonRequest.call();
		}).then(function(result) {
			console.log(result);
			console.log(">>>	Case 1 - " + (num++) + " : jsonRequest=" + result);
			return result;
		});
		
	});
	
});

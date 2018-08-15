const DataProcessor = artifacts.require("./DataProcessor.sol");

module.exports = function(deployer) {
	const address = deployer.deploy(DataProcessor);
	console.log("DataProcessor=" + JSON.stringify(address));
};

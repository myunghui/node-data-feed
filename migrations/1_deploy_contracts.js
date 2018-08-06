const DieselPrice = artifacts.require("DieselPrice.sol");
const YoutubeViews = artifacts.require("YoutubeViews.sol");
const usingOraclize = artifacts.require("usingOraclize.sol");

module.exports = function(deployer) {
    deployer.deploy(DieselPrice);
    deployer.deploy(YoutubeViews);
    deployer.deploy(usingOraclize);
};
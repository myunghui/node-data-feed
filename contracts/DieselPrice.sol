/*
   Diesel Price Peg
   This contract keeps in storage a reference
   to the Diesel Price in USD
*/
pragma solidity ^0.4.0;

import "./oraclize/usingOraclize.sol";


contract DieselPrice is usingOraclize {

    uint public DieselPriceUSD;

    event newOraclizeQuery(string description);
    event newDieselPrice(string price);

    constructor() public {
        update(); // first check at contract creation
    }

    function __callback(bytes32 myid, string result) public {
        if (msg.sender != oraclize_cbAddress()) revert();
        emit newDieselPrice(result);
        DieselPriceUSD = parseInt(result, 2); // let's save it as $ cents
        // do something with the USD Diesel price
    }

    function update() payable public {
        emit newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
        oraclize_query("URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.diesel");
    }

}
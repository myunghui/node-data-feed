/*
   Youtube video views
   This contract keeps in storage a views counter
   for a given Youtube video.
*/
pragma solidity ^0.4.0;

import "./oraclize/usingOraclize.sol";


contract YoutubeViews is usingOraclize {

    string public viewsCount;

    event newOraclizeQuery(string description);
    event newYoutubeViewsCount(string views);

    constructor() public {
        update();
    }

    function __callback(bytes32 myid, string result) public {
        if (msg.sender != oraclize_cbAddress()) revert();
        viewsCount = result;
        emit newYoutubeViewsCount(viewsCount);
        // do something with viewsCount. like tipping the author if viewsCount > X?
    }

    function update() payable public {
        emit newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
        oraclize_query('URL', 'html(https://www.youtube.com/watch?v=9bZkp7q19f0).xpath(//*[contains(@class, "watch-view-count")]/text())');
    }

}
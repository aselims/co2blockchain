pragma solidity ^0.4.18;

contract simpleToken {
    
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    
    address public contractOwner;
    bool public auctionOpen;
    
    // creates the datatype order
    struct OrderStruct {
        address owner;
        uint256 amount;
        uint256 price;
        uint256 timestamp1;
        bool buy;
    }
    // test for order struct
    OrderStruct myorderstruct = OrderStruct(0x0,1,2,3,false);
    
    // create an array of datatype order
    OrderStruct[] public buyorders;
    // test adding entries to array
    function Test() public {
        for(uint i=0;i<5;i++){
            buyorders.push(OrderStruct(0x0,1,2,3,false));
        }
    }
    
    // the creator of the contract can start and end auctions
    function toggleAuction() public {
        require (msg.sender == contractOwner);
        if (auctionOpen){
            auctionOpen = false;
            // here the sorting and the distribution of the tokens should be done
        } else {
            auctionOpen = true;
        }
    }

    //add a single buy order
    function addBuyOrder(uint256 amount, uint256 price) public {
        require (auctionOpen);
        buyorders.push(OrderStruct(msg.sender,amount,price,block.timestamp,true));
    }
    
    // return function to access content of a buy order
    function getBuyOrderStruct(uint256 id) public constant returns(
        address owner,
        uint256 amount,
        uint256 price,
        uint256 timestamp1,
        bool buy
        ) {
            owner = buyorders[id].owner;
            amount = buyorders[id].amount;
            price = buyorders[id].price;
            timestamp1 = buyorders[id].timestamp1;
            buy = buyorders[id].buy;
    }

    event LogBalance(uint256 balance);

    function simpleToken() public {
        contractOwner = msg.sender; // this is the one who can start and end auctions
        balanceOf[msg.sender] = 100 ;              // Give the creator all initial tokens
    }
    
/*    function createOrder(uint256 amount, uint256 price, bool buy) public  {
        orderStruct storage order = orderStruct(msg.sender, amount, price, block.timestamp, buy);
       // return order;
    }*/
    
    // logexample
    function getBalance() public {
        LogBalance(balanceOf[msg.sender]);
    }

    function getBalanceReturn() constant public returns (uint256) {
        return balanceOf[msg.sender];
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[msg.sender] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    }
}


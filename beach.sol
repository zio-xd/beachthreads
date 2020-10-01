pragma solidity ^0.6.6;

contract Beach{
    uint qt;
    uint cost;
    address beach;
    address thread;
    bool order;
    bool payment;
    
    constructor() public{
        beach = msg.sender;
    }
    
    function setadd(address t) external{            //set address of thread company, must set address first
        thread = t;
    }
    
    function getqt() a() external view returns(uint){           //get value of quantity
        return qt;
    }
    
    function getc() a() external p() view returns(uint){            //get cost if order confirmed
        return cost;    
    }
    
    function setqt(uint q) a() external{                    //set value of q
        qt = q;
        Thread t = Thread(thread);
        t.setqt(qt);
    }
    
    function seto(uint c) a() auth() external{
        order=true;
        cost=c;
    }
    
    function pay() a() p() external returns(string memory){     //confirm payment
        payment = true;
        Thread t = Thread(thread);
        t.pay();
        return 'payment made';
    }
    
    modifier p(){
        require(order, 'order not confirmed yet');
        _;
    }
    
    modifier a(){
        require(thread!=0x0000000000000000000000000000000000000000, 'address of thread not set');
        _;
    }
    
    modifier auth(){
        require(msg.sender!=beach, 'auth error');
        _;
    }
    
}

contract Thread{
    
    address thread;
    address beach;
    uint qty;
    uint cost;
    bool payment;
    
    constructor() public{
        thread = msg.sender;
    }
    
    function setadd(address b) external{            //set address of beach company, must set address first
        beach = b;
    }
    
    function getqt() a() external view returns(uint){
        return qty;
    }
    
    function setqt(uint q) a() auth() external {
        qty = q;
    }
    
    function order(uint c) a() external {               //confirms order and gives cost
        Beach b=Beach(beach);
        b.seto(c);
    }
    
    function pay() a() auth() external{
        payment = true;
    }
    
    function paid() a() external returns(string memory){
        if(payment){
            return 'payment made';
        }
        else{
            return 'Payment not made';
        }
            
    }
    
    modifier a(){
        require(beach!=0x0000000000000000000000000000000000000000, 'address of beach not set');
        _;
    }
    
    modifier auth(){
        require(msg.sender!=thread, 'auth error');
        _;
    }
    
}

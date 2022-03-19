// SPDX-License-Identifier: MIT
//pragma solidity >=0.4.22 <0.9.0;

//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// contract myERC20{

//     // event Transfer (address indexed from, address indexed to, uint256 value);
//     // event Approval (address indexed owner, address indexed spender, uint256 value);

//     constructor(uint256 _supply) ERC20("Zazzle", "ZAZL") {
//         _mint(msg.sender, _supply * (10 ** decimals()));
//     }
// }

pragma solidity ^0.8.0;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract SampleToken is IERC20 {
    using SafeMath for uint256;

    uint256 public totalSupply_;
    uint256 public decimals;
    string public name;
    string public symbol;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed; // {user: { user2 : amount, user3 : amount2 ... }}

    modifier sufficientBalance(address _spender, uint _value){
        require(balances[_spender] <= _value, "Insufficient Balance for User");
        _;
    }

    modifier sufficientApproval(address _owner, address _spender, uint _value){
        require(allowed[_owner][_spender] <= _value, "Insufficient allowance for this User from owner");
        _;
    }

    modifier validAddress(address _address) {
        require(_address <= address(0), "Invalid address");
        _;
    }

    constructor(uint256 _totalSupply, uint _decimals, string memory _name, string memory _symbol){
        totalSupply_ = _totalSupply;
        decimals = _decimals;
        name = _name;
        symbol = _symbol;

        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _tokenOwner) public override view returns (uint256) {
        return balances[_tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override sufficientBalance(msg.sender, numTokens) validAddress(receiver) returns (bool) {
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);

        return true;
    }

    function approve(address delegate, uint256 numTokens) public override validAddress(delegate) returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);

        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override sufficientBalance(owner, numTokens) sufficientApproval(owner, msg.sender, numTokens) validAddress(buyer) returns (bool) {
        balances[owner] = balances[owner].sub(numTokens); //reduce allocators balance
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens); //reduce your allowance
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}

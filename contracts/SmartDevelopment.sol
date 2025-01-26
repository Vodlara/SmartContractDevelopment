// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SafeVault {
    address public owner;
    IERC20 public immutable token;
    uint256 public rewardRate; // Reward rate per second (in wei)
    
    struct Lock {
        uint256 amount;
        uint256 startTime;
        uint256 duration;
    }
    
    mapping(address => Lock) public locks;
    
    event TokensLocked(address indexed user, uint256 amount, uint256 duration);
    event TokensUnlocked(address indexed user, uint256 amount, uint256 reward);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }
    
    modifier onlyLockOwner() {
        require(locks[msg.sender].amount > 0, "No active lock");
        _;
    }

    constructor(address _token, uint256 _rewardRate) {
        owner = msg.sender;
        token = IERC20(_token);
        rewardRate = _rewardRate;
    }

    function lockTokens(uint256 amount, uint256 duration) external {
        require(amount > 0, "Amount must be > 0");
        require(duration > 0, "Duration must be > 0");
        
        token.transferFrom(msg.sender, address(this), amount);
        
        locks[msg.sender] = Lock({
            amount: amount,
            startTime: block.timestamp,
            duration: duration
        });
        
        emit TokensLocked(msg.sender, amount, duration);
    }

    function unlockTokens() external onlyLockOwner {
        Lock memory userLock = locks[msg.sender];
        require(block.timestamp >= userLock.startTime + userLock.duration, "Lock period not expired");
        
        uint256 reward = calculateReward(msg.sender);
        token.transfer(msg.sender, userLock.amount);
        
        delete locks[msg.sender];
        emit TokensUnlocked(msg.sender, userLock.amount, reward);
    }

    function calculateReward(address user) public view returns (uint256) {
        Lock memory userLock = locks[user];
        if (userLock.amount == 0) return 0;
        
        uint256 timeElapsed = block.timestamp - userLock.startTime;
        return (userLock.amount * rewardRate * timeElapsed) / 1e18;
    }

    function setRewardRate(uint256 newRate) external onlyOwner {
        rewardRate = newRate;
    }

    function getLockDetails(address user) public view returns (Lock memory) {
        require(locks[user].amount > 0 || msg.sender == user, "Unauthorized access");
        return locks[user];
    }
}
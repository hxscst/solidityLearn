pragma solidity >=0.4.22 <0.9.0;

import "./UniswapInterface.sol";
import "./IERC20.sol";


/**
 * @title The Utils of Uniswap
 * @author Tao
 */
contract UniswapUtils {
    // ropsten testnet
    address public constant UNISWAP_FACTORY_ADDRESS = 0x9c83dCE8CA20E9aAF9D3efc003b2ea62aBC08351;
    // TAO address
    address public constant DAI_ADDRESS = 0x6DFEcD45BbAA2b0032B25F91Ee8D48C8FBbFB4b1;
    

    /**
     * @dev Get UniswapExchange
     * @param _tokenAddress the address token contract
     * @return the address of UniswapExchange
     */ 
    function getUniswapExchange(address _tokenAddress)
        public
        view
        returns (address)
    {
        return
            IUniswapFactory(UNISWAP_FACTORY_ADDRESS).getExchange(_tokenAddress);
    }
    
    function test0() public returns(address)
    {
        return IUniswapFactory(UNISWAP_FACTORY_ADDRESS).createExchange(DAI_ADDRESS);
    }

    function test1()public view returns(address)
    {
        IUniswapExchange uniswapExchange=IUniswapExchange(getUniswapExchange(DAI_ADDRESS));
        return uniswapExchange.tokenAddress();
    }
    
    function test2() public payable returns(uint256)
    {
        IUniswapExchange uniswapExchange=IUniswapExchange(getUniswapExchange(DAI_ADDRESS));
        IERC20(DAI_ADDRESS).approve(address(uniswapExchange), 100);
        IERC20(DAI_ADDRESS).transferFrom(msg.sender, address(this), 100);
        uniswapExchange.addLiquidity.value(msg.value)(
            100,
            100,
            now + 120
            );

    
    function  buyToken() payable returns (uint amount){
        amount = msg.value / buyPrice;                    
        require(balanceOf[this] >= amount);              
        balanceOf[msg.sender] += amount;                  
        balanceOf[this] -= amount;                        
        Transfer(this, msg.sender, amount);               
        return amount;            
    }

    function deposit(uint256 _pid, uint256 _amount) public {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        if (user.amount > 0) {
            uint256 pending =
                user.amount.mul(pool.accSushiPerShare).div(1e12).sub(
                    user.rewardDebt
                );
            safeSushiTransfer(msg.sender, pending);
        }
        pool.lpToken.safeTransferFrom(
            address(msg.sender),
            address(this),
            _amount
        );
        user.amount = user.amount.add(_amount);
        user.rewardDebt = user.amount.mul(pool.accSushiPerShare).div(1e12);
        emit Deposit(msg.sender, _pid, _amount);
    }

    function withdraw(uint256 _pid, uint256 _amount) public {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        require(user.amount >= _amount, "withdraw: not good");
        updatePool(_pid);
        uint256 pending =
            user.amount.mul(pool.accSushiPerShare).div(1e12).sub(
                user.rewardDebt
            );
        safeSushiTransfer(msg.sender, pending);
        user.amount = user.amount.sub(_amount);
        user.rewardDebt = user.amount.mul(pool.accSushiPerShare).div(1e12);
        pool.lpToken.safeTransfer(address(msg.sender), _amount);
        emit Withdraw(msg.sender, _pid, _amount);
    }                        

}
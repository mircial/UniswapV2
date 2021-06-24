pragma solidity = 0.6.6;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);
    
    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    
    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns(address);
    function allPairsLength() external view returns (uint);
    
    function creatPair(address tokenA, address tokenB) external returns(address pair);
    
    function setFeeTo(address) external;
    function setFeeToSetter(address) external;

}
// '0x64fdAE9D0c45289aAF975F8Ea1034B616C0E9cAb', '0xb05a2606F2B96607263F628E5de51f6bD990A872', '10000000000000000000','10000000000000000000',10,10,'0x256807C23d5085ad22CC124c00852eE60989fC3E',1622813101
interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
    
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns(uint);
    function allowance(address owner, address spender) external view returns(uint);
    
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
    
    // permit
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s ) external;
    
    event Mint(address indexed spender, uint amount0, uint amount1);
    event Burn(address indexed spender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed spender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to);
    event Sync(uint112 reserve0, uint112 reserve1);
    
    // pair items
    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function KLast() external view returns (uint);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    
    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;
    
    function initialize(address, address) external;
}

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
    
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns(uint);
    function allowance(address owner, address spender) external view returns(uint);
    
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

interface IUniswapV2Router02 {
    function factory() external view returns (address);
    function WETH() external view returns (address);
    
    function quote (uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountIn (uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountOut (uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountsIn (uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsOut (uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    
    // add liquidity
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    
    
    // remove liquidity
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);
    
    // swap
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns(uint[] memory amounts);
    
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns(uint[] memory amounts);
    
    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns(uint[] memory amounts);
    
    function swapTokensForExactETH(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns(uint[] memory amounts);
    
    function swapETHForExactTokens(
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns(uint[] memory amounts);
    
    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns(uint[] memory amounts);
    
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
}


contract UniswapV2Router02 is IUniswapV2Router02 {
    using SafeMath for uint;
    
    address public immutable override factory;
    address public immutable override WETH;
    
    modifier ensure(uint deadline) {
        require(deadline >= block.timestamp, 'expired');
        _;
    }
    
    constructor (address _factory, address _WETH) public {
        factory = _factory;
        WETH = _WETH;
    }
    
    receive() external payable {
        assert(msg.sender == WETH);
    }
    
    // add liquidity
    function _addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin
    ) internal virtual returns (uint amountA, uint amountB) {
        if(IUniswapV2Factory(factory).getPair(tokenA, tokenB) == address(0)){
            IUniswapV2Factory(factory).creatPair(tokenA, tokenB);
        }
        (uint reserveA, uint reserveB) = UniswapV2Library.getReserves(factory, tokenA, tokenB);
        if (reserveA==0 && reserveB ==0){
            (amountA, amountB) = (amountADesired, amountBDesired);
        } else {
            uint amountBOptimal = UniswapV2Library.quote(amountADesired, reserveA, reserveB);
            if(amountBOptimal <= amountBDesired) {
                require(amountBOptimal >= amountBMin, 'insufficient b amount');
                (amountA, amountB) = (amountADesired, amountBOptimal);
            }
            else {
                uint amountAOptimal = UniswapV2Library.quote(amountBDesired, reserveB, reserveA);
                assert(amountAOptimal <= amountADesired);
                require(amountAOptimal >= amountAMin, 'insufficient a amount');
                (amountA, amountB) = (amountAOptimal, amountBDesired);
            }
        }
    }
    
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns (uint amountA, uint amountB, uint liquidity) {
        (amountA, amountB) = _addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin);
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);
        TransferHelper.safeTransferFrom(tokenA, msg.sender, pair, amountA);
        TransferHelper.safeTransferFrom(tokenB, msg.sender, pair, amountB);
        liquidity = IUniswapV2Pair(pair).mint(to);
    }
    
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external virtual override payable ensure(deadline) returns (uint amountToken, uint amountETH, uint liquidity) {
        (amountToken, amountETH) = _addLiquidity(token, WETH, amountTokenDesired, msg.value, amountTokenMin, amountETHMin);
        address pair = UniswapV2Library.pairFor(factory, token, WETH);
        TransferHelper.safeTransferFrom(token, msg.sender, pair, amountToken);
        IWETH(WETH).deposit{value: amountETH}();
        assert(IWETH(WETH).transfer(pair, amountETH));
        liquidity = IUniswapV2Pair(pair).mint(to);
        if (msg.value > amountETH) TransferHelper.safeTransferETH(msg.sender, msg.value - amountETH);
    }
    
    
    // remove liquidity
    
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountA, uint amountB){
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);
        IUniswapV2Pair(pair).transferFrom(msg.sender, pair, liquidity);
        (uint amount0, uint amount1) = IUniswapV2Pair(pair).burn(to);
        (address token0, ) = UniswapV2Library.sortTokens(tokenA, tokenB);
        (amountA, amountB) = token0 == tokenA ? (amount0, amount1) : (amount1, amount0);
        require(amountA >= amountAMin && amountB >= amountBMin, 'insufficient amount');
    }
    
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountToken, uint amountETH){
        (amountToken, amountETH) = removeLiquidity(token, WETH, liquidity, amountTokenMin, amountETHMin, address(this), deadline);
        TransferHelper.safeTransfer(token, to, amountToken);
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
        
    }
    
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountA, uint amountB){
        address pair =  UniswapV2Library.pairFor(factory, tokenA, tokenB);
        uint value = approveMax ? uint(-1) : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        (amountA, amountB) = removeLiquidity(tokenA, tokenB, liquidity, amountAMin, amountBMin, to, deadline);
    }
    
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountToken, uint amountETH){
        address pair =  UniswapV2Library.pairFor(factory, token, WETH);
        uint value = approveMax ? uint(-1) : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        (amountToken, amountETH) = removeLiquidityETH(token,liquidity, amountTokenMin, amountETHMin, to, deadline);
    }
    
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountETH) {
        (, amountETH) = removeLiquidity(token, WETH, liquidity, amountTokenMin, amountETHMin, address(this), deadline);
        TransferHelper.safeTransfer(token, to, IERC20(token).balanceOf(address(this)));
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
    }
    
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountETH) {
        address pair =  UniswapV2Library.pairFor(factory, token, WETH);
        uint value = approveMax ? uint(-1) : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        amountETH = removeLiquidityETHSupportingFeeOnTransferTokens(token, liquidity, amountTokenMin, amountETHMin, to, deadline);
    }
    
    // swap
    function _swap(uint[] memory _amounts, address[] memory _path, address _to) internal virtual {
        for (uint i; i< _path.length - 1;i++) {
            (address input, address output) = (_path[i], _path[i+1]);
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            uint amountout = _amounts[i+1];
            (uint amount0Out, uint amount1Out) = token0 == input ? (uint(0), amountout) :(amountout, uint(0));
            address pair = UniswapV2Library.pairFor(factory, input, output);
            address to = i < _path.length -2 ? UniswapV2Library.pairFor(factory, output, _path[i+2]) : _to;
            IUniswapV2Pair(pair).swap(amount0Out, amount1Out, to, new bytes(0));
        }
    }
    
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns(uint[] memory amounts){
        amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'insufficient amount');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
            );
        _swap(amounts, path, to);
    }
    
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns(uint[] memory amounts){
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);
        require(amounts[0] <= amountInMax, 'insufficient amount');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
            );
        _swap(amounts, path, to);
    }
    
    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override payable ensure(deadline) returns(uint[] memory amounts){
        require(path[0] == WETH, 'invalid path');
        amounts = UniswapV2Library.getAmountsOut(factory, msg.value, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'insufficient amount');
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
        _swap(amounts, path, to);
    }
    
    function swapTokensForExactETH(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns(uint[] memory amounts){
        require(path[path.length -1] == WETH, 'invalid path');
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);
        require(amounts[0] <= amountInMax, 'insufficient amount');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
            );
        _swap(amounts, path, address(this));
        IWETH(WETH).withdraw(amounts[amounts.length -1]);
        TransferHelper.safeTransferETH(to, amounts[amounts.length -1]);
    }
  
    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns(uint[] memory amounts) {
        require(path[path.length -1] == WETH, 'invalid path');
        amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length -1] >= amountOutMin, 'insufficient amount');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
            );
        _swap(amounts, path, address(this));
        IWETH(WETH).withdraw(amounts[amounts.length -1]);
        TransferHelper.safeTransferETH(to, amounts[amounts.length -1]);
    }
    
    function swapETHForExactTokens(
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override payable ensure(deadline) returns(uint[] memory amounts){
        require(path[0] == WETH, 'invalid path');
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);
        require(amounts[0] <= msg.value, 'insufficient amount');
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
        _swap(amounts, path, to);
        
        if(msg.value > amounts[0]) TransferHelper.safeTransferETH(msg.sender, msg.value - amounts[0]);
    }
    
    
    function _swapSupportingFeeOnTransferTokens(address[] memory _path, address _to) internal virtual {
        for (uint i; i< _path.length - 1;i++) {
            (address input, address output) = (_path[i], _path[i+1]);
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            address pair = UniswapV2Library.pairFor(factory, input, output);
            uint amountInput;
            uint amountOutput;
            {
            (uint reserve0, uint reserve1,) = IUniswapV2Pair(pair).getReserves();
            (uint reserveInput, uint reserveOutput) = token0 == input ? (reserve0, reserve1) : (reserve1, reserve0);
            amountInput  = IERC20(input).balanceOf(pair).sub(reserveInput);
            amountOutput = UniswapV2Library.getAmountOut(amountInput, reserveInput, reserveOutput);
            }
            (uint amount0Out, uint amount1Out) = token0 == input ? (uint(0), amountOutput) :(amountOutput, uint(0));
            address to = i < _path.length -2 ? UniswapV2Library.pairFor(factory, output, _path[i+2]) : _to;
            IUniswapV2Pair(pair).swap(amount0Out, amount1Out, to, new bytes(0));
        }
    }
    
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline){
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn
            );
        uint balanceBefore = IERC20(path[path.length -1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        uint balanceAfter = IERC20(path[path.length -1]).balanceOf(to);
        require(balanceAfter.sub(balanceBefore) >= amountOutMin, 'insufficient output amount');
    }
    
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) {
        require(path[path.length - 1] == WETH, ' invalid path');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn
            );
        _swapSupportingFeeOnTransferTokens(path, address(this));
        uint amountout  = IERC20(WETH).balanceOf(address(this));
        require(amountout >= amountOutMin, 'insufficient output amount');
        IWETH(WETH).withdraw(amountout);
        TransferHelper.safeTransferETH(to, amountout);
    }
    
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override payable ensure(deadline) {
        require(path[0] == WETH, ' invalid path');
        IWETH(WETH).deposit{value: msg.value}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, WETH, path[1]), msg.value));
        
        uint balanceBefore = IERC20(path[path.length -1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        uint balanceAfter = IERC20(path[path.length -1]).balanceOf(to);
        require(balanceAfter.sub(balanceBefore) >= amountOutMin, 'insufficient output amount');
        
    }
    
     // **** LIBRARY FUNCTIONS ****
    function quote(uint amountA, uint reserveA, uint reserveB) public pure virtual override returns (uint amountB) {
        return UniswapV2Library.quote(amountA, reserveA, reserveB);
    }

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut)
        public
        pure
        virtual
        override
        returns (uint amountOut)
    {
        return UniswapV2Library.getAmountOut(amountIn, reserveIn, reserveOut);
    }

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut)
        public
        pure
        virtual
        override
        returns (uint amountIn)
    {
        return UniswapV2Library.getAmountIn(amountOut, reserveIn, reserveOut);
    }

    function getAmountsOut(uint amountIn, address[] memory path)
        public
        view
        virtual
        override
        returns (uint[] memory amounts)
    {
        return UniswapV2Library.getAmountsOut(factory, amountIn, path);
    }

    function getAmountsIn(uint amountOut, address[] memory path)
        public
        view
        virtual
        override
        returns (uint[] memory amounts)
    {
        return UniswapV2Library.getAmountsIn(factory, amountOut, path);
    }
    
}

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
    
}
library UniswapV2Library {
    using SafeMath for uint;
    
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'identical address');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'identical address');
    }
    
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'26bfbe8b5389cd2c669857895701e6abf10ef1d288287220fa56122b7dd1aac7'
            ))));
    }
    
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0, ) = sortTokens(tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = token0 == tokenA ? (reserve0, reserve1) : (reserve1, reserve0);
    }
    
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA >0, 'insufficient amount');
        require(reserveA >0 && reserveB >0, 'insufficient reserve amount');
        amountB = amountA.mul(reserveB) / reserveA;
    }
    
    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn >0, 'insufficient amount');
        require(reserveIn >0 && reserveOut >0, 'insufficient reserve amount');
        uint numerator = amountIn.mul(997).mul(reserveOut);
        uint denominator = reserveIn.mul(1000).add(amountIn.mul(997));
        amountOut = numerator/denominator;
    }
    
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut >0, 'insufficient amount');
        require(reserveIn >0 && reserveOut >0, 'insufficient reserve amount');
        uint numerator = amountOut.mul(reserveIn).mul(1000);
        uint denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator/denominator).add(1);
    }
    
    function getAmountsOut(address factory, uint amountIn,  address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'invaild path');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i< path.length -1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i+1]);
            amounts[i + 1]  = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
        
    }
    
    function getAmountsIn(address factory, uint amountOut,  address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'invaild path');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i= path.length - 1; i >0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i-1], path[i]);
            amounts[i - 1]  = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
    
}
library TransferHelper {
    function safeApprove(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }

    function safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }

    function safeTransferFrom(address token, address from, address to, uint value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }

    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
    
}









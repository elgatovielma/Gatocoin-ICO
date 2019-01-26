// Gatocoins ICO

// Version of the compiler
pragma solidity >=0.4.0 <0.6.0;


contract GatocoinIco {
    
    //Introducing the maximum number of Gatocoins available for seale
    uint public maxGatocoins = 1000000;
    
    // Introducing the USD to Gatocoins conversion rate
    uint public usdToGatocoins = 1000;
    
    // Introducing the total number of Gatocoins that have been bought by the investors
    uint public totalGatocoinsBought = 0;
    
    // Maping from the investor address to its equity in Gatocoins and USD
    //      input type => output type then define the name of the var to return
    mapping(address => uint) equityGatocoins;
    mapping(address => uint) equityUSD;
    
    // Checking if an investor can buy Gatocoins
    modifier canBuyGatocoins(uint usdInvested){
        require (usdInvested * usdToGatocoins + totalGatocoinsBought <= maxGatocoins);
        /* 
        _; means the functions to which we will link the modifier will only be apllied 
        if the require function it's true  
        */
        _;
    }
    
    // Getting the equity in Gatocoins of an investor 
    function equityInGatocoins(address investor) external view returns (uint){
        return equityGatocoins[investor];
    }
    
    // Geting the equity in USD of an investor
     function equityInUSD(address investor) external view returns (uint){
        return equityUSD[investor];
    }
    
    // Buying Gatocoins
    function buyGatocoins(address investor, uint usdInvested) external 
    canBuyGatocoins(usdInvested){
        uint gatocoinsBought = usdInvested * usdToGatocoins;
        equityGatocoins[investor] += gatocoinsBought;
        equityUSD[investor] = equityGatocoins[investor] / usdToGatocoins;
        totalGatocoinsBought += gatocoinsBought;
    }
    
    // Selling Gatocoins
    function sellGatocoins(address investor, uint gatocoinsSold) external{
        equityGatocoins[investor] = equityGatocoins[investor] -  gatocoinsSold;
        equityUSD[investor] = equityGatocoins[investor] / usdToGatocoins;
        totalGatocoinsBought -= gatocoinsSold;
    }
    
}

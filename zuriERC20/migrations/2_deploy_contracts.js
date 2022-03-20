const ZuriERC20 = artifacts.require("ZuriERC20");

const totalSupply = 10 ** 6 * 10 ** 5;
const decimals = 5;
const name = "Zuri coins";
const symbol = "ZRC";

module.exports = function (deployer, network, accounts) {
  deployer.deploy(ZuriERC20, totalSupply, decimals, name, symbol, {from: accounts[0]});
};

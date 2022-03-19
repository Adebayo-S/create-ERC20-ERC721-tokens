const ZuriERC20 = artifacts.require("ZuriERC20");

module.exports = function (deployer) {
  deployer.deploy(ZuriERC20, 1000000);
};

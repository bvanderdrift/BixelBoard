const DAIContract = artifacts.require("ERC20");

module.exports = function (deployer) {
  deployer.deploy(DAIContract, "DAI", "DAI");
};

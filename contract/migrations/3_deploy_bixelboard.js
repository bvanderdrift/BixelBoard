const DAIContract = artifacts.require("ERC20");
const BixelBoardContract = artifacts.require("BixelBoard");

module.exports = function (deployer) {
  deployer.deploy(BixelBoardContract, DAIContract.address);
};

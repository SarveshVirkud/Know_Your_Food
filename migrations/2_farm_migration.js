var Farm = artifacts.require("./Farm.sol");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(Farm);
};
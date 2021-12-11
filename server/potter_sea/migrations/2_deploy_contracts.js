const NFT = artifacts.require("./NFT.sol");

module.exports = async function(deployer) {
  await deployer.deploy(NFT);
};
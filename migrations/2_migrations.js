const cards = artifacts.require("CryptoGogos");

module.exports = function (deployer) {
  deployer.deploy(cards);
};

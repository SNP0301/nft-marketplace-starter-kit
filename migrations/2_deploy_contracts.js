import { artifacts } from "truffle";
const KryptoBird = artifacts.require("KryptoBird");

module.exports = function(deployer) {
  deployer.deploy(KryptoBird);
};

const { assert } = require("chai");

const KryptoBird = artifacts.require("./KryptoBird");

require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("KryptoBird", (accounts) => {
  let contract;
  describe("deployment", async () => {
    it("deploys successfully", async () => {
      contract = await KryptoBird.deployed();
      const address = contract.address;
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    it("it has a name", async () => {
      const name = await contract.name();
      assert.equal(name, "KryptoBird");
    });

    it("has a symbol", async () => {
      const symbol = await contract.symbol();
      assert.equal(symbol, "KBIRDZ");
    });
  });
});

//// kryptoBird.deployed().address = '0x1523dFAbC1F2bE8Dfa80f7f4dFe8016F6749AE2a'

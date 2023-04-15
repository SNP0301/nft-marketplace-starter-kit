import React, { Component } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import KryptoBird from "../abis/Kryptobird.json";

class App extends Component {
  async componentDidMount() {
    await this.loadWeb3();
    await this.loadBlockchainData();
  }

  async loadWeb3() {
    const provider = await detectEthereumProvider();

    if (provider) {
      window.web3 = new Web3(provider);
      console.log("Injected web3 detected.");
    } else {
      console.log("No web3 detected. Falling back to http://127.0.0.");
    }
  }

  async loadBlockchainData() {
    const accounts = await window.web3.eth.getAccounts();
    console.log(accounts);
  }

  render() {
    return (
      <div>
        <h1>Let's Go!</h1>
      </div>
    );
  }
}

export default App;

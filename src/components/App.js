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
    const web3 = window.web3;
    const accounts = await web3.eth.getAccounts();
    this.setState({ account: accounts });
    console.log(accounts);

    const networkId = await web3.eth.net.getId();
    const networkData = KryptoBird.networks[networkId];
    if (networkData) {
      const abi = KryptoBird.abi;
      const address = networkData.address;
      const contract = new web3.eth.Contract(abi, address);
      this.setState({ contract });

      const totalSupply = await contract.methods.totalSupply().call();
      this.setState({ totalSupply });

      //let result = [];

      for (let i = 1; i <= totalSupply; i++) {
        const KryptoBird = await contract.methods.kryptoBirdz(i - 1).call();

        //result.push(kryptoBird);
        this.setState({ kryptoBirdz: [...this.state.kryptoBirdz, KryptoBird] });
      }
    } else {
      window.alert("Smart contract not deployed to detected network.");
    }
  }

  mint = (kryptoBird) => {
    this.state.contract.methods
      .mint(kryptoBird)
      .send({ from: this.state.account[0] })
      .once("recipt", (receipt) => {
        this.setState({
          kryptoBirdz: [...this.state.kryptoBirdz, KryptoBird],
        });
      });
  };

  constructor(props) {
    super(props);
    this.state = {
      accounts: "",
      contract: null,
      totalSupply: 0,
      kryptoBirdz: [],
    };
  }
  render() {
    return (
      <div>
        {console.log(this.state.kryptoBirdz)}
        <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
          <div
            className="navbar-brand col-sm-3 col-md-3 mr-0"
            style={{ color: "white" }}
          >
            Krypto Birdz NFTs
          </div>
          <ul className="navbar-nav px-3">
            <li
              className="nav-item text-nowrap
                d-none d-sm-none d-sm-block
                "
            >
              <small className="text-white">{this.state.account}</small>
            </li>
          </ul>
        </nav>
        <div className="container-fluid mt-1">
          <div className="row">
            <main role="main" className="col-lg-12 d-flex text-center">
              <div
                className="content mr-auto ml-auto"
                stlye={{ opacity: "0.8" }}
              >
                <h1 className="display-3 mb-4" style={{ color: "blue" }}>
                  Krypto Birdz NFTs
                </h1>

                <form
                  onSubmit={(event) => {
                    event.preventDefault();
                    const kryptoBird = this.kryptoBird.value;

                    this.mint(kryptoBird);
                  }}
                >
                  <input
                    type="text"
                    placeholder="Add a file location"
                    className="form-control mb-1"
                    ref={(input) => (this.kryptoBird = input)}
                  />
                  <input
                    type="submit"
                    className="btn btn-primary"
                    value="MINT"
                  />
                </form>
              </div>
            </main>
          </div>
        </div>
      </div>
    );
  }
}

export default App;

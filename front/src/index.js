import Web3 from "web3";
import healtContract from "../../build/contracts/VoteImage.json";
const App = {
  web3: null,
  account: null,
  meta: null,

  start: async function() {
    const { web3 } = this;

    try {
      // get contract instance
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = healtContract.networks[networkId];
      this.meta = new web3.eth.Contract(
        healtContract.abi,
        deployedNetwork.address
      );

      // get accounts
      const accounts = await web3.eth.getAccounts();
      this.account = accounts[0];
    } catch (error) {
      console.error("Could not connect to contract or chain.");
    }
  },

  registerCandidate: async function(_name, _imageHash) {
    const { registerCandidate } = this.meta.methods;
    await registerCandidate(_name,  _imageHash).send({
      from: this.account
    });
  },

  vote: async function(_forCandidate) {
    const { vote } = this.meta.methods;
    await vote(_forCandidate).send({
      from: this.account
    });
  },
  
  
    
 
};

window.App = App;

window.addEventListener("load", async function() {
  if (window.ethereum) {
    // use MetaMask's provider
    App.web3 = new Web3(window.ethereum);
    await window.ethereum.enable(); // get permission to access accounts
  } else {
    console.warn(
      "No web3 detected. Falling back to http://172.0.0.1:7545. You should remove this fallback when you deploy live"
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    App.web3 = new Web3(
      new Web3.providers.HttpProvider("http://172.0.0.1:7545")
    );
  }

  App.start();
});
export default { App };

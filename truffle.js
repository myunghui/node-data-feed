// ropsten
const HDWalletProvider = require("truffle-hdwallet-provider");
// 12-word mnemonic
const mnemonic = "uphold legend rib damage involve engine elder mail chair habit wolf double";


module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    ropsten: {
      provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/57cbfc77b085f4e56faa70c1e9200a4b108b1ed1ffce4e898b9bee94a264368c"),
      network_id: 3, // official id of the ropsten network
	  gas: 4612388
    }
  }
};
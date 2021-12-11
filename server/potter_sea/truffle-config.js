module.exports = {
    contracts_build_directory: './abis',
  
    networks: {
      development: {
        host: "localhost",     // Localhost (default: none)
        port: 8545,            // Standard Ethereum port (default: none)
        network_id: "*",       // Any network (default: none)
      },
    },
  
    compilers: {
      solc: {
        version: "^0.8.7",
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  };
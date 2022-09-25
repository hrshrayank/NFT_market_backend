const hre = require("hardhat");

async function main() {
  const MintNFT = await hre.ethers.getContractFactory("MintNFT");
  const mintNFT = await MintNFT.deploy();

  await mintNFT.deployed();
  const NFTMarketplace = await hre.ethers.getContractFactory("NFTMarketplace");
  const nFTMarketplace = await NFTMarketplace.deploy();

  await nFTMarketplace.deployed();

  console.log("Mint NFT deployed to:", mintNFT.address);
  console.log("NFTMarketplace deployed to:", nFTMarketplace.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });


// 0x21a48c867f90DA5D10173Eb2fBb2E6EA76614F14
// 0x1b39a5E69b615dEb269c3d2e5Ff850e989058E82

// Mint NFT deployed to: 0x7d162C4147Bea220c730a6cDbFB6625dB3afd2d4
// NFTMarketplace deployed to: 0xA0480ECB4E22d7CA299f8f46e821E35E8C26B0b1

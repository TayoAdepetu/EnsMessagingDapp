const hre = require("hardhat");

async function main() {
    

  const TeeWhyChat  = await ethers.deployContract("TeeWhyChat"); 
  await TeeWhyChat.waitForDeployment();
  
  console.log(
    `TeeWhyChat  contract deployed to ${TeeWhyChat.target}`
  );

}
  main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });
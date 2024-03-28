const hre = require("hardhat");

async function main() {
  

  const ENSContract  = await ethers.deployContract("ENSContract"); 
  await ENSContract.waitForDeployment();
  
  console.log(
    `ENSContract  contract deployed to ${ENSContract.target}`
  );

 
}
  main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });
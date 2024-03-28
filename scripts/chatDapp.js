const hre = require("hardhat");

async function main() {
    

  const ChatDapp  = await ethers.deployContract("ChatDapp"); 
  await ChatDapp.waitForDeployment();
  
  console.log(
    `ChatDapp  contract deployed to ${ChatDapp.target}`
  );

}
  main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });
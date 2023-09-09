const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

async function main() {
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY);
  const encryptedKey = await wallet.encrypt(
    process.env.PASSWORD,
    process.env.PRIVATE_KEY
  );
  fs.writeFileSync("./encryptedKey.json", encryptedKey, "utf8");
}

main()
  .then(() => {
    console.log("compiled");
    process.exit(0);
  })
  .catch((error) => {
    console.log(error);
  });

import React from "react";
import { Web3ReactProvider } from "@web3-react/core";
import Web3 from "web3";
import { BixelBoard } from "./BixelBoard";

function App() {
  return (
    <Web3ReactProvider getLibrary={(provider) => new Web3(provider)}>
      <BixelBoard />
    </Web3ReactProvider>
  );
}

export default App;

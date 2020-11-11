import { useWeb3React } from "@web3-react/core";
import { InjectedConnector } from "@web3-react/injected-connector";
import React from "react";

export const BixelBoard = () => {
  const web3React = useWeb3React();

  if (web3React.active === false) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div>
          <span className="p-4">To get started:</span>
          <button
            className={"bg-blue-300 p-4"}
            onClick={() =>
              web3React.activate(
                new InjectedConnector({
                  supportedChainIds: [0x539],
                })
              )
            }
          >
            Connect Wallet
          </button>
        </div>
      </div>
    );
  }

  return <div></div>;
};

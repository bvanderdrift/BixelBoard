pragma solidity >=0.4.22;

import "./ERC20Interface.sol";

struct Bixel {
    address owner;
    uint8 red;
    uint8 green;
    uint8 blue;
}

contract BixelBoard {
    uint256 public width = 1000;
    uint256 public height = 1000;
    uint256 public bixelStakeDAIValue = 1e18; // DAI has 18 decimals
    IERC20 public daiAddress;
    Bixel[1000][1000] public bixels; //height x width because in array definition the dimensions are inversed

    constructor(IERC20 _daiAddress) {
        daiAddress = _daiAddress;
    }

    modifier existingBixel(uint256 x, uint256 y) {
        require(
            x >= 0 && x < width,
            "Make sure the x value is at or above 0 and below 1000!"
        );
        require(
            y >= 0 && y < height,
            "Make sure the y value is at or above 0 and below 1000!"
        );

        _;
    }

    modifier ownsBixel(
        uint256 x,
        uint256 y,
        address sender
    ) {
        require(
            bixels[x][y].owner == msg.sender,
            "Make sure you own the bixel!"
        );

        _;
    }

    function setBixel(
        uint256 x,
        uint256 y,
        uint8 red,
        uint8 green,
        uint8 blue
    ) public existingBixel(x, y) ownsBixel(x, y, msg.sender) {
        bixels[x][y].red = red;
        bixels[x][y].green = green;
        bixels[x][y].blue = blue;
    }

    function claimBixel(uint256 x, uint256 y) public existingBixel(x, y) {
        require(
            daiAddress.balanceOf(msg.sender) >= bixelStakeDAIValue,
            "Make sure you have enough DAI to stake!"
        );
        require(
            daiAddress.transferFrom(
                msg.sender,
                address(this),
                bixelStakeDAIValue
            ),
            "Failed to stake DAI, did you approve this contract to transfer DAI for you already?"
        );

        bixels[x][y].owner = msg.sender;
    }

    function releaseBixel(uint256 x, uint256 y)
        public
        existingBixel(x, y)
        ownsBixel(x, y, msg.sender)
    {
        // We on purpose do not reset a Bixel to be white again

        require(
            daiAddress.transfer(msg.sender, bixelStakeDAIValue),
            "Failed to return DAI for an unknown reason."
        );

        bixels[x][y].owner = address(0);
    }
}

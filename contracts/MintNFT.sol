// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;
   
    //Variables
    mapping(address => bool) public presaleAddresses;
    string baseURI = "ipfs://QmamJdFSvKcT9XbP6NvoCkhzs2DhRrckNPPx4kJhRBJKWE/";
    string public baseExtension = ".json";
    uint256 public cost = 0.001 ether;
    bool public paused = false;
    uint256 public maxSupply = 1000;

    uint256 public tokenIds;
    bool public revealed = false;
    string public notRevealedUri =
        "ipfs://QmUXmCQDCxVnSzSDCs5V2bYXugtbFEU1UJ7CcwnEM5wDSm/hidden.json";

    modifier onlyWhenNotPaused() {
        require(!paused, "Contract is Paused by owner");
        _;
    }

    constructor() ERC721("Pandas", "PA") {
    }


    function mint() public payable onlyWhenNotPaused {
        uint256 supply = totalSupply();
        require(supply < maxSupply, "No NFT to mint");
        require(msg.value >= cost, "Amount is less than the Cost");
        _safeMint(msg.sender, supply + 1);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "URI is not present");

        if (revealed == false) {
            return notRevealedUri;
        }

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    //owner only access
    function reveal() public onlyOwner {
        revealed = true;
    }

    function setCost(uint256 _newCost) public onlyOwner {
        cost = _newCost;
    }

    function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
        tokenIds = _newmaxMintAmount;
    }

    function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
        notRevealedUri = _notRevealedURI;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension)
        public
        onlyOwner
    {
        baseExtension = _newBaseExtension;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}

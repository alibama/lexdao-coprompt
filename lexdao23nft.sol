// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract My721Token is Context, ERC721 {
    address public nftHolder;

    constructor(string memory name, string memory symbol, address holderAddress) ERC721(name, symbol) {
        nftHolder = holderAddress;
    }

    function mint(address to) public {
        require(_msgSender() == nftHolder, "My721Token: only the NFT holder can mint tokens");
        _safeMint(to, totalSupply() + 1);
    }

    function burn(uint256 tokenId) public {
        require(_msgSender() == ownerOf(tokenId), "My721Token: caller is not the token owner");
        _burn(tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        require(to == address(0), "My721Token: tokens are not transferable");
        super._beforeTokenTransfer(from, to, tokenId);
    }
}

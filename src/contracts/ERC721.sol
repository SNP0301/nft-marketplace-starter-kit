// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
    /*
    
    */

contract ERC721{

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokensCount;

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0));
        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to] += 1;
    }
}
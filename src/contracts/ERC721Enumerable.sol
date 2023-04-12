// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumberable is ERC721 {
    uint256[] private _allTokens;

    mapping (uint256 => uint256) private _allTokensIndex;
    mapping (address=>uint256[]) private _ownedTokens; 
    mapping (uint256=>uint256) private _ownedTokensIndex;





    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns(uint256){
        require(index <balanceOf(owner),'owner index is out of range');
        return _ownedTokens[owner][index];
    }

    function tokenByIndex(uint256 index) public view returns(uint256) {
        require(index < totalSupply(), 'global index is out of range');
        return _allTokens[index];
    }


    function totalSupply() public view returns (uint256){
        return _allTokens.length;
    }



    //function tokenByIndex(uint256 _index) external view returns (uint256){}

    

    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){}
    
 

    function _mint(address to, uint256 tokenId) internal override(ERC721){
        super._mint(to, tokenId);

        _addTokensTotalSupply(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensTotalSupply(uint256 tokenId) private {
        _allTokensIndex[tokenId] =_allTokens.length;
        _allTokens.push(tokenId); 
    }
 
    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private{
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
        
    }
} 
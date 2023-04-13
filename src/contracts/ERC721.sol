// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';

contract ERC721 is ERC165, IERC721{

    // @dev deleted because it is defined in ./IERC721.sol
    //event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokensCount;
    mapping(uint256 => address) private _toeknApprovals;

    function balanceOf(address _owner) public override view returns(uint256) {
        require(_owner != address(0), 'owner query for non-existent ');
        return _OwnedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public override view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'owner query for non-existent ');
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns (bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual{
        require(to != address(0),'ERC721: minting to the zero address');
        require(!_exists(tokenId), 'ERC721: token already exists');

        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to] += 1;
        emit Transfer(address(0), to, tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'Error - transfer to zero address');
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own');
        
        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;
 
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);

    } 

    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        _transferFrom (_from, _to, _tokenId); 
    }

}
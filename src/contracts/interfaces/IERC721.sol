// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721  {
    /// @dev This emits when ownership of any NFT changes by any mechanism.
    ///  This event emits when NFTs are created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation, any number of NFTs
    ///  may be created and assigned without emitting Transfer. At the time of
    ///  any transfer, the approved address for that NFT (if any) is reset to none.
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    /// @dev This emits when the approved address for an NFT is changed or
    ///  reaffirmed. The zero address indicates there is no approved address.
    ///  When a Transfer event emits, this also indicates that the approved
    ///  address for that NFT (if any) is reset to none.
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

   
    function balanceOf(address _owner) external view returns (uint256);


    function ownerOf(uint256 _tokenId) external view returns (address);

    // function safeTransferFrom(address _from, ad dress _to, uint256 _tokenId, bytes data) external payable;

    //function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

    function transferFrom(address _from, address _to, uint256 _tokenId) external;

    //function approve(address _approved, uint256 _tokenId) external payable;

    //function setApprovalForAll(address _operator, bool _approved) external;

    //function getApproved(uint256 _tokenId) external view returns (address);

    //function isApprovedForAll(address _owner, address _operator) external view returns (bool);
} 
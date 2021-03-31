// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;


import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-solidity/contracts/utils/Counters.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";


contract CryptoGogos is Ownable, ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; //Counter is a struct in the Counters library

    string internal _tokenURI;
    address _address;

    constructor() public ERC721("CryptoGogos", "CGG") {
        _address = msg.sender;
    }

    //Cards is actually to create a mapping of token id to their tokenURI
    struct Cards {
        string name;
        string cat;
        uint256 card_id; //series number in our case
        string description;
        string image_url;
        string tokenuri;
    }

    Cards[] private card;

    mapping(uint256 => Cards) public tokeninfo;

    function drawCard() public {
        _tokenIds.increment();
        uint256 newNftTokenId = _tokenIds.current();

        Cards memory c;

        c.card_id = newNftTokenId;

        (
            string memory tu,
            string memory n,
            string memory d,
            string memory ct,
            string memory i
        ) = getTokenURI();
        c.name = n;
        _tokenURI = tu;
        c.tokenuri = tu;
        c.description = d;
        c.cat = ct;
        c.image_url = i;
        card.push(c);
        tokeninfo[newNftTokenId] = c;

        _safeMint(_address, newNftTokenId);
        _setTokenURI(newNftTokenId, _tokenURI);
    }

    //passing supply which is user inputted paramter
    function getTokenURI()
        internal
        pure
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        //send token uri link in this function and return as first parameter.
        string memory t1 = "This is token URI";
        string memory n1 = "token name";
        string memory d1 = "token description";
        string memory _c1 = "token category";
        string memory _i = "image url";
        return (t1, n1, d1, _c1, _i);
    }

    function _safeMint(address to, uint256 tokenId)
        internal
        override
        onlyOwner
    {
        _safeMint(to, tokenId, "");
    }

    function viewCategory(uint256 _tokenid)
        public
        view
        returns (string memory)
    {
        return (tokeninfo[_tokenid].cat);
    }

    function viewNumberofCards() public view returns (uint256) {
        return _tokenIds.current();
    }

    function viewName(uint256 _tokenid) public view returns (string memory) {
        return (tokeninfo[_tokenid].name);
    }

    function viewDescription(uint256 _tokenid)
        public
        view
        returns (string memory)
    {
        return (tokeninfo[_tokenid].description);
    }

    function viewImageUrl(uint256 _tokenid)
        public
        view
        returns (string memory)
    {
        return (tokeninfo[_tokenid].image_url);
    }

    function viewtokenURI(uint256 _tokenid)
        public
        view
        returns (string memory)
    {
        return (tokeninfo[_tokenid].image_url);
    }

    function totalSupply() public view override returns (uint256) {
        return _tokenIds.current();
    }
}

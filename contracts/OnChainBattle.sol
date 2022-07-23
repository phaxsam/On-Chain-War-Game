pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


contract ChainWar is ERC721URIStorage{ 
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIds2Levels;

    constructor() ERC721("Chain War of Aluma", "CWA" ){

    }

    function generateIds(uint256) public returns(string memory){
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 296.485 296.485" width="296.485" height="296.485">',
            '<style>.base { file: black; font-family: serif; font-size: 14px; }</style>',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">', "Warrior",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels:",getLevels(tokenId),'</text>',
            '</svg>'
        );

        return string(
            abi.encodePacked(
                "data: image/svg+xml;base64,",
                Base64.encode(svg)
            )
        );
    }
    
    function getLevels(uint256 tokenId) public view returns(string memory){
        uint256 levels = tokenIds2Levels[tokenId];
        return levels.toString();
    }

/* function getTokenURI(uint256 tokenId) public returns (string memory){
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
        '}'
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
}*/
    function getTokenURL(uint256 tokenId) public returns(string memory){
        bytes memory dataURL = abi.encodePacked(
            '{',
            '"name": "Chain War in Aluma #', tokenId.toString(), '",',
            '"description": " Battles on chain in Aluma kingdom where Ufara was provoked and later got victory",',
           // '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURL)
            )
        );
}
     function mint() public{
         _tokenIds.increment();
         uint256 newItemId= _tokenIds.current();
         _safeMint(msg.sender, newItemId);
         tokenIds2Levels[newItemId]=0;
         _setTokenURI((newItemId), getTokenURL(newItemId));
     }

     function train(uint256 tokenId) public {
         require(_exists(tokenId), "please use existing tokenId");
         require( ownerOf(tokenId) == msg.sender, "you must be the owner of this tokenid to train it");
         uint256 currentlevel = tokenIds2Levels[tokenId];
         tokenIds2Levels[tokenId] = currentlevel + 1;
         _setTokenURI(tokenId, getTokenURL(tokenId) );
    
    }
}

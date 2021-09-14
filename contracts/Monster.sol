// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Monster is ERC721 {

    address payable public owner;

    string[2][] private monsters = [
        ["Kidnapper", "Robber"],
        ["Axe Gang", "Headsman"]
    ];
        
    string[] private prefixes = [
        "Angry",
        "Hungry",
        "Scary",
        "Damned",
        "Corrupt",
        "Gloomy",
        "Horrific",
        "Ghostly",
        "Freaky",
        "Amnesic",
        "Painful",
        "Overjoyed",
        "Sorrowful",
        "Blusterous",
        "Degraded"
    ];
    
    uint public next_monster;

    uint constant TOTAL = 30;
    uint constant POINT = 9;

    mapping(uint => string) public monster;
    mapping(uint => string) public prefix;
    mapping(uint => string) public suffix;

    mapping(uint => uint) public health_Point;
    mapping(uint => uint) public physical_damage_point;
    mapping(uint => uint) public magical_damage_point;
    mapping(uint => uint) public physical_defence;
    mapping(uint => uint) public magical_defence;
    mapping(uint => uint) public dodge;
    mapping(uint => uint) public hit; 
    mapping(uint => uint) public critical;
    mapping(uint => uint) public parry;

    constructor() ERC721("Monster Manifested", "MMS"){
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only Owner");
        _;
    }

    event monstered(address indexed owner, uint monster);
    
    function getPrefix(uint _token_id) public view returns (string memory) {
        uint rand = uint(keccak256(abi.encodePacked(block.timestamp, _token_id)));

        return prefixes[rand % prefixes.length];
    }

    function mintMonster() public payable{
        require(msg.value == 0.001e18, "10FTM IS REQUIRED");

        next_monster ++;
        uint _next_monster = next_monster;

        uint rand = uint(keccak256(abi.encodePacked(_next_monster)));
        
        string memory s = monsters[rand % monsters.length][1];
        monster[_next_monster] = monsters[rand % monsters.length][0];
        suffix[_next_monster] = s;
        prefix[_next_monster] = getPrefix(_next_monster);

        uint[] memory divides = divide(_next_monster);
        uint[] memory divide_points = new uint[](POINT-1);
        uint p;
        for (uint i=0; i<TOTAL; i++){
            if (divides[i] == 1){
                divide_points[p] = i;
                p++;
            }
        }

        uint a; uint b; uint c; uint d; uint e; uint f; uint g; uint h; uint k;
        (a, b, c, d, e, f, g, h, k) = get_base_points(s);

        health_Point[_next_monster] = divide_points[0] - 0 + a;
        physical_damage_point[_next_monster] = divide_points[1] - divide_points[0] + b;
        magical_damage_point[_next_monster] = divide_points[2] - divide_points[1] + c;
        physical_defence[_next_monster] = divide_points[3] - divide_points[2] + d;
        magical_defence[_next_monster] = divide_points[4] - divide_points[3] + e;
        dodge[_next_monster] = divide_points[5] - divide_points[4] + f;
        hit[_next_monster] = divide_points[6] - divide_points[5] + g; 
        critical[_next_monster] = divide_points[7] - divide_points[6] + h;
        parry[_next_monster] = divide_points[8] - divide_points[7] + k;
        
        _safeMint(msg.sender, _next_monster);
        
        emit monstered(msg.sender, _next_monster);
    }

    function get_base_points(string memory _suffix) public pure returns(uint, uint, uint, uint, uint, uint, uint, uint, uint){
        if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("Robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("Headsman"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("Guard"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("Hunter"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("Wizard"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0); 
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        } else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        }else if (keccak256(abi.encodePacked(_suffix)) == keccak256(abi.encodePacked("robber"))){
            return (0, 0, 0, 0, 0, 0, 0, 0, 0);
        }

        return (0, 0, 0, 0, 0, 0, 0, 0, 0);
    }

    function divide(uint _token_id) public pure returns (uint[] memory){
        uint[] memory divides =  new uint[](TOTAL);

        uint rand;
        uint j;
        for(uint i=0; i<POINT-1; i++){
            uint d;
            while(d == 0  || divides[d] == 1){
                j++;
                rand = uint(keccak256(abi.encodePacked(_token_id, j)));
                d = rand % TOTAL;
            }
            divides[d] = 1;
        }

        return divides;
    }

    function tokenURI(uint _token_id) override public view returns (string memory) {
        string[21] memory parts;

        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = string(abi.encodePacked("monster", " ", prefix[_token_id], " ", monster[_token_id], " ", suffix[_token_id]));

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = string(abi.encodePacked("health_Point", " ", health_Point[_token_id]));

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = string(abi.encodePacked("physical_damage_point", " ", physical_damage_point[_token_id]));

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = string(abi.encodePacked("magical_damage_point", " ", magical_damage_point[_token_id]));

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = string(abi.encodePacked("physical_defence", " ", physical_defence[_token_id]));

        parts[10] = '</text><text x="10" y="120" class="base">';

        parts[11] = string(abi.encodePacked("magical_defence", " ", magical_defence[_token_id]));

        parts[12] = '</text><text x="10" y="140" class="base">';

        parts[13] = string(abi.encodePacked("dodge", " ", dodge[_token_id]));

        parts[14] = '</text><text x="10" y="160" class="base">';

        parts[15] = string(abi.encodePacked("hit", " ", hit[_token_id]));

        parts[16] = '</text><text x="10" y="160" class="base">';

        parts[17] = string(abi.encodePacked("critical", " ", critical[_token_id]));
        
        parts[18] = '</text><text x="10" y="160" class="base">';

        parts[19] = string(abi.encodePacked("parry", " ", parry[_token_id]));

        parts[20] = '</text></svg>';

        string memory output = string(abi.encodePacked(
            parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], 
            parts[8], parts[9], parts[10]));
        
        output = string(abi.encodePacked(output, parts[11], parts[12], parts[13], parts[14], 
            parts[15], parts[16], parts[17], parts[18], parts[19], parts[20]));

        string memory json = Base64.encode(bytes(string(
            abi.encodePacked('{"name": "Bag #', toString(_token_id), '", "description": "Loot is randomized adventurer gear generated and stored on chain. Stats, images, and other functionality are intentionally omitted for others to interpret. Feel free to use Loot in any way you want.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }

    function claim() public {
        require(next_monster >= 0 && next_monster < 10000, "Token ID invalid");
        mintMonster();
    }
    
    function ownerClaim() public onlyOwner {
        require(next_monster >= 10000 && next_monster < 11000, "Token ID invalid");
        mintMonster();
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function withdraw() public onlyOwner{
        uint amount = address(this).balance;

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
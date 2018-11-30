pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract contractJu {
    
    // Public variables of the contract
    enum UserType {undefined, coordinator, validator, colector}
    uint256 private lastItem;               //number of the last generated item
    address private coordinatorAddress;     //address of the coordinator
    
    struct Historic {
        address owner;
        uint startDate;
    }
    
    struct Item {
        uint256 id;
        string manufacturer;
        string model;
        uint256 fabricationYear;
        string serialNumber;
        bool valid;
        address validator;
        uint validationDate;
        Historic[] ownersHistoric;
        bool robbed;
    }
    
    mapping (address => mapping (uint256 => Item)) inventories;
    mapping (address => UserType) userTypes;
    mapping (address => uint256[]) itemsPerUser;
    mapping (string => uint256) serialToID;
    
    modifier onlyCoordinator {
        require(msg.sender == coordinatorAddress);
        _;
    }
    
    modifier onlyValidator {
        require(userTypes[msg.sender] == UserType.validator);
        _;
    }
    
    /**
     * Constructor function
     *
     * Initializes contract with the last item number equals zero and set the creator of the contract as the coordinator
     */
     
    constructor (
    ) public {
        lastItem = 0;
        coordinatorAddress = msg.sender;
        userTypes[coordinatorAddress] = UserType.coordinator;
    }
    
    function getUserType(address _user) public view returns (UserType){
        return userTypes[_user];
    }
    
   function getItem(string serial, address owner) public view returns (string) {
        return inventories[owner][serialToID[serial]].model;
    }

    function createValidator(address _newValidator) onlyCoordinator public returns (bool success) {
        userTypes[_newValidator] = UserType.validator;
        return true;
    }
    
    function validate(address _owner, uint256 _itemId) onlyValidator public returns (bool success) {
        //acessar o owner, verificar se tem o item, setar para valido e registrar o endereço do validador
        return true;
    }
    
    /////////////////////////////////////////////////////////////////////////////
    
    function transferItem(address _from, address _to, uint256 _id) public returns (bool success) {
        //tira de um
        //coloca no outro
        //atualizar histórico
        
        var itemTransferred = inventories[_from][_id];
        
        if (itemTransferred.valid) {
            
            var newHistoric = Historic(_to, block.timestamp);
            itemTransferred.ownersHistoric.push(newHistoric) -1;
            
            // registrar a transferencia no array itemsPerUser
            delete itemsPerUser[_from][_id];
            itemsPerUser[_to].push(_id) -1;
            
            // registrar a transferencia no mapa
            delete inventories[_from][_id];
            inventories[_to][_id] = itemTransferred;
            
            return true;
        }
        
        return false;
    }
    
    //To do: criar um item no endereço do sender, cobrando algo ...
    // ... e pedindo verificação (cancelado)
    function createItem(string _manufacturer, string _model, uint256 _year, string _serial) public returns (bool success) {
        //dá chave única para o item
        //criado como não validado
        
        
        lastItem = lastItem+1;
        var item = inventories[msg.sender][lastItem];
        item.id = lastItem;
        item.manufacturer = _manufacturer;
        item.model = _model;
        item.fabricationYear = _year;
        item.serialNumber = _serial;
        item.valid = false;
        item.validator = 0;
        item.validationDate = 0;
        
        var newHistoric = Historic(msg.sender, block.timestamp);
        item.ownersHistoric.push(newHistoric) -1;
        item.robbed = false;
        
        itemsPerUser[msg.sender].push(lastItem) -1;
        
        serialToID[_serial] = lastItem;
        
        return true;
    }


    
    function declareRobbery(uint256 _id) public returns (bool success) {
        //verificar se o item é do sender
        //levantar flag de roubo
        //fazer alguma coisa para impedir a criação de um similar
        
        if (itemsPerUser[msg.sender][_id] != 0) {
            // usuario contem o item _id
            var item = inventories[msg.sender][_id];
            if (item.valid) {
                item.robbed = true;
            }
        }
    }

}
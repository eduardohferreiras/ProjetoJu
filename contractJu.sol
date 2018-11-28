pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract contractJu {
    
    // Public variables of the contract
    enum UserType {coordinator, validator, colector}
    uint256 private lastItem;               //number of the last generated item
    address private coordinatorAddress;     //address of the coordinator
    
    struct Historic {
        address owner;
        string startDate;
    }
    
    struct Item {
        uint256 id;
        string manufacturer;
        string model;
        string fabricationYear;
        string serialNumber;
        bool valid;
        Historic[] ownersHistoric;
    }
    
    mapping (address => mapping (uint256 => Item)) inventories;
    mapping (address => UserType) userTypes;
    
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
    
    function getUserType(address _user) public returns (UserType){
        return userTypes[_user];
    }


    // ??? This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // ??? This generates a public event on the blockchain that will notify clients
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // ??? This notifies clients about the amount burnt
    event Burn(address indexed from, uint256 value);

    /**
     * Transfer tokens
     *
     * Send `_value` tokens to `_to` from your account
     *
     * @param _to The address of the recipient
     * @param _value the amount to send
     */

    /**
     * Transfer tokens from other address
     *
     * Send `_value` tokens to `_to` on behalf of `_from`
     *
     * @param _from The address of the sender
     * @param _to The address of the recipient
     * @param _value the amount to send
     */
    function transferItemTo(address _from, address _to, uint256 _value) public returns (bool success) {
        //tira de um
        //coloca no outro
        //atualizar histórico
        return true;
    }
    
    function transferItemFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //tira de um
        //coloca no outro
        //atualizar histórico
        return true;
    }
    
    //To do: criar um item no endereço do sender, cobrando algo e pedindo verificação de confiavel.
    function createItem(address _from, address _to, uint256 _value) public returns (bool success) {
        
        //dá chave única para o item
        //criado como não validado
        return true;
    }
    
    //To do: adiciona um endereço como verificador. Verificador só valida, não tem instrumentos.
    function createValidator(address _from, address _to, uint256 _value) public returns (bool success) {
        //ver se sender tem permissão para criar validador
        return true;
    }
    
    function validate(address _from, address _to, uint256 _value) public returns (bool success) {
        //verificar se sender é validator
        //tranferir dinheiros de um lugar pro outro?
        //mudar o status do item para validado, registrar a data e o validador no historico do item
        return true;
    }
    
    function declareRobbery(uint256 _value) public returns (bool success) {
        //verificar se o item é do sender
        //levantar flag de roubo
        //fazer alguma coisa para impedir a criação de um similar
    }

}

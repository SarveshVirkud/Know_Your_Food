pragma solidity >=0.4.22 <0.6.0;
contract Farm {
    uint  i=0;
    uint  batchcount=0;
    string[20] soilname;
    uint[20]  soilgrade;
    string[20]  fname ;
    uint[20]  fergrade;
    uint[20]  fgrade;

    struct FarmerIntial {
        uint adhaar;
        uint FoodA;
        uint initial;
    }
    
    
    struct Mandi{
        uint adhaar;
        uint farmeradhaar;
        string ArrivalTime;
        uint branchstart;
        uint branchend;
    }
    
    struct Market{
        uint adhaar;
        uint mandiadhaar;
        string ArrivalTime;
        uint branchstart;
        uint branchend;
    }

    address Farmer=msg.sender;
    
    mapping(uint => FarmerIntial) farmers;
    uint[] FarmerAccts;
    function setFarmer(uint _adhaar, string memory _soilname, uint _soilgrade, string memory _fname, uint _fergrade, uint _FoodA, uint _fgrade) public {
        farmers[_adhaar].FoodA=_FoodA;
        farmers[_adhaar].initial=batchcount;
        for (i=batchcount; i<_FoodA+batchcount; i++) {
            fgrade[i]=_fgrade;
            soilname[i]=_soilname;
            soilgrade[i]=_soilgrade;
            fname[i]=_fname;
            fergrade[i]=_fergrade;
        }
        
        batchcount=batchcount+_FoodA;
     
        FarmerAccts.push(_adhaar);
         
    }
    
    mapping(uint => Mandi) mandi;
    uint[] AllowedAccts;
    
    function initMandi(uint _adhaar, uint _farmeradhaar, uint _branchstart, uint _branchend) public {
        mandi[_adhaar].farmeradhaar = _farmeradhaar;
        mandi[_adhaar].branchstart = _branchstart+farmers[_farmeradhaar].initial;
        mandi[_adhaar].branchend = _branchend+farmers[_farmeradhaar].initial;
        AllowedAccts.push(_adhaar);
    }
    
    
    
    function setMandi(uint _adhaar,uint _fgrade, string memory _ArrivalTime) public {
        for ( i=0; i<fgrade.length; i++) {
        
            if (AllowedAccts[i] == _adhaar)
            mandi[_adhaar].ArrivalTime=_ArrivalTime;
            for ( i=mandi[_adhaar].branchstart; i<mandi[_adhaar].branchend; i++) {
                fgrade[i]=_fgrade;
            }
            i = fgrade.length;
        }
        
    }
    
    function initMarket(uint _adhaar, uint _farmeradhaar, uint _branchstart, uint _branchend) public {
        //mandi[_adhaar].mandi = _farmeradhaar;
        mandi[_adhaar].branchstart = _branchstart+farmers[_farmeradhaar].initial;
        mandi[_adhaar].branchend = _branchend+farmers[_farmeradhaar].initial;
        AllowedMarkAccts.push(_adhaar);
        
    }
    
    mapping(uint => Market) market;
    uint[] AllowedMarkAccts;
    
    
    
    
    function getFarmer(uint _branch) view public returns(string memory, uint, string memory, uint, uint){

        return (soilname[_branch],soilgrade[_branch],fname[_branch],fergrade[_branch],fgrade[_branch]);    
    }
    
}
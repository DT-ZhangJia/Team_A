pragma solidity ^0.4.14;

contract Payroll {

    //��ʼнˮ
    uint salary = 1 ether;
    
    //�ϰ�Ǯ����ַ
    address boss;
    
    //Ա��Ǯ����ַ
    address employee = 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c;
    
    uint constant payDuration = 10 seconds;
    uint lastPayday = now;
    
    //��ʼ���ϰ��ַΪִ�к�Լ��ַ
    function Payroll() {
       boss = msg.sender;
    }
    
    //ֻ���ϰ��������Ա��нˮ
    function setSalary(uint s){
        if(msg.sender != boss){
            revert();
        }
        
        salary = s*1 ether;
    }

    function getSalary() returns (uint) {
        return salary;
    }  
    
    //ֻ���ϰ��������Ա��Ǯ����ַ
    function setAddress(address addr){
        if(msg.sender != boss){
            revert();
        }
        
        employee = addr;
    }
    
    function getAddress() returns(address){
        return employee;
    }
    
    function addFund() payable returns(uint){
        return this.balance;
    }
    
    function getBalance() returns (uint) {
        return this.balance;
    }  

    function caculateRunway() returns (uint) {
        return this.balance / salary;
    }    
    
    function hasEnoughFund() returns(bool) {
        return caculateRunway() >  0;
    }
    
    function getPaid() payable{
        if(msg.sender != employee){
            revert();
        }
        
        uint nextPayday = lastPayday + payDuration;
        if(nextPayday > now){
            revert();
        }
        lastPayday = nextPayday;
        employee.transfer(salary);
    }
}
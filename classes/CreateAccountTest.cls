@isTest
public class CreateAccountTest
{
  static testMethod void testProjectID1()
  {
  Test.startTest();
  Account Acc = new Account();
  Acc.Name = 'Adidas';
  Insert Acc; 
  
  Opportunity Opp = New Opportunity(); 
  Opp.Name = 'cloud Infrastructure';
  Opp.AccountID =  Acc.ID; 
  Opp.StageName = 'Qualification'; 
  Opp.CloseDate  = Date.today();
  Insert Opp;
  
 
  Test.stopTest();
  
  
  }
  static testMethod void testProjectID2()
  {
  Test.startTest();
  Account Acc = new Account();
  Acc.Name = 'Adidas';
  Insert Acc; 

  Opportunity Opp = New Opportunity(); 
  Opp.Name = 'cloud Infrastructure';
  Opp.AccountID =  Acc.ID; 
  Opp.StageName = 'Qualification'; 
  Opp.CloseDate  = Date.today();
  Opp.Project_Code__c = 'ADIDAS-CLOU-0001-001';
//  Insert Opp;
  
    NewProjectCtrl NpCTRL = new NewProjectCtrl();
    String OppNewProject = NewProjectCtrl.CreateOpp(opp);
    
    Integer ChangeRequestCode = NewProjectCtrl.generateChangeRequestCode(Acc.ID);
    
    Integer ProjCode = NewProjectCtrl.generateProjectCode(Acc.ID);
  
  Test.stopTest();
 }



}
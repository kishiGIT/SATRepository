public with sharing class MydemoVFCtrl {

    public MydemoVFCtrl(ApexPages.StandardController controller) {

    }
    
    public PageReference saveBtn(){
    PageReference pageRef = new PageReference('http://www.google.com');
     pageRef.setRedirect(true);
       return pageRef ;
    }

}
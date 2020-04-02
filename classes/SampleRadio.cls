public with sharing class SampleRadio {

    public String getUS() {
        return null;
    }


    public PageReference test() {
        return null;
    }


    public String Countries { get; set; }

    public String getCountry() {
        return null;
    }
    
     public String country {get;set;}
     
     
     public List<SelectOption> getsex() {
       
        List<SelectOption> options = new List<SelectOption>();
       
        options.add(new SelectOption('ML','Male'));
        options.add(new SelectOption('FL','Female'));
        options.add(new SelectOption('Oth','Others'));
       
        return options;
    }
                 
     
     


}
public class SexRatio {

    public PageReference test() {
        return null;
    }

    public String Ratio {get;set;}
    
    public String country {get;set;}
         
   
               
    public List<SelectOption> getsex() {
       
        List<SelectOption> options = new List<SelectOption>();
       
        options.add(new SelectOption('ML','Male'));
        options.add(new SelectOption('FL','Female'));
        options.add(new SelectOption('Oth','Others'));
       
        return options;
    }
                   
                 
 
}
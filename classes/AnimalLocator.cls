public class AnimalLocator {

public static string getAnimalNameById(integer id){
Http http=new Http();
string strResp ;
HttpRequest request=new HttpRequest();
  system.debug('--id'+id);
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
request.setMethod('GET');
HttpResponse response=http.send(request);
if(response.getStatusCode()==200){
 map<string,object> results=(map<string,object>)JSON.deserializeUntyped(response.getBody());
  system.debug('--resut'+results);
  map<string,object> animals=( map<string,object>)results.get('animal');
  strResp = string.valueof(animals.get('name'));
   system.debug('--strResp'+strResp);
}
return strResp ;
}
}
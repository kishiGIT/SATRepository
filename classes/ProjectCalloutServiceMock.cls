@isTest
global class ProjectCalloutServiceMock implements HttpCalloutMock{
   //Implement http mock callout here
   global HttpResponse respond(HttpRequest request){
     HttpResponse response=new HttpResponse();
     response.setHeader('Content-Type','application/json');
     response.setStatus('OK');
     response.setStatusCode(201);
     return response;
     
   }
}
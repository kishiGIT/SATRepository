public class ParkLocator{
 public static String[]  country(string country){
  
  ParkService.ParksImplPort  parks=new ParkService.ParksImplPort();
  string[] parksName=parks.byCountry(country);
  return parksName;
 }
}
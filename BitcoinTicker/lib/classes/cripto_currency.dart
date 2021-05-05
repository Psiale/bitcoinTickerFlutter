import 'networking.dart';

String url = "https://rest.coinapi.io/v1/exchangerate/";
String apiKey = "74FB1659-ED09-48F5-B08D-41682A2FA88F";

class CriptoCurrency {
  getCoinData(String cripto, String coin) async {
    print(coin);
    HttpFetch httpFetch = new HttpFetch("$url$cripto/$coin/?apikey=$apiKey");
    var response = await httpFetch.getHttpRequest();
    return response;
  }
}

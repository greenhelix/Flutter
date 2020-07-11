import 'package:http/http.dart'as http ;
import 'dart:async';

Future<List<Oversea>> fetchPhotos(http.Client client) async {
    final response = await client.get('http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19NatInfStateJson')
  return
}

class Oversea {
    final int result_code;
    final String area_nm;
    final String nation_nm;
    final int nat_def_cnt;
    final int nat_death_cnt;
    final int nat_death_rate;
    final int update_dt;

    Oversea(this.update_dt, {this.result_code, this.area_nm, this.nation_nm, this.nat_def_cnt, this.nat_death_cnt, this.nat_death_rate});

}

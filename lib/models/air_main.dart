
import 'air/components.dart';
import 'air/mainAir.dart';


class AirData {
  List <ListA> lista;
  AirData({required this.lista});

  factory AirData.fromjson(Map<String, dynamic> json) =>
      AirData(lista: List<ListA>.from(json['list'].map((e)=> ListA.fromJson(e))));
}

class ListA {
	Main? main;
	Components? components;
	int? dt;

	ListA({this.main, this.components, this.dt});

	factory ListA.fromJson(Map<String, dynamic> json) => ListA(
				main: json['main'] == null
						? null
						: Main.fromJson(json['main'] as Map<String, dynamic>),
				components: json['components'] == null
						? null
						: Components.fromJson(json['components'] as Map<String, dynamic>),
				dt: json['dt'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'main': main?.toJson(),
				'components': components?.toJson(),
				'dt': dt,
			};

  map(Function(dynamic e) param0) {}
}

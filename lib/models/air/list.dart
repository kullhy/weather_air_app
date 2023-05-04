import 'components.dart';
import 'mainAir.dart';

class List {
	Main? main;
	Components? components;
	int? dt;

	List({this.main, this.components, this.dt});

	factory List.fromJson(Map<String, dynamic> json) => List(
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

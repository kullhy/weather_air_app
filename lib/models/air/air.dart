import 'coord.dart';
import 'list.dart';

class Air {
  Coord? coord;
  List? list;

  Air({this.coord, this.list});

  factory Air.fromJson(Map<String, dynamic> json) => Air(
        coord: json['coord'] == null
            ? null
            : Coord.fromJson(json['coord'] as Map<String, dynamic>),
        list: (json['list'] as List?)
            ?.map((e) => (e as List)
                .map((e) => List.fromJson(e as Map<String, dynamic>))
                .toList())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'list': list?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      };
}

import 'dart:convert';

class CovidModel {
  final String UpdateDate;
  final int todayCases;
  final int cases;
  final int recovered;
  final int todayDeaths;
  final int todayRecovered;
  CovidModel({
    required this.UpdateDate,
    required this.todayCases,
    required this.cases,
    required this.recovered,
    required this.todayDeaths,
    required this.todayRecovered,
  });

  CovidModel copyWith({
    String? UpdateDate,
    int? todayCases,
    int? cases,
    int? recovered,
    int? todayDeaths,
    int? todayRecovered,
  }) {
    return CovidModel(
      UpdateDate: UpdateDate ?? this.UpdateDate,
      todayCases: todayCases ?? this.todayCases,
      cases: cases ?? this.cases,
      recovered: recovered ?? this.recovered,
      todayDeaths: todayDeaths ?? this.todayDeaths,
      todayRecovered: todayRecovered ?? this.todayRecovered,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UpdateDate': UpdateDate,
      'todayCases': todayCases,
      'cases': cases,
      'recovered': recovered,
      'todayDeaths': todayDeaths,
      'todayRecovered': todayRecovered,
    };
  }

  factory CovidModel.fromMap(Map<String, dynamic> map) {
    return CovidModel(
      UpdateDate: map['UpdateDate'],
      todayCases: map['todayCases'],
      cases: map['cases'],
      recovered: map['recovered'],
      todayDeaths: map['todayDeaths'],
      todayRecovered: map['todayRecovered'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CovidModel.fromJson(String source) => CovidModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CovidModel(UpdateDate: $UpdateDate, todayCases: $todayCases, cases: $cases, recovered: $recovered, todayDeaths: $todayDeaths, todayRecovered: $todayRecovered)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CovidModel &&
      other.UpdateDate == UpdateDate &&
      other.todayCases == todayCases &&
      other.cases == cases &&
      other.recovered == recovered &&
      other.todayDeaths == todayDeaths &&
      other.todayRecovered == todayRecovered;
  }

  @override
  int get hashCode {
    return UpdateDate.hashCode ^
      todayCases.hashCode ^
      cases.hashCode ^
      recovered.hashCode ^
      todayDeaths.hashCode ^
      todayRecovered.hashCode;
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'educations.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Educations {
  const Educations({
    this.id,
    required this.institution,
    required this.major,
    this.thumbnail,
    required this.startYear,
    this.endYear,
    this.isOngoing = false,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Educations.fromJson(Map<String, dynamic> json) =>
      _$EducationsFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String institution;
  final String major;
  final String? thumbnail;
  final int startYear;
  final int? endYear;

  @JsonKey(includeToJson: false)
  final bool isOngoing;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  @JsonKey(includeToJson: false)
  final String starredByNames;

  Map<String, dynamic> toJson() => _$EducationsToJson(this);
}

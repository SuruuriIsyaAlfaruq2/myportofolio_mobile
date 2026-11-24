import 'package:json_annotation/json_annotation.dart';

part 'skills.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Skills {
  const Skills({
    this.id,
    this.category = 'hardskills',
    required this.title,
    required this.description,
    this.thumbnail,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Skills.fromJson(Map<String, dynamic> json) => _$SkillsFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String category;
  final String title;
  final String description;
  final String? thumbnail;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  @JsonKey(includeToJson: false)
  final String starredByNames;

  bool get isSoft => category == 'softskills';
  bool get isHard => category == 'hardskills';

  Map<String, dynamic> toJson() => _$SkillsToJson(this);
}

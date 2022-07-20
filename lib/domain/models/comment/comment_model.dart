import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final int id;
  final int postId;
  final String? body;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  
  Map<String,dynamic> toJson() => _$CommentModelToJson(this);
}

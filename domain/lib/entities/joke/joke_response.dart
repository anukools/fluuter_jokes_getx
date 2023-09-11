import 'package:domain_package/entities/api/api.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke_response.g.dart';

@JsonSerializable()
@CopyWith()
class JokeListResponse extends BaseApiResponse {
  final String? joke;
  const JokeListResponse({
    this.joke,
  });

  factory JokeListResponse.fromJson(Map<String, Object?> json) => _$JokeListResponseFromJson(json);

  @override Map<String, dynamic> toJson() => _$JokeListResponseToJson(this);
}
import 'package:domain_package/enums/api.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api.g.dart';

@JsonSerializable()
@CopyWith()
class BaseApiRequest extends Equatable {
  final String? userId;
  const BaseApiRequest({
    this.userId,
  });

  factory BaseApiRequest.fromJson(Map<String, dynamic> json) => _$BaseApiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BaseApiRequestToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
    userId,
  ];
}

@JsonSerializable()
@CopyWith()
class BaseApiResponse extends Equatable {
  final ApiStatus? status;
  final String? message;
  const BaseApiResponse({
    this.status,
    this.message,
  });

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseApiResponseToJson(this);

  @override
  List<Object?> get props => [
    status,
    message,
  ];
}

class BaseAppResponse<T> {
  T? data;
  BaseAppError? error;
  String endPoint;
  int startTime;
  int endTime;
  int statusCode;
  Map<String, dynamic> headers;

  BaseAppResponse({
    this.data,
    this.error,
    this.endPoint = '',
    this.startTime = 0,
    this.endTime = 0,
    this.statusCode = -1,
    this.headers = const {},
  });

  bool get isSuccess => data != null;
}

class BaseAppError {
  dynamic exception;
  dynamic apiErrorData;

  BaseAppError({this.exception, this.apiErrorData});

  String? get msg => exception.toString();
}

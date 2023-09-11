// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseApiRequest _$BaseApiRequestFromJson(Map<String, dynamic> json) =>
    BaseApiRequest(
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$BaseApiRequestToJson(BaseApiRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

BaseApiResponse _$BaseApiResponseFromJson(Map<String, dynamic> json) =>
    BaseApiResponse(
      status: $enumDecodeNullable(_$ApiStatusEnumMap, json['status']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BaseApiResponseToJson(BaseApiResponse instance) =>
    <String, dynamic>{
      'status': _$ApiStatusEnumMap[instance.status],
      'message': instance.message,
    };

const _$ApiStatusEnumMap = {
  ApiStatus.OK: 'OK',
  ApiStatus.SUCCESS: 'SUCCESS',
  ApiStatus.FAILURE: 'FAILURE',
  ApiStatus.EXCEPTION: 'EXCEPTION',
  ApiStatus.INVALID_VALUES: 'INVALID_VALUES',
};

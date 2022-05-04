// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:twitter_api_v2/src/client/client_context.dart';
import 'package:twitter_api_v2/src/client/user_context.dart';
import 'package:twitter_api_v2/src/service/base_service.dart';
import 'package:twitter_api_v2/src/service/spaces/space_data.dart';
import 'package:twitter_api_v2/src/service/spaces/space_meta.dart';
import 'package:twitter_api_v2/src/service/twitter_response.dart';

abstract class SpacesService {
  /// Returns the new instance of [SpacesService].
  factory SpacesService({required ClientContext context}) =>
      _SpacesService(context: context);

  /// Return live or scheduled Spaces matching your specified search terms.
  ///
  /// This endpoint performs a keyword search, meaning that it will return Spaces
  /// that are an exact case-insensitive match of the specified search term.
  ///
  /// The search term will match the original title of the Space.
  ///
  /// ## Parameters
  ///
  /// - [query]: Your search term. This can be any text (including mentions and Hashtags)
  ///           present in the title of the Space.
  ///
  /// ## Endpoint Url
  ///
  /// - https://api.twitter.com/2/spaces/search
  ///
  /// ## Rate Limits
  ///
  /// - **User rate limit (OAuth 2.0 user Access Token)**:
  ///    300 requests per 15-minute window per each authenticated user
  ///
  /// - **App rate limit (OAuth 2.0 App Access Token)**:
  ///    300 requests per 15-minute window shared among all users of your app
  ///
  /// ## Reference
  ///
  /// - https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search
  Future<TwitterResponse<List<SpaceData>, SpaceMeta>> search(
      {required String query});
}

class _SpacesService extends BaseService implements SpacesService {
  /// Returns the new instance of [_TweetsService].
  _SpacesService({required ClientContext context}) : super(context: context);

  @override
  Future<TwitterResponse<List<SpaceData>, SpaceMeta>> search(
      {required String query}) async {
    final response = await super.get(
      UserContext.oauth2AppOnly,
      '/2/spaces/search',
      queryParameters: {'query': query},
    );

    return TwitterResponse(
      data: response['data']
          .map<SpaceData>((space) => SpaceData.fromJson(space))
          .toList(),
      meta: SpaceMeta.fromJson(response['meta']),
    );
  }
}
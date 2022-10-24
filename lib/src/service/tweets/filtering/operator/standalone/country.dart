// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:twitter_api_core/twitter_api_core.dart' as core;

// Project imports:
import '../operator.dart';

class Country extends Operator {
  /// Returns the new instance of [Country].
  const Country(
    this.country, {
    bool negated = false,
  }) : super(negated);

  factory Country.negated(final core.ISOAlpha2Country country) =>
      Country(country, negated: true);

  /// The BCP 47 language
  final core.ISOAlpha2Country country;

  @override
  String format() => 'place_country:${country.code}';
}

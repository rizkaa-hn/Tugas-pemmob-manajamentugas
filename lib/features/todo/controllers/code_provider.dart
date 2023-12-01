import 'package:country_picker/country_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_provider.g.dart';


@riverpod
class CountryCode extends _$CountryCode {
  
  Country country = Country(
      phoneCode: "86",
      countryCode: "CN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "China",
      example: "China",
      displayName: "China",
      displayNameNoCountryCode: "CN",
      e164Key: "");

  @override
  Country build() {
    return country;
  }

  void setCountry(Country newState) {
    state = newState;
  }
}

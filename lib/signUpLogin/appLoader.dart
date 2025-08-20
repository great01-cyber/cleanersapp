import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appLoader.g.dart';

@riverpod
class Apploader extends _$Apploader {
  @override
  bool build() {
    return false;
  }

  void setLoaderValue(bool value) {
    state = value;
  }
}

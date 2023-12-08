import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:online_market/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.love).existsSync(), isTrue);
    expect(File(Images.shoppingCart).existsSync(), isTrue);
    expect(File(Images.user).existsSync(), isTrue);
    expect(File(Images.cross).existsSync(), isTrue);
    expect(File(Images.go).existsSync(), isTrue);
    expect(File(Images.home).existsSync(), isTrue);
    expect(File(Images.nike).existsSync(), isTrue);
    expect(File(Images.profilePhoto).existsSync(), isTrue);
    expect(File(Images.purse).existsSync(), isTrue);
    expect(File(Images.watch).existsSync(), isTrue);
  });
}

// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:domelement/core.dart';

void main() {
  DomElement elem = find('#output');
  elem.on('click', (Event event, String data) {
    print(data);
  });
  elem.trigger('click', data: 'some data');
}

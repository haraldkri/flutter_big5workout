import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'interface/app.dart';
import 'interface/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => App()),
  ));
}

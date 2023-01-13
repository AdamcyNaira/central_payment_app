import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'payment_provider.dart';

final payStateProvider = ChangeNotifierProvider((ref) => PaymentState());
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseView extends ConsumerWidget {
  const BaseView({super.key});

  @protected
  Widget myBuild(BuildContext context, WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return myBuild(context, ref);
  }
}

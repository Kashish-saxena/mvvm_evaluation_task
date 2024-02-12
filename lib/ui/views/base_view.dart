import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/view_model/base_model.dart';
import 'package:provider/provider.dart';
import '../../core/di/locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  const BaseView({super.key, required this.builder, this.onModelReady});
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}

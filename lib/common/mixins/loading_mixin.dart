import 'package:flutter/material.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    }
  }

  void showLoadingDialog() {
    if (!_isLoading) {
      setLoading(true);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
    }
  }

  void hideLoadingDialog() {
    if (_isLoading && mounted) {
      setLoading(false);
      Navigator.of(context).pop();
    }
  }
}

import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({super.key, this.title, this.refresh});
  final String? title;
  final VoidCallback? refresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title ?? "Error"),
        ElevatedButton(
          onPressed: refresh,
          child: const Text("Retry"),
        ),
      ],
    );
  }
}

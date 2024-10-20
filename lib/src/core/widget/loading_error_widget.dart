import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({super.key, this.title, this.refresh});
  final String? title;
  final VoidCallback? refresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? "Error Loading data, Please try again later",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: refresh,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

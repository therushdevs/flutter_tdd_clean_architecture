  import 'package:flutter/material.dart';

Center loadingIndicator() {
    return const  Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(),
      ),
    );
  }
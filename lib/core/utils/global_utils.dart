  import 'package:flutter/material.dart';

Container loadingIndicator( BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height/3,
        width: 40,
        child: const Center(child: CircularProgressIndicator()),
    );
  }
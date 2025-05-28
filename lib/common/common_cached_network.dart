import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CommonCachedNetwork extends StatelessWidget {
  const CommonCachedNetwork({
    super.key,
    required this.image,
    required this.placeholder,
    this.fit,
  });
  final String image;
  final String placeholder;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';

    return CachedNetworkImage(
      fit: fit,
      imageUrl: "$supabaseUrl/storage/v1/object/public/$image",
      placeholder: (context, url) => Image.asset(placeholder),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

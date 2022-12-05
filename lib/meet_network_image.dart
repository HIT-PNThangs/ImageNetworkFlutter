import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef LoadingBuilder = Widget Function(BuildContext context);

typedef ErrorBuilder = Widget Function(BuildContext context, Object? error);

class MeetNetworkImage extends StatelessWidget {
  final String imageUrl;

  final LoadingBuilder loadingBuilder;

  final ErrorBuilder errorBuilder;

  final double scale;

  final double width;
  final double height;

  final Color? color;

  final FilterQuality filterQuality;

  final BlendMode? colorBlendMode;
  
  final BoxFit fit;

  final AlignmentGeometry alignment;

  final ImageRepeat repeat;

  final Rect? centerSlice;

  final bool matchTextDirection;

  final bool gaplessPlayback;

  final String? semanticLabel;

  final bool excludeFromSemantics;

  const MeetNetworkImage({super.key,
    required this.imageUrl,
    required this.loadingBuilder,
    required this.errorBuilder,
    this.scale = 1.0,
    required this.height,
    required this.width,
    this.color,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.semanticLabel,
    this.centerSlice,
    this.colorBlendMode,
    this.excludeFromSemantics = false,
    this.filterQuality = FilterQuality.low,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
  });

  Future<http.Response> getUrlResponse() {
    return http.get(Uri.parse(imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUrlResponse(),
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return loadingBuilder(context);

          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) return errorBuilder(context, snapshot.error);
            if (!snapshot.hasData) return errorBuilder(context, snapshot.error);

            return Image.memory(
              snapshot.data!.bodyBytes,
              scale: scale,
              height: height,
              width: width,
              color: color,
              fit: fit,
              alignment: alignment,
              repeat: repeat,
              centerSlice: centerSlice,
              colorBlendMode: colorBlendMode,
              excludeFromSemantics: excludeFromSemantics,
              filterQuality: filterQuality,
              gaplessPlayback: gaplessPlayback,
              matchTextDirection: matchTextDirection,
              semanticLabel: semanticLabel,
            );
        }
      },
    );
  }
}

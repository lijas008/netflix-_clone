import 'package:flutter/material.dart';

import '../../../constants/appcolors.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  const VideoWidget({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.wifi));
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: CircleAvatar(
              radius: 20,
              backgroundColor: backgroundColor.withOpacity(.5),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_off,
                    color: kWhiteColor,
                    size: 20,
                  ))),
        ),
      ],
    );
  }
}

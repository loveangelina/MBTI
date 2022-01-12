import 'package:flutter/material.dart';

// 프로필 이미지 위젯
class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/11/14/09/14/cat-1822979_1280.jpg'
                    ),
                  )
              ),
              margin: EdgeInsets.all(20),
            ),
            Positioned(
              child: Icon(
                Icons.photo_camera,
                size: 40,
              ),
              top: 190,
              left: 160,
            )
          ],
        ),
        Stack(
          children: [
            Text('닉네임', textScaleFactor: 1.3,),
            Positioned(
                left: 60,
                child: Icon(
                    Icons.create
                )
            )
          ],
          overflow: Overflow.visible,
        ),
      ],
    );
  }
}
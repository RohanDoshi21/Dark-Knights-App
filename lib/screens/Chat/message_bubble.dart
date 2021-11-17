import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MessageBubble(
    this.message,
    this.userName,
    this.userImageUrl,
    this.isMe,
  );

  final String message;
  final String userName;
  final String userImageUrl;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: isMe ? Color(0xff8564d6) : Color(0xffe5e5e5),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.55,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.white : Colors.black
                        // ignore: deprecated_member_use
                        // : Theme.of(context).accentTextTheme.headline6!.color,
                        ),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.white : Colors.black
                        // ignore: deprecated_member_use
                        // : Theme.of(context).accentTextTheme.headline6!.color,
                        ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 200,
          right: isMe ? 200 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImageUrl,
            ),
          ),
        ),
      ],
    );
  }
}

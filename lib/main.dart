import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final client = StreamChatClient(
    'b67pax5b2wdq',
    logLevel: Level.INFO,
  );
  await client.connectUser(
    User(id: 'stream-testing'),
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c',
  );
  // Channels are containers for holding messages between different members.
  final channel = client.channel('messaging', id: 'flutterdevs');

  await channel.watch();

  runApp(
    MyApp(
      client: client,
      channel: channel,
    ),
  );
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  const MyApp({Key? key, required this.client, required this.channel,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(client: client, child: widget);
      },
      home: StreamChannel(
        channel: channel,
        child: const ChannelPage(),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StreamChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: StreamMessageListView(
              
            ),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}

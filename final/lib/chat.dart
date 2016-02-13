import 'package:flutter/material.dart';

class ChatMessage extends StatelessComponent {
  ChatMessage(Map<String, String> source)
    : name = source['name'], text = source['text'];
  final String name;
  final String text;

  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeDims.all(3.0),
      child: new Text("$name: $text")
    );
  }
}

class ChatScreen extends StatefulComponent {
  const ChatScreen({ this.fontSize, this.user, this.messages, this.onMessageAdded });
  final double fontSize;
  final String user;
  final List<Map<String, String>> messages;
  final ValueChanged<String> onMessageAdded;

  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State {
  InputValue _currentMessage;

  void initState() {
    _currentMessage = InputValue.empty;
    super.initState();
  }

  GlobalKey _messageKey = new GlobalKey();

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new Block(children: <Widget>[
        new DrawerHeader(child: new Text(config.user ?? '')),
        new DrawerItem(
          icon: 'action/settings',
          child: new Text('Settings'),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          }
        ),
        new DrawerItem(
          icon: 'action/help',
          child: new Text('Help & Feedback'),
          onPressed: () {
            showDialog(
              context: context,
              child: new Dialog(
                title: new Text('Need help?'),
                content: new Text('Email flutter-discuss@googlegroups.com.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: new Text('OK')
                  ),
                ]
              )
            );
          }
        )
      ])
    );
  }

  void _handleMessageChanged(InputValue message) {
    setState(() {
      _currentMessage = message;
    });
  }

  void _handleMessageAdded(InputValue value) {
    config.onMessageAdded(value.text);
    setState(() {
      _currentMessage = InputValue.empty;
    });
  }

  bool get _isComposing => _currentMessage.text.length > 0;

  Widget _buildTextComposer() {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Input(
                key: _messageKey,
                value: _currentMessage,
                hintText: 'Enter message',
                keyboardType: KeyboardType.text,
                onSubmitted: _handleMessageAdded,
                onChanged: _handleMessageChanged
              )
            ),
            new Container(
              margin: const EdgeDims.symmetric(horizontal: 4.0),
              child: new FloatingActionButton(
                child: new Icon(icon: 'content/send', size: IconSize.s18),
                onPressed: () => _handleMessageAdded(_currentMessage),
                backgroundColor: _isComposing ? null : Colors.grey[500],
                mini: true
              )
            )
          ]
        )
      ]
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Chatting as ${config.user}")
      ),
      drawer: _buildDrawer(context),
      body: new Material(
        child: new DefaultTextStyle(
          style: Theme.of(context).text.body1.copyWith(fontSize: config.fontSize),
          child: new Column(
            children: [
              new Flexible(
                child: new Block(
                  padding: const EdgeDims.symmetric(horizontal: 8.0),
                  scrollAnchor: ViewportAnchor.end,
                  children: config.messages.map((m) => new ChatMessage(m)).toList()
                )
              ),
              _buildTextComposer(),
            ]
          )
        )
      )
    );
  }
}

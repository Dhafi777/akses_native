import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'URL Launcher Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';
  final String toLaunch = 'https://www.polbeng.ac.id/';

  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (!await launchUrl(launchUri, mode: LaunchMode.platformDefault)) {
    throw Exception('Could not launch $launchUri');
  }
}
  Future<void> _launchInBrowser(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            _hasCallSupport
                ? 'This device can make phone calls'
                : 'This device cannot make phone calls',
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (String text) => _phone = text,
            decoration: const InputDecoration(
              hintText: 'Input the phone number to launch',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _hasCallSupport
                ? () => setState(() {
                      _launched = _makePhoneCall(_phone);
                    })
                : null,
            child: Text(_hasCallSupport ? 'Make phone call' : 'Calling not supported'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() {
              _launched = _launchInBrowser(toLaunch);
            }),
            child: const Text('Launch in browser'),
          ),
          const SizedBox(height: 16),
          Text(toLaunch),
          const SizedBox(height: 16),
          FutureBuilder<void>(
            future: _launched,
            builder: _launchStatus,
          ),
        ],
      ),
    );
  }
}
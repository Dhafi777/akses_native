
/*import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akses Fitur Native',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akses Fitur Native'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SendSMSPage()),
                );
              },
              child: const Text('Kirim SMS'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhoneCallAndBrowserPage()),
                );
              },
              child: const Text('Panggilan & Buka URL'),
            ),
          ],
        ),
      ),
    );
  }
}

class SendSMSPage extends StatefulWidget {
  const SendSMSPage({super.key});

  @override
  State<SendSMSPage> createState() => _SendSMSPageState();
}

class _SendSMSPageState extends State<SendSMSPage> {
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  String _message = '';

  void _sendSMS(List<String> numbers, String message) async {
    if (numbers.isEmpty || message.isEmpty) {
      setState(() => _message = "Nomor atau pesan tidak boleh kosong.");
      return;
    }

    try {
      String result = await sendSMS(message: message, recipients: numbers);
      setState(() => _message = result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kirim SMS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _numController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Masukkan nomor handphone, pisahkan dengan koma jika lebih dari satu',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _msgController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Pesan SMS',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                List<String> numbers = _numController.text.split(',');
                _sendSMS(numbers, _msgController.text);
              },
              child: const Text('Kirim SMS'),
            ),
            const SizedBox(height: 20),
            Text(_message.isEmpty ? '' : 'Status: $_message'),
          ],
        ),
      ),
    );
  }
}

class PhoneCallAndBrowserPage extends StatefulWidget {
  const PhoneCallAndBrowserPage({super.key});

  @override
  State<PhoneCallAndBrowserPage> createState() => _PhoneCallAndBrowserPageState();
}

class _PhoneCallAndBrowserPageState extends State<PhoneCallAndBrowserPage> {
  bool _hasCallSupport = false;
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
      throw Exception('Tidak bisa melakukan panggilan ke $phoneNumber');
    }
  }

  Future<void> _launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak bisa membuka URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panggilan & Buka URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String text) => _phone = text,
              decoration: const InputDecoration(
                hintText: 'Masukkan nomor telepon',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hasCallSupport
                  ? () {
                      _makePhoneCall(_phone);
                    }
                  : null,
              child: const Text('Lakukan Panggilan'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _launchInBrowser(toLaunch);
              },
              child: const Text('Buka Website'),
            ),
          ],
        ),
      ),
    );
  }
} 

*/
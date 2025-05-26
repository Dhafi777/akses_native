import 'package:akses_fitur_native/helpers/dbhelper.dart';
import 'package:akses_fitur_native/models/contact.dart';
import 'package:flutter/material.dart';
import 'entryform.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;
  List<Contact> _contactList = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final database = await DbHelper.db();
      final contacts = await DbHelper.getContactList();
      setState(() {
        _contactList = contacts;
        _count = contacts.length;
      });
    } catch (e) {
      debugPrint('Error loading contacts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Manager'),
      ),
      body: _count == 0
          ? const Center(child: Text('No contacts found'))
          : _buildContactList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add Contact',
        onPressed: () => _navigateToForm(context),
      ),
    );
  }

  Widget _buildContactList() {
    return ListView.builder(
      itemCount: _count,
      itemBuilder: (context, index) {
        final contact = _contactList[index];
        return Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteContact(contact.id!),
            ),
            onTap: () => _navigateToForm(context, contact),
          ),
        );
      },
    );
  }

  Future<void> _navigateToForm(BuildContext context, [Contact? contact]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntryForm(contact ?? Contact("", "")),
      ),
    );

    if (result != null) {
      if (contact == null) {
        await _addContact(result);
      } else {
        await _editContact(result);
      }
    }
  }

  Future<void> _addContact(Contact contact) async {
    try {
      final result = await DbHelper.insert(contact);
      if (result > 0) await _loadContacts();
    } catch (e) {
      debugPrint('Error adding contact: $e');
    }
  }

  Future<void> _editContact(Contact contact) async {
    try {
      final result = await DbHelper.update(contact);
      if (result > 0) await _loadContacts();
    } catch (e) {
      debugPrint('Error updating contact: $e');
    }
  }

  Future<void> _deleteContact(int id) async {
    try {
      final result = await DbHelper.delete(id);
      if (result > 0) await _loadContacts();
    } catch (e) {
      debugPrint('Error deleting contact: $e');
    }
  }
}
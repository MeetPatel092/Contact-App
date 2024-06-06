import 'package:contact_hub/model/contact.dart';
import 'package:contact_hub/provider/hide_provider.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  List<Map<String, String>> _contacts = [];

  List<Map<String, String>> get contacts => _contacts;

  void addContact(
      {required String contactNum,
      required String email,
      required String name}) {
    _contacts.add({'contact': contactNum, 'email': email, 'name': name});
    notifyListeners();
  }

  List<Map<String, String>> filterContacts(String query) {
    if (query.isEmpty) {
      return _contacts;
    }
    return _contacts.where((contact) {
      return contact['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void hideContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
    // Notify HideProvider to add the contact
    HideProvider().addHiddenContact(contact as Map<String, String>);
  }
}

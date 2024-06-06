import 'package:contact_hub/provider/contact_provider.dart';
import 'package:flutter/material.dart';

class HideProvider with ChangeNotifier {
  List<Map<String, String>> _hiddenContacts = [];
  List<Map<String, String>> get hiddenContacts => _hiddenContacts;

  void addHiddenContact(Map<String, String> contact) {
    _hiddenContacts.add(contact);
    notifyListeners();
  }

  void unhideContact(Map<String, String> contact) {
    _hiddenContacts.remove(contact);
    notifyListeners();
    // Notify ContactProvider to add the contact back
    ContactProvider().addContact(
      name: contact['name']!,
      contactNum: contact['contact']!,
      email: contact['email']!,
    );
  }
}

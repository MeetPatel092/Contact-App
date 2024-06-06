import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_hub/provider/hide_provider.dart';
import 'package:contact_hub/provider/contact_provider.dart';

class HidePage extends StatelessWidget {
  const HidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidden Contacts"),
      ),
      body: Consumer<HideProvider>(
        builder: (context, hideProvider, _) {
          return ListView.builder(
            itemCount: hideProvider.hiddenContacts.length,
            itemBuilder: (context, index) {
              var contact = hideProvider.hiddenContacts[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      contact['name'].toString().characters.first.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text("${contact['name']}"),
                  subtitle: Text("${contact['contact']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.unarchive_outlined),
                    onPressed: () {
                      Provider.of<HideProvider>(context, listen: false)
                          .unhideContact(contact);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

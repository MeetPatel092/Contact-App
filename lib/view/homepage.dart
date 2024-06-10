import 'package:contact_hub/provider/hide_provider.dart';
import 'package:contact_hub/provider/search_provider.dart';
import 'package:contact_hub/provider/sterpper_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_hub/provider/contact_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertBox();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Contact Hub",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("hide");
            },
            icon: const Icon(Icons.archive_outlined),
          ),
        ],
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            CircleAvatar(
              radius: 2,
            ),
            Text("Meet")
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Contacts",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    Provider.of<SearchProvider>(context, listen: false)
                        .clearSearchQuery();
                  },
                ),
              ),
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false)
                    .setSearchQuery(value.toLowerCase());
              },
            ),
          ),
          Expanded(
            child: Consumer<ContactProvider>(
              builder: (context, contactProvider, _) {
                return ListView.builder(
                  itemCount: contactProvider.contacts.length,
                  itemBuilder: (context, index) {
                    var contact = contactProvider.contacts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            contact['name']
                                .toString()
                                .characters
                                .first
                                .toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text("${contact['name']}"),
                        subtitle: Text("${contact['contact']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                            ),
                            PopupMenuButton(
                              itemBuilder: (contaxt) {
                                return <PopupMenuEntry>[
                                  PopupMenuItem(
                                    onTap: () {
                                      Provider.of<HideProvider>(context)
                                          .addHiddenContact(contact);
                                    },
                                    child: const Text("Hide"),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  const AlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController contactController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return AlertDialog(
      title: const Text("Add New Contact"),
      content: Consumer<StepperProvider>(
        builder: (context, stepperModel, _) {
          return SizedBox(
            width: 350,
            child: Stepper(
              currentStep: stepperModel.count,
              onStepContinue: () {
                if (stepperModel.count < 2) {
                  stepperModel.incrementStep();
                } else {
                  Provider.of<ContactProvider>(context, listen: false)
                      .addContact(
                    contactNum: contactController.text,
                    email: emailController.text,
                    name: nameController.text,
                  );
                  // Clear text fields
                  nameController.clear();
                  contactController.clear();
                  emailController.clear();
                  // Reset stepper
                  stepperModel.resetStep();
                  Navigator.of(context).pop();
                }
              },
              onStepCancel: stepperModel.decrementStep,
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (stepperModel.count > 0 && stepperModel.count <= 2)
                      TextButton(
                        onPressed: controls.onStepCancel,
                        child: const Text('Back'),
                      ),
                    TextButton(
                      onPressed: controls.onStepContinue,
                      child:
                          Text(stepperModel.count == 2 ? 'Save' : 'Continue'),
                    ),
                  ],
                );
              },
              steps: [
                Step(
                  state: stepperModel.count > 0
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: stepperModel.count >= 1,
                  title: const Text("Name"),
                  content: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Step(
                  state: stepperModel.count > 1
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: stepperModel.count >= 2,
                  title: const Text("Contact"),
                  content: TextField(
                    keyboardType: TextInputType.number,
                    controller: contactController,
                    decoration: const InputDecoration(
                      hintText: "Enter Contact Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Step(
                  state: stepperModel.count > 2
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: stepperModel.count >= 3,
                  title: const Text("Email"),
                  content: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

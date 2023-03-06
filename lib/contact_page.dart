import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_contact_app/model/contact.dart';
import 'package:hive_contact_app/new_conntact_form.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildListView(),
          ),
          const NewContactForm(),
        ],
      ),
    );
  }

  ListView _buildListView() {
    final contactBox = Hive.box("contact");

    return ListView.builder(
      itemCount: contactBox.length,
      itemBuilder: (context, index) {
        final contact = contactBox.get(index) as Contact;
        return ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.age.toString()),
        );
      },
    );
  }
}

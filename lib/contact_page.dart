import 'package:flutter/material.dart';
import 'package:hive_contact_app/model/contact.dart';
import 'package:hive_contact_app/new_conntact_form.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  Widget _buildListView() {
    // final contactBox = Hive.box("contact");

    return ValueListenableBuilder(
      valueListenable: Hive.box("contact").listenable(),
      builder: (context, box, snapshot) {
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            final contact = box.get(index) as Contact;
            return ListTile(
              title:  Text(contact.name),
              subtitle: Text(contact.age.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        box.putAt(
                            index, Contact("${contact.name}*", contact.age));
                      },
                      icon: const Icon(Icons.refresh)),
                  IconButton(
                      onPressed: () {
                        box.deleteAt(index);
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_contact_app/model/contact.dart';

// import 'models/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({super.key});

  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _age;

  void addContact(Contact contact) {
    print("Name ${contact.name} + Age ${contact.age}");
    final contactsBox = Hive.box('contact');
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _age = value,
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: const Text('Add New Contact'),
            onPressed: () {
              print("HERE IS $_name ");
              _formKey.currentState!.save();
              final newContact = Contact(_name!, int.parse(_age!));
              addContact(newContact);
            },
          ),
        ],
      ),
    );
  }
}

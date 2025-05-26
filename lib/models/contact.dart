class Contact {
  int? id;
  late String name;
  late String phone;

  Contact(this.name, this.phone);

  Contact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
  }

  // Convert a contact into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  // Implement toString to make it easier to see information about
  // each contact when using the print statement.
  @override
  String toString() {
    return 'Contact{id: $id, name: $name, phone: $phone}';
  }
}

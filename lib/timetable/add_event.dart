// import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// class AddEvent extends StatefulWidget {
//   @override
//   _AddEventState createState() => _AddEventState();
// }

// class _AddEventState extends State<AddEvent> {
//   final _formKey = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Event"),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Form(
//               child: Column(
//             children: [
//               TextFormField(decoration: textFormDecoration("Add title")),
//               Divider(),
//               TextFormField(decoration: textFormDecoration("Add details")),
//               SwitchListTile(
//                   title: Text("Public"), value: false, onChanged: (_) {}),
//               // DateTimeField(onShowPicker: )
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }

// InputDecoration textFormDecoration(String label) {
//   return InputDecoration(
//     labelText: label,
//     border: InputBorder.none,
//     contentPadding: const EdgeInsets.only(left: 40),
//   );
// }

import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';

class DrawerContent extends StatefulWidget {
  final CartManager cartManager;
  const DrawerContent({super.key, required this.cartManager});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  bool _isDelivery = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _displayMessage = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text(
              'Order Details',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDelivery = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            _isDelivery ? Colors.pink.shade100 : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delivery_dining_outlined),
                          Text('Delivery'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDelivery = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            _isDelivery ? Colors.white : Colors.pink.shade100,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_outlined),
                          Text('Pickup'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Name',
                      hintText: 'Enter the Contact Name here',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contact Name is required';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              _selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                            },
                            child: Text(
                              'Select Time',
                              style: TextStyle(color: Colors.pink.shade500),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          _selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                        },
                        child: Text(
                          'Select Date',
                          style: TextStyle(color: Colors.pink.shade500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _displayMessage
                ? Text(
                  'Please select a Date and Time',
                  style: TextStyle(color: Colors.red),
                )
                : Container(),
            Text(
              'Order Summary',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.pink.shade500,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'x${widget.cartManager.items[index].quantity}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    title: Text(widget.cartManager.items[index].name),
                    subtitle: Text(
                      'price: \$ ${widget.cartManager.items[index].price.toString()}',
                    ),
                  );
                },
                itemCount: widget.cartManager.items.length,
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null &&
                      _selectedTime != null) {
                    Navigator.pop(context);
                  }
                  if (_selectedDate == null || _selectedTime == null) {
                    setState(() {
                      _displayMessage = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Submit Order - \$149.91',
                  style: TextStyle(
                    color: Colors.pink.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

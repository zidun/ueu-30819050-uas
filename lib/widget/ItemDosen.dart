import 'package:flutter/material.dart';

class ItemDosen extends StatelessWidget {
  final String nip;
  final String name;
  final String address;
  final Function()? onEdit;
  final Function()? onDelete;

  const ItemDosen({
    Key? key,
    required this.nip,
    required this.name,
    required this.address,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nip,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                ),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                ),
                Text(
                  address,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

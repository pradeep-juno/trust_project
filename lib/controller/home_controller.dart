import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_event/model/customer_model.dart';
import 'package:jk_event/utils/constants.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerMobileNumberController =
      TextEditingController();
  final customerPurposeOfDonationController = TextEditingController();
  final customerDonateController = TextEditingController();
  final customerAddressController = TextEditingController();

  RxList<Customer> customerList = <Customer>[].obs;

  // Constructor to apply text formatting
  HomeController() {
    _applyTextFormatting();
  }

  // Method to ensure first letter is capitalized
  void _applyTextFormatting() {
    customerNameController.addListener(() {
      final text = customerNameController.text;
      if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
        customerNameController.value = customerNameController.value.copyWith(
          text: text[0].toUpperCase() + text.substring(1),
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });

    customerPurposeOfDonationController.addListener(() {
      final text = customerPurposeOfDonationController.text;
      if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
        customerPurposeOfDonationController.value =
            customerPurposeOfDonationController.value.copyWith(
          text: text[0].toUpperCase() + text.substring(1),
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });

    customerAddressController.addListener(() {
      final text = customerAddressController.text;
      if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
        customerAddressController.value =
            customerAddressController.value.copyWith(
          text: text[0].toUpperCase() + text.substring(1),
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });
  }

  Future<void> saveCustomerDetails(
      BuildContext context, Function() onSaveComplete) async {
    if (await validateFields(context)) {
      var docRef =
          firebaseFirestore.collection(AppConstant.collectionCustomer).doc();

      var customerId = docRef.id;

      print("Customer Name : ${customerNameController.text}");

      var customerData = Customer(
          customerId: customerId,
          customerName: customerNameController.text.trim().toString(),
          customerMobileNumber:
              customerMobileNumberController.text.trim().toString(),
          customerPurposeOfDonation:
              customerPurposeOfDonationController.text.trim().toString(),
          customerDonate: customerDonateController.text.trim().toString(),
          customerAddress: customerAddressController.text.trim().toString());

      print("CustomerData : ${customerData.toString()}");

      await docRef.set(customerData.toMap());

      onSaveComplete();
      Get.back();

      clearController(context);
    }
  }

  validateFields(BuildContext context) {
    if (customerNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill the name field',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red, // Red color for the error
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false; // Validation failed, stop further validation
    }

    if (customerMobileNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill the mobile number field',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red, // Red color for the error
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false; // Validation failed, stop further validation
    }

    if (customerPurposeOfDonationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill the PurposeOfDonation field',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red, // Red color for the error
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false; // Validation failed, stop further validation
    }
    if (customerDonateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill the Donate field',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red, // Red color for the error
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false; // Validation failed, stop further validation
    }
    if (customerAddressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill the address field',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red, // Red color for the error
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false; // Validation failed, stop further validation
    }

    //clearController(context);
    return true;
  }

  void clearController(BuildContext context) {
    customerNameController.clear();
    customerMobileNumberController.clear();
    customerPurposeOfDonationController.clear();
    customerDonateController.clear();
    customerAddressController.clear();
  }
}

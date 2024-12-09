import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/home_controller.dart';
import '../controller/login_controller.dart';
import '../model/customer_model.dart';
import '../router/routers.dart';
import '../utils/constants.dart';
import '../utils/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());

  bool _isCustomerDetailsVisible = false; // Track visibility of the container
  Customer? _selectedCustomer; // To store selected customer details

  @override
  void initState() {
    super.initState();
    _loadUserData();
    homeController.fetchCustomers(); // Fetch customers from the controller
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? 'Not Available';
    print("AdminId : $id");
    loginController.listenAdminDataUpdates(context, id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: Obx(() {
            String initials = loginController.adminName.value.isNotEmpty
                ? loginController.adminName.value.substring(0, 2).toUpperCase()
                : "--";
            return Row(
              children: [
                buildCircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  text: initials,
                  color: Colors.white,
                  fontweight: FontWeight.bold,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFun(
                      context,
                      title:
                          "${AppConstant.hi}, ${loginController.adminName.value}!",
                      fontsize: 18,
                      fontweight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    buildTextFun(
                      context,
                      title: "${loginController.mobileNumber.value}",
                      fontsize: 14,
                      fontweight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ],
                ),
                buildSizedBoxWidthFun(context, width: 350),
                buildTextFun(
                  context,
                  title: AppConstant.ajayTrust,
                  fontsize: 30,
                  fontweight: FontWeight.bold,
                  color: Colors.red,
                )
              ],
            );
          }),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Get.offNamed(AppRouter.LOGIN_SCREEN);
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            // Customer List
            Obx(() {
              return ListView.builder(
                itemCount: homeController.customerList.length,
                itemBuilder: (context, index) {
                  final customerData = homeController.customerList[index];
                  return ListTile(
                    title: buildTextFun(
                      context,
                      title: "Customer Name: ${customerData.customerName}",
                      fontsize: 14,
                      fontweight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    subtitle: buildTextFun(
                      context,
                      title: "Customer Donate: ${customerData.customerDonate}",
                      fontsize: 14,
                      fontweight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _isCustomerDetailsVisible = true;
                                _selectedCustomer = customerData;
                              });
                            },
                            icon: Icon(Icons.edit, color: Colors.red)),
                        IconButton(
                            onPressed: () {
                              homeController.deleteCustomerData(
                                  context, customerData.customerId);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                },
              );
            }),

            // Customer Details Container
            if (_isCustomerDetailsVisible)
              buildCustomerUIFun(context, _selectedCustomer),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _isCustomerDetailsVisible = true;
              _selectedCustomer = null; // Open container for new entry
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  buildCustomerUIFun(BuildContext context, Customer? customerData) {
    if (customerData != null) {
      homeController.customerNameController.text = customerData.customerName;
      homeController.customerMobileNumberController.text =
          customerData.customerMobileNumber;
      homeController.customerPurposeOfDonationController.text =
          customerData.customerPurposeOfDonation;
      homeController.customerDonateController.text =
          customerData.customerDonate;
      homeController.customerAddressController.text =
          customerData.customerAddress;
    } else {
      homeController.clearController(context);
    }

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTextFun(
                  context,
                  title: AppConstant.customerDetails,
                  fontsize: 22,
                  fontweight: FontWeight.bold,
                  color: Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _isCustomerDetailsVisible = false;
                      _selectedCustomer = null;
                    });
                  },
                ),
              ],
            ),
            buildSizedBoxHeightFun(context, height: 10),
            buildTextFormFieldFun(
              context,
              isPassword: false,
              hint: AppConstant.name,
              controller: homeController.customerNameController,
              border: true,
            ),
            buildSizedBoxHeightFun(context, height: 10),
            buildTextFormFieldFun(
              context,
              isPassword: false,
              hint: AppConstant.mobile,
              controller: homeController.customerMobileNumberController,
              border: true,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            buildSizedBoxHeightFun(context, height: 10),
            buildTextFormFieldFun(
              context,
              isPassword: false,
              hint: AppConstant.purposeOfDonation,
              controller: homeController.customerPurposeOfDonationController,
              border: true,
            ),
            buildSizedBoxHeightFun(context, height: 10),
            buildTextFormFieldFun(
              context,
              isPassword: false,
              hint: AppConstant.donate,
              icon: Icons.currency_rupee,
              controller: homeController.customerDonateController,
              border: true,
              keyboardType: TextInputType.number,
            ),
            buildSizedBoxHeightFun(context, height: 10),
            buildTextFormFieldFun(
              context,
              isPassword: false,
              hint: AppConstant.address,
              controller: homeController.customerAddressController,
              border: true,
              maxLines: 2,
            ),
            buildSizedBoxHeightFun(context, height: 20),
            Center(
              child: buildContainerButtonFun(
                context,
                customerData != null ? AppConstant.update : AppConstant.submit,
                color: Colors.blue,
                onPressed: () async {
                  final onSaveComplete = () {
                    setState(() {
                      _isCustomerDetailsVisible = false;
                    });
                  };

                  if (customerData != null) {
                    await homeController.addUpdateCustomerDetails(
                        context, onSaveComplete, customerData);
                  } else {
                    await homeController.addUpdateCustomerDetails(
                        context, onSaveComplete, null);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

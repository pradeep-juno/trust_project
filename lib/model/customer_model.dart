class Customer {
  String customerId;
  String customerName;
  String customerMobileNumber;
  String customerPurposeOfDonation;
  String customerDonate;
  String customerAddress;

  // Constructor
  Customer({
    required this.customerId,
    required this.customerName,
    required this.customerMobileNumber,
    required this.customerPurposeOfDonation,
    required this.customerDonate,
    required this.customerAddress,
  });

  // Method to create an instance from a map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      customerMobileNumber: map['customerMobileNumber'] ?? '',
      customerPurposeOfDonation: map['customerPurposeOfDonation'] ?? '',
      customerDonate: map['customerDonate'] ?? '',
      customerAddress: map['customerAddress'] ?? '',
    );
  }

  // Method to convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerMobileNumber': customerMobileNumber,
      'customerPurposeOfDonation': customerPurposeOfDonation,
      'customerDonate': customerDonate,
      'customerAddress': customerAddress,
    };
  }

  // Method to convert the object to a string
  @override
  String toString() {
    return 'Customer{customerId: $customerId, customerName: $customerName, customerMobileNumber: $customerMobileNumber, customerPurposeOfDonation: $customerPurposeOfDonation, customerDonate: $customerDonate, customerAddress: $customerAddress}';
  }
}

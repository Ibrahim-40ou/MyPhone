import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_phone/Models/order.dart';

import '../Models/product.dart';
import '../View/HomeView/cart.dart';
import '../View/HomeView/main.dart';
import '../View/HomeView/settings.dart';
import '../Widgets/text.dart';
import '../main.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    fetchOffers();
    fetchBestSelling();
    await fetchCartItems();
    await fetchPendingOrders();
    await fetchFinishedOrders();
    await fetchAllProducts();
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController ramController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController recipientFullNameController = TextEditingController();
  TextEditingController recipientPhoneNumberController =
      TextEditingController();
  TextEditingController closestKnownPointController = TextEditingController();

  PageController pageController = PageController();

  int currentIndex = 0;
  void changePage(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
    update();
  }

  List<BottomNavigationBarItem> navigationBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: 'home'.tr,
    ),
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.cart),
      activeIcon: const Icon(CupertinoIcons.cart_fill),
      label: 'cart'.tr,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings_outlined),
      activeIcon: const Icon(Icons.settings),
      label: 'settings'.tr,
    ),
  ];

  List<Widget> pageViewItems = [
    const Main(),
    const Cart(),
    const AppSettings(),
  ];

  bool isLoading = false;
  void toggleLoading(bool state) {
    isLoading = state;
    update();
  }

  String errorText = '';
  bool signOutError = false;
  void exitDialogue() {
    signOutError = false;
    errorText = '';
    update();
  }

  void signOut() async {
    try {
      toggleLoading(true);
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      toggleLoading(false);
      loginCheck!.clear();
      Get.offAllNamed('/');
    } on FirebaseAuthException catch (e) {
      toggleLoading(false);
      print(e.code);
    }
  }

  Map<String, List<Product>> fetchedProducts = {
    'phones': [],
    'laptops': [],
    'headphones': [],
    'watches': [],
    'bands': [],
    'chargers': [],
    'cases': [],
    'others': [],
  };
  Map<String, Set<String>> fetchedBrands = {
    'phones': {},
    'laptops': {},
    'headphones': {},
    'watches': {},
    'bands': {},
    'chargers': {},
    'cases': {},
    'others': {},
  };

  bool fetchingBrandProducts = false;

  void toggleFetching(bool state) {
    fetchingBrandProducts = state;
    update();
  }

  Future fetchBrandProducts(
    String collectionPath,
    String fieldName,
    String fieldValue,
  ) async {
    try {
      if (fetchedBrands[collectionPath]!.contains(fieldValue)) {
        return;
      }
      toggleFetching(true);
      final CollectionReference categoryRef =
          FirebaseFirestore.instance.collection(collectionPath);
      final QuerySnapshot brandSnapshot =
          await categoryRef.where(fieldName, isEqualTo: fieldValue).get();
      if (brandSnapshot.docs.isNotEmpty) {
        DocumentSnapshot brandDocument = brandSnapshot.docs.first;
        CollectionReference productsCollection =
            brandDocument.reference.collection('products');
        QuerySnapshot productsSnapshot = await productsCollection.get();
        for (var doc in productsSnapshot.docs) {
          fetchedProducts[collectionPath]!
              .add(Product.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
      fetchedBrands[collectionPath]!.add(fieldValue);
      toggleFetching(false);
    } on FirebaseException catch (e) {
      toggleFetching(false);
      print(e.code);
    }
  }

  List<Product> offers = [];
  bool fetchingOffers = false;
  Future fetchOffers() async {
    try {
      fetchingOffers = true;
      update();

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('offers').get();
      for (var product in querySnapshot.docs) {
        offers.add(
          Product.fromJson(
            product.data() as Map<String, dynamic>,
          ),
        );
      }

      fetchingOffers = false;
      update();
    } on FirebaseException catch (e) {
      fetchingOffers = false;
      update();
      print(e.code);
    }
  }

  List<Product> bestSelling = [];
  bool fetchingBestSelling = false;
  Future fetchBestSelling() async {
    fetchingBestSelling = true;
    update();
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('bestSelling').get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        bestSelling.add(Product.fromJson(data));
      }
      fetchingBestSelling = false;
      update();
    } on FirebaseException catch (e) {
      fetchingBestSelling = false;
      update();
      print(e.code);
    }
  }

  List<Product> allProducts = [];
  bool fetchingAllProducts = false;
  Future fetchAllProducts() async {
    try {
      fetchingAllProducts = true;
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('allProducts').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          allProducts.add(
            Product.fromJson(doc.data() as Map<String, dynamic>),
          );
        }
      }
      fetchingAllProducts = false;
      update();
    } on FirebaseException catch (e) {
      fetchingAllProducts = false;
      update();
      print(e.code);
    }
  }

  List<Product> cart = [];
  double get totalPrice {
    double total = 0.0;
    for (Product product in cart) {
      if (product.price != null && product.quantityInCart != null) {
        double price = product.price!;
        total += price * (product.quantityInCart ?? 0);
      }
    }
    return total;
  }

  bool addingToCart = false;
  bool addToCartSnackBar = false;
  Future addToCart(Product item) async {
    try {
      addToCartSnackBar = false;
      addingToCart = true;
      update();
      await Future.delayed(const Duration(milliseconds: 500));
      int index =
          cart.indexWhere((product) => product.productId == item.productId);
      if (index != -1) {
        changeQuantityInCart(cart[index], true);
        addingToCart = false;
        addToCartSnackBar = false;
        update();
        return;
      }
      item.quantityInCart = 1;
      cart.add(item);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('cart')
          .doc(item.productId)
          .set(item.toJson());
      addingToCart = false;
      addToCartSnackBar = true;
      update();
    } on FirebaseException catch (e) {
      addingToCart = false;
      addToCartSnackBar = false;
      update();
      print(e.code);
    }
  }

  bool fetchingCartItems = false;
  Future fetchCartItems() async {
    try {
      fetchingCartItems = true;
      update();
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('cart')
          .get();
      for (var doc in cartSnapshot.docs) {
        cart.add(Product.fromJson(doc.data() as Map<String, dynamic>));
      }
      fetchingCartItems = false;
      update();
    } on FirebaseException catch (e) {
      fetchingCartItems = false;
      update();
      print(e.code);
    }
  }

  bool editingCart = false;
  List<String> toBeDeleted = [];
  void toggleCartEdit(bool state) {
    editingCart = state;
    update();
  }

  void selectItem(String id) {
    toggleCartEdit(true);
    if (toBeDeleted.contains(id)) {
      toBeDeleted.remove(id);
    } else {
      toBeDeleted.add(id);
    }
    update();
  }

  void cancelCartEdit() {
    toBeDeleted.clear();
    toggleCartEdit(false);
  }

  void deleteItems() {
    try {
      for (String id in toBeDeleted) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('cart')
            .doc(id)
            .delete();
        cart.removeWhere((item) => item.productId == id);
      }
      Get.back();
      cancelCartEdit();
      return;
    } on FirebaseException catch (e) {
      Get.back();
      cancelCartEdit();
      print(e.code);
    }
  }

  void changeQuantityInCart(Product item, bool isPlus) {
    try {
      int quantity =
          (isPlus) ? item.quantityInCart! + 1 : item.quantityInCart! - 1;
      if (quantity == 0) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('cart')
            .doc(item.productId)
            .delete();
        cart.removeWhere((product) => product.productId == item.productId);
        update();
        return;
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('cart')
          .doc(item.productId)
          .update(
        {
          'quantityInCart': quantity,
        },
      );
      int index =
          cart.indexWhere((product) => item.productId == product.productId);
      cart[index].quantityInCart = quantity;
      update();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  static Widget _buildTextWidget(String text) {
    return MyText(
      text: text,
      size: 16,
      weight: FontWeight.normal,
      color: Colors.black,
      overflow: TextOverflow.fade,
    );
  }

  String? category;
  List<DropdownMenuItem<String>> categories = [
    DropdownMenuItem(
      value: 'all',
      child: _buildTextWidget('All Categories'),
    ),
    DropdownMenuItem(
      value: 'phones',
      child: _buildTextWidget('Phones'),
    ),
    DropdownMenuItem(
      value: 'laptops',
      child: _buildTextWidget('Laptops'),
    ),
    DropdownMenuItem(
      value: 'headphones',
      child: _buildTextWidget('Headphones'),
    ),
    DropdownMenuItem(
      value: 'watches',
      child: _buildTextWidget('Smart Watches'),
    ),
    DropdownMenuItem(
      value: 'bands',
      child: _buildTextWidget('Smart Bands'),
    ),
    DropdownMenuItem(
      value: 'chargers',
      child: _buildTextWidget('Chargers And Cables'),
    ),
    DropdownMenuItem(
      value: 'cases',
      child: _buildTextWidget('Cases'),
    ),
    DropdownMenuItem(
      value: 'others',
      child: _buildTextWidget('Others'),
    ),
  ];
  void selectCategory(String? selectedCategory) {
    category = selectedCategory!;
    update();
  }

  String? brand;
  List<DropdownMenuItem<String>> brands = [
    DropdownMenuItem(
      value: 'all',
      child: _buildTextWidget('All Brands'),
    ),
    DropdownMenuItem(
      value: 'apple',
      child: _buildTextWidget('Apple'),
    ),
    DropdownMenuItem(
      value: 'samsung',
      child: _buildTextWidget('Samsung'),
    ),
    DropdownMenuItem(
      value: 'huawei',
      child: _buildTextWidget('Huawei'),
    ),
    DropdownMenuItem(
      value: 'google',
      child: _buildTextWidget('Google'),
    ),
    DropdownMenuItem(
      value: 'xiaomi',
      child: _buildTextWidget('Xiaomi'),
    ),
    DropdownMenuItem(
      value: 'asus',
      child: _buildTextWidget('Asus'),
    ),
    DropdownMenuItem(
      value: 'hp',
      child: _buildTextWidget('Hp'),
    ),
    DropdownMenuItem(
      value: 'sony',
      child: _buildTextWidget('Sony'),
    ),
  ];
  void selectBrand(String? selectedBrand) {
    brand = selectedBrand!;
    update();
  }

  String? priceSort;
  List<DropdownMenuItem<String>> sortByPrice = [
    DropdownMenuItem(
      value: 'ascending',
      child: _buildTextWidget('ascending: lowest to highest'),
    ),
    DropdownMenuItem(
      value: 'descending',
      child: _buildTextWidget('descending: highest to lowest'),
    ),
  ];
  void selectPriceSort(String? selectedPriceSort) {
    priceSort = selectedPriceSort;
    update();
  }

  List<Product> searchResult = [];
  bool searchingProducts = false;
  void searchProducts() {
    searchResult.clear();
    searchingProducts = true;
    update();

    bool hasFilters = category != null ||
        brand != null ||
        minPriceController.text.isNotEmpty ||
        maxPriceController.text.isNotEmpty ||
        capacityController.text.isNotEmpty ||
        ramController.text.isNotEmpty;

    if (searchController.text.isEmpty && hasFilters == false) {
      searchResult.clear();
      searchingProducts = false;
      update();
      return;
    }

    for (Product product in allProducts) {
      bool matchesSearchQuery = searchController.text.isEmpty ||
          product.name!
              .toLowerCase()
              .contains(searchController.text.toLowerCase());
      bool matchesCategory =
          category == null || product.category == category || category == 'all';
      bool matchesBrand = brand == null ||
          product.brand!.toLowerCase() == brand ||
          brand == 'all';
      bool matchesCapacity = capacityController.text.isEmpty ||
          (product.memory != null &&
              product.memory!.split('/').first == capacityController.text);
      bool matchesRam = ramController.text.isEmpty ||
          (product.memory != null &&
              product.memory!.split('/').last == ramController.text);
      bool matchesPrice = (minPriceController.text.isEmpty &&
              maxPriceController.text.isEmpty) ||
          (minPriceController.text.isNotEmpty &&
              product.price! >= double.parse(minPriceController.text) &&
              (maxPriceController.text.isEmpty ||
                  product.price! <= double.parse(maxPriceController.text))) ||
          (maxPriceController.text.isNotEmpty &&
              product.price! <= double.parse(maxPriceController.text) &&
              (minPriceController.text.isEmpty ||
                  product.price! >= double.parse(minPriceController.text)));

      if (searchController.text.isEmpty && hasFilters == true) {
        if (matchesCategory &&
            matchesBrand &&
            matchesCapacity &&
            matchesRam &&
            matchesPrice) {
          searchResult.add(product);
        }
      } else if (searchController.text.isNotEmpty && hasFilters == true) {
        if (matchesSearchQuery &&
            matchesCategory &&
            matchesBrand &&
            matchesCapacity &&
            matchesRam &&
            matchesPrice) {
          searchResult.add(product);
        }
      } else if (searchController.text.isNotEmpty && hasFilters == false) {
        if (matchesSearchQuery) {
          searchResult.add(product);
        }
      }
    }

    if (priceSort != null) {
      if (priceSort == 'ascending') {
        searchResult.sort(
          (a, b) {
            double priceA = a.price!;
            double priceB = b.price!;
            return priceA.compareTo(priceB);
          },
        );
      } else if (priceSort == 'descending') {
        searchResult.sort(
          (a, b) {
            double priceA = a.price!;
            double priceB = b.price!;
            return priceB.compareTo(priceA);
          },
        );
      }
    }
    searchingProducts = false;
    update();
  }

  void clearSearch() {
    searchController.clear();
    category = null;
    brand = null;
    minPriceController.clear();
    maxPriceController.clear();
    capacityController.clear();
    ramController.clear();
    searchResult.clear();
    update();
    Get.back();
  }

  bool editingFilters = false;
  String? preEditCategory;
  String? preEditBrand;
  String? preEditMinPrice;
  String? preEditMaxPrice;
  String? preEditCapacity;
  String? preEditRam;
  void editFilters() {
    preEditCategory = category;
    preEditBrand = brand;
    preEditMinPrice = minPriceController.text;
    preEditMaxPrice = maxPriceController.text;
    preEditCapacity = capacityController.text;
    preEditRam = ramController.text;
    editingFilters = true;
    update();
  }

  void cancelEditingFilters() {
    category = preEditCategory;
    brand = preEditBrand;
    minPriceController.text = preEditMinPrice ?? '';
    maxPriceController.text = preEditMaxPrice ?? '';
    capacityController.text = preEditCapacity ?? '';
    ramController.text = preEditRam ?? '';
    editingFilters = false;
    update();
    Get.back();
  }

  void finishEditingFilters() {
    editingFilters = false;
    update();
  }

  void onLeaveFilters() {
    cancelEditingFilters();
    Get.back();
  }

  String? governorate;
  List<DropdownMenuItem<String>> governorates = [
    DropdownMenuItem(
      value: 'baghdad',
      child: _buildTextWidget('Baghdad'),
    ),
    DropdownMenuItem(
      value: 'babil',
      child: _buildTextWidget('Babil'),
    ),
    DropdownMenuItem(
      value: 'al-anbar',
      child: _buildTextWidget('Al-Anbar'),
    ),
    DropdownMenuItem(
      value: 'al-basra',
      child: _buildTextWidget('Al-Basra'),
    ),
    DropdownMenuItem(
      value: 'thi qar',
      child: _buildTextWidget('Thi Qar'),
    ),
    DropdownMenuItem(
      value: 'al-qadisiyyah',
      child: _buildTextWidget('Al-Qadisiyyah'),
    ),
    DropdownMenuItem(
      value: 'diyala',
      child: _buildTextWidget('Diyala'),
    ),
    DropdownMenuItem(
      value: 'duhok',
      child: _buildTextWidget('Duhok'),
    ),
    DropdownMenuItem(
      value: 'erbil',
      child: _buildTextWidget('Erbil'),
    ),
    DropdownMenuItem(
      value: 'karbalaa',
      child: _buildTextWidget('Karbalaa'),
    ),
    DropdownMenuItem(
      value: 'kirkuk',
      child: _buildTextWidget('Kirkuk'),
    ),
    DropdownMenuItem(
      value: 'maysan',
      child: _buildTextWidget('Maysan'),
    ),
    DropdownMenuItem(
      value: 'al-muthanna',
      child: _buildTextWidget('Al-Muthanna'),
    ),
    DropdownMenuItem(
      value: 'al-najaf',
      child: _buildTextWidget('Al-Najaf'),
    ),
    DropdownMenuItem(
      value: 'al-mosul',
      child: _buildTextWidget('Al-Mosul'),
    ),
    DropdownMenuItem(
      value: 'salah al-din',
      child: _buildTextWidget('Salah Al-Din'),
    ),
    DropdownMenuItem(
      value: 'sulaymaniyah',
      child: _buildTextWidget('Sulaymaniyah'),
    ),
    DropdownMenuItem(
      value: 'wasit',
      child: _buildTextWidget('Wasit'),
    ),
  ];
  void selectGovernorate(String? selectedGovernorate) {
    governorate = selectedGovernorate;
    update();
  }

  bool confirmingOrder = false;
  bool successfullyPlaced = false;
  final checkoutFormKey = GlobalKey<FormState>();
  String? validatePhoneNumber(String? number) {
    List<String> prefixes = ['077', '078', '079', '075'];

    if (number == null) return 'Phone number cannot be empty.';
    if (number.isEmpty) return 'Phone number cannot be empty.';
    String phoneNumber = number.trim().replaceAll(' ', '');

    if (phoneNumber.length != 11) {
      return 'Enter a valid phone number (must be 11 digits).';
    }

    bool startsWithValidPrefix = false;
    for (String prefix in prefixes) {
      if (phoneNumber.startsWith(prefix)) {
        startsWithValidPrefix = true;
        break;
      }
    }

    if (!startsWithValidPrefix) {
      return 'Enter a valid number (must start with 077, 078, 079, 075).';
    }

    return null;
  }

  String? validateGovernorate(String? governorate) =>
      (governorate == null) ? 'Enter a valid governorate.' : null;
  String? validateLocation(String? location) =>
      (location!.isEmpty) ? 'Enter a valid location.' : null;

  Future confirmOrder() async {
    try {
      confirmingOrder = true;
      update();
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference =
          await FirebaseFirestore.instance.collection('orders').add(
                MyOrder(
                  userId: currentUserId,
                  recipientFullName: recipientFullNameController.text,
                  phoneNumber: recipientPhoneNumberController.text,
                  governorate: governorate,
                  closestKnownPoint: closestKnownPointController.text,
                  status: 'pending',
                  date: DateFormat('dd-MM-yy').format(DateTime.now()),
                  totalPrice: totalPrice.toString(),
                ).toJson(),
              );
      documentReference.update({'orderId': documentReference.id});
      for (Product product in cart) {
        documentReference
            .collection('products')
            .doc(product.productId)
            .set(product.toJson());
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('cart')
            .doc(product.productId!)
            .delete();
      }
      confirmingOrder = false;
      successfullyPlaced = true;
      cart.clear();
      update();
      fetchPendingOrders();
    } on FirebaseException catch (e) {
      successfullyPlaced = false;
      confirmingOrder = false;
      update();
      print(e.code);
    }
  }

  void clearCheckout() {
    recipientFullNameController.clear();
    recipientPhoneNumberController.clear();
    governorate = null;
    closestKnownPointController.clear();
    update();
  }

  List<MyOrder> pendingOrders = [];
  List<List<Product>> pendingOrdersProducts = [];
  bool fetchingPendingOrders = false;
  Future fetchPendingOrders() async {
    try {
      fetchingPendingOrders = true;
      update();
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: currentUserId)
          .get();

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('processingOrders')
          .where('userId', isEqualTo: currentUserId)
          .get();

      pendingOrders.clear();
      pendingOrdersProducts.clear();

      for (var doc in querySnapshot.docs) {
        pendingOrders.add(MyOrder.fromJson(doc.data() as Map<String, dynamic>));

        QuerySnapshot productsSnapshot =
            await doc.reference.collection('products').get();

        List<Product> products = [];

        for (var productDoc in productsSnapshot.docs) {
          products
              .add(Product.fromJson(productDoc.data() as Map<String, dynamic>));
        }

        pendingOrdersProducts.add(products);
      }

      for (var doc in snapshot.docs) {
        pendingOrders.add(MyOrder.fromJson(doc.data() as Map<String, dynamic>));

        QuerySnapshot productsSnapshot =
            await doc.reference.collection('products').get();

        List<Product> products = [];

        for (var productDoc in productsSnapshot.docs) {
          products
              .add(Product.fromJson(productDoc.data() as Map<String, dynamic>));
        }

        pendingOrdersProducts.add(products);
      }

      fetchingPendingOrders = false;
      update();
    } on FirebaseException catch (e) {
      fetchingPendingOrders = false;
      update();
      print(e.code);
    }
  }

  List<MyOrder> finishedOrders = [];
  List<List<Product>> finishedOrdersProducts = [];
  bool fetchingFinishedOrders = false;

  Future fetchFinishedOrders() async {
    try {
      fetchingFinishedOrders = true;
      update();
      final instance = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot =
          await instance.collection('finishedOrders').get();
      for (var doc in querySnapshot.docs) {
        finishedOrders.add(
          MyOrder.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        );
        QuerySnapshot productsSnapshot =
            await doc.reference.collection('products').get();

        List<Product> products = [];

        for (var productDoc in productsSnapshot.docs) {
          products
              .add(Product.fromJson(productDoc.data() as Map<String, dynamic>));
        }

        finishedOrdersProducts.add(products);
      }
      fetchingFinishedOrders = false;
      update();
    } on FirebaseException catch (e) {
      fetchingFinishedOrders = false;
      update();
      print(e.code);
    }
  }

  bool editingOrders = false;
  void editOrders() {
    editingOrders = true;
    update();
  }

  List<String> ordersToBeDeleted = [];
  void selectOrder(String id) {
    if (ordersToBeDeleted.contains(id)) {
      ordersToBeDeleted.remove(id);
    } else {
      ordersToBeDeleted.add(id);
    }
    update();
  }

  void cancelOrdersEdit() {
    editingOrders = false;
    ordersToBeDeleted.clear();
    update();
  }

  Future deleteOrder() async {
    try {
      for (String id in ordersToBeDeleted) {
        pendingOrdersProducts
            .removeAt(pendingOrders.indexWhere((order) => order.orderId == id));
        pendingOrders.removeWhere((order) => order.orderId == id);
        await FirebaseFirestore.instance.collection('orders').doc(id).delete();
        await FirebaseFirestore.instance
            .collection('processingOrders')
            .doc(id)
            .delete();
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('orders')
            .doc(id)
            .collection('products')
            .get();
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('processingOrders')
            .doc(id)
            .collection('products')
            .get();
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      }
      cancelOrdersEdit();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }
}

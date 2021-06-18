import 'dart:async';
import 'dart:convert';

import 'package:airtel_wynk_template/drawer_screens/bottom_navigation_drawer.dart';
import 'package:airtel_wynk_template/utils/snackbar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = new TextEditingController();
  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  var _commonIconSize = 24.0;
  int selectedIndex = 0;
  final String url = 'https://jsonplaceholder.typicode.com/users';

  Future<Null> getUserDetails() async {
    final response = await http.get(Uri.parse(url));
    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      for (var user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getUserDetails();
  }

  Widget appBarTitle = new Text("AppBar Title");
  Icon actionIcon = new Icon(Icons.search);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        // This!
        bottomNavigationBar: _bottomNavigation(),
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                          // Scaffold.of(context).openEndDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Color(0xFFBD520A),
                          size: _commonIconSize,
                        ),
                      ),
                      Container(
                        width: 160,
                        child: TextField(
                          controller: searchTextController,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Color(0xFFA7A4A2)),
                              hintText: 'Search by name...',
                              border: InputBorder.none),
                          onChanged: onSearchTextChanged,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 0,
                        ),
                      ),
                      searchTextController.text.isEmpty ||
                              searchTextController.text.length <= 0
                          ? IconButton(
                              icon: Icon(
                                Icons.keyboard_voice,
                                size: _commonIconSize,
                                color: Color(0xFFBD520A),
                              ),
                              onPressed: () {},
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.cancel_outlined,
                                size: _commonIconSize,
                                color: Color(0xFF9E9A9A),
                              ),
                              onPressed: () {
                                searchTextController.clear();
                                onSearchTextChanged('');
                              },
                            ),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Color(0xFFBD520A),
                          size: _commonIconSize,
                        ),
                        onPressed: () {
                          openCheckout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResult.length != 0 ||
                      searchTextController.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return new Card(
                          child: new ListTile(
                            leading: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                  "https://i.redd.it/v0caqchbtn741.jpg"
                                  // _searchResult[i].profileUrl,
                                  ),
                            ),
                            title: new Text(_searchResult[i].firstName +
                                ' ' +
                                _searchResult[i].lastName),
                          ),
                          margin: const EdgeInsets.all(0.0),
                        );
                      },
                    )
                  : new ListView.builder(
                      itemCount: _userDetails.length,
                      itemBuilder: (context, index) {
                        return new Card(
                          child: new ListTile(
                            leading: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                  "https://i.redd.it/v0caqchbtn741.jpg"
                                  // _userDetails[index].profileUrl,
                                  ),
                            ),
                            title: new Text(_userDetails[index].firstName),
                            subtitle: Text(_userDetails[index].lastName),
                          ),
                          margin: const EdgeInsets.all(0.0),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.toLowerCase().toString().trim().contains(text) ||
          userDetail.lastName.toLowerCase().toString().trim().contains(text))
        _searchResult.add(userDetail);
    });
    setState(() {});
  }

  //////////////////
  late Razorpay _razorpay;

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    debugPrint("openCheckout");
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': 100,
      'name': 'Shyam',
      'description': 'Payment',
      'prefill': {'contact': '9874563210', 'email': 'shyam@razorpay.com'},
      /* 'external': {
        'wallets': ['paytm']
      }*/
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Canceled" + e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("SUCCESS: " +
        "payment id" +
        response.paymentId.toString() +
        " signature " +
        response.signature.toString() +
        " order id " +
        response.orderId.toString());
    showSnackBar(context, "SUCCESS: " + response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("ERROR: " +
        response.code.toString() +
        " " +
        response.message.toString());
    showSnackBar(
        context,
        "ERROR: " +
            response.code.toString() +
            " " +
            response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("WALLET:" + response.walletName.toString());
    showSnackBar(context, "WALLET:" + response.walletName.toString());
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFBD520A),
      unselectedItemColor: Color(0xFF5F5C5C),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (value) {},
      items: [
        BottomNavigationBarItem(
          title: Text('Home'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('Music List'),
          icon: Icon(Icons.music_note_outlined),
        ),
        BottomNavigationBarItem(
          title: Text('Podcasts'),
          icon: Icon(Icons.podcasts),
        ),
        BottomNavigationBarItem(
          title: Text('Settings'),
          icon: Icon(Icons.settings_outlined),
        ),
      ],
      currentIndex: selectedIndex,
      elevation: 4,
    );
  }
}

class UserDetails {
  final int id;
  final String firstName, lastName, profileUrl;

  UserDetails(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.profileUrl = "https://i.redd.it/v0caqchbtn741.jpg"});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:gari_chai_app/brand_colors.dart';
import 'package:gari_chai_app/tabs/earningstab.dart';
import 'package:gari_chai_app/tabs/hometab.dart';
import 'package:gari_chai_app/tabs/profiletab.dart';
import 'package:gari_chai_app/tabs/ratingstab.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  TabController tabController;
  int selectedIndex = 0;

  void onItemClciked(int index){
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4,vsync: this);
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTab(),
          EarningsTab(),
          RatingsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            title: Text('Earnings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Ratings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        unselectedItemColor: BrandColors.colorIcon,
        selectedItemColor: BrandColors.colorOrange,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onItemClciked,
        currentIndex: selectedIndex,
      ),
    );
  }
}

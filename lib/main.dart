import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontFamily: 'Roboto', fontSize: 57.0, fontWeight: FontWeight.bold),
              displayMedium: TextStyle(fontFamily: 'Roboto', fontSize: 45.0, fontWeight: FontWeight.bold),
              displaySmall: TextStyle(fontFamily: 'Roboto', fontSize: 36.0, fontWeight: FontWeight.bold),
              headlineLarge: TextStyle(fontFamily: 'Roboto', fontSize: 32.0, fontWeight: FontWeight.bold),
              headlineMedium: TextStyle(fontFamily: 'Roboto', fontSize: 28.0, fontWeight: FontWeight.w600),
              headlineSmall: TextStyle(fontFamily: 'Roboto', fontSize: 24.0, fontWeight: FontWeight.w600),
              titleLarge: TextStyle(fontFamily: 'Roboto', fontSize: 22.0, fontWeight: FontWeight.bold),
              titleMedium: TextStyle(fontFamily: 'Roboto', fontSize: 20.0, fontWeight: FontWeight.bold),
              titleSmall: TextStyle(fontFamily: 'Roboto', fontSize: 18.0, fontWeight: FontWeight.w600),
              bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, fontWeight: FontWeight.normal),
              bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 14.0, fontWeight: FontWeight.normal),
              bodySmall: TextStyle(fontFamily: 'Roboto', fontSize: 12.0, fontWeight: FontWeight.normal),
              labelLarge: TextStyle(fontFamily: 'Roboto', fontSize: 14.0, fontWeight: FontWeight.bold),
              labelMedium: TextStyle(fontFamily: 'Roboto', fontSize: 12.0, fontWeight: FontWeight.bold),
              labelSmall: TextStyle(fontFamily: 'Roboto', fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
          ),
          home: PortfolioPage(),
        );
      },
    );
  }
}

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int _selectedIndex = 1;
  int _tabSelectedIndex = 1;
  String filterText = '';

  bool isPortfolioTab() {
    return _tabSelectedIndex == 1;
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _tabSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle;
    if (_selectedIndex == 0) {
      appBarTitle = "Home";
    } else if (_selectedIndex == 1) {
      appBarTitle = "Portfolio";
    } else if (_selectedIndex == 2) {
      appBarTitle = "Input";
    } else {
      appBarTitle = "Profile";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/shopping-bag.svg'),
            color: Colors.orange,
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/notifications.svg'),
            color: Colors.orange,
            onPressed: () {},
          ),
        ],
      ),
      body: _selectedIndex == 1 ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab("Project", isSelected: _tabSelectedIndex == 1),
                _buildTab("Saved", isSelected: _tabSelectedIndex == 2),
                _buildTab("Shared", isSelected: _tabSelectedIndex == 3),
                _buildTab("Achievement", isSelected: _tabSelectedIndex == 4),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Search a project',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffDF5532),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                ),
                onChanged: (text) {
                  setState(() {
                    filterText = text;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _tabSelectedIndex == 1
                ? ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                if (projects[index].title.toLowerCase().contains(filterText.toLowerCase())) {
                  return ProjectCard(project: projects[index]);
                }
                return Container();
              },
            )
                : _buildEmptyContainer(),
          ),
        ],
      ) : Center(child: _buildEmptyContainer()),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70.h),
        child: SizedBox(
          height: 40.h,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Color(0xffDF5532),
            label: Row(
              children: [
                Icon(Icons.filter_list, color: Colors.white),
                SizedBox(width: 4.w),
                Text('Filter', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg', color: _selectedIndex == 0 ? Colors.orange : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/portfolio.svg', color: _selectedIndex == 1 ? Colors.orange : Colors.grey),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/input.svg', color: _selectedIndex == 2 ? Colors.orange : Colors.grey),
            label: 'Input',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/profile.svg', color: _selectedIndex == 3 ? Colors.orange : Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyContainer() {
    return Center(
      child: Container(
        height: 100.h,
        width: double.infinity,
        color: Colors.grey[200],
        child: Center(
          child: Text(
            'No content available',
            style: TextStyle(color: Colors.grey, fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        if (label == "Project") {
          _onTabChanged(1);
        } else if (label == "Saved") {
          _onTabChanged(2);
        } else if (label == "Shared") {
          _onTabChanged(3);
        } else if (label == "Achievement") {
          _onTabChanged(4);
        }
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: isSelected ? Colors.orange : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            height: 2.h,
            width: 97,
            color: isSelected ? Colors.orange : Colors.grey[300],
          ),
        ],
      ),
    );
  }
}

final List<Project> projects = [
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),
  Project(title: "Kemampuan Merangkum Tulisan", subtitle: "BAHASA SUNDA", author: "Oleh Al-Baiqi Samaan"),

];

class Project {
  final String title;
  final String subtitle;
  final String author;
  Project({required this.title, required this.subtitle, required this.author});
}

class ProjectCard extends StatelessWidget {
  final Project project;
  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/sample_image.png',
            width: 110.w,
            height: 110.h,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 14.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title.split(' ').take(2).join(' '),
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      project.title.split(' ').skip(2).join(' '),
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.subtitle,
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                          ),
                          Text(
                            project.author,
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(14),
                      height: 26.h,
                      width: 50.w,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF39519),
                            Color(0xFFFFCD67),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'A',
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


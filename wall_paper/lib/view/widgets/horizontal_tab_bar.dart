import 'package:flutter/material.dart';

class HorizontalTabBar extends StatelessWidget {
  const HorizontalTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
      child: TabBar(
        labelStyle: TextStyle(fontSize: 20),
        labelColor: Colors.yellow,
        unselectedLabelColor: Colors.grey,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        tabs: [
          _buildTab("911",
              "https://images.pexels.com/photos/164634/pexels-photo-164634.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
          // Add more tabs as needed
        ],
        isScrollable: true,
        onTap: (index) {
          print("hahah");
        },
      ),
    );
  }

  Widget _buildTab(String label, String imageUrl) {
    return Tab(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 50,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black45,
            ),
            height: 50,
            width: 100,
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 0,
            child: FractionallySizedBox(
              widthFactor: 0.4,
              heightFactor: 0.4,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

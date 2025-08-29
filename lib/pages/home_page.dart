import 'package:animate_do/animate_do.dart';
import 'package:yhome/models/service.dart';
import 'package:yhome/pages/select_service.dart';
import 'package:yhome/pages/worker_profile.dart';
import 'package:flutter/material.dart';
import 'package:yhome/pages/inbox_page.dart';

class Worker {
  final String name;
  final String job;
  final String image;
  final double rating;
  final String phone;
  final String description;

  Worker({
    required this.name,
    required this.job,
    required this.image,
    required this.rating,
    required this.phone,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'job': job,
      'image': image,
      'rating': rating,
      'phone': phone,
      'description': description,
    };
  }
}

class HomePage extends StatefulWidget {
  final List<Worker>? recentBookings;

  const HomePage({Key? key, this.recentBookings}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Service> services = [
    Service('Cleaning', 'assets/images/cleaning.png'),
    Service('Plumber', 'assets/images/plumbing.png'),
    Service('Electrician', 'assets/images/electrician.png'),
    Service('Painter', 'assets/images/painter.png'),
    Service('Carpenter', 'assets/images/carpenter.png'),
    Service('Gardener', 'assets/images/gardner.png'),
  ];

  List<List<dynamic>> workers = [
    [
      'Charan',
      'Cook',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAsns-PLY2-yKJ1ZIrCZKiGPkhEqKW_OLvaA&s',
      4.8,
      '9876543210',
      'Experienced chef'
    ],
    [
      'Adolf Hitraja',
      'Gardner',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoP-2hLt3mG9PnXEwleG6grE_-b-NqdK_QDw&s',
      4.8,
      '9876543210',
      'Greatest gardner'
    ],
  ];

  late List<Map<String, dynamic>> _recentProfiles;

  final List<Map<String, dynamic>> _dummyProfiles = [
    {
      'name': 'Shah Rukh Khan',
      'job': 'Plumber',
      'image': 'https://i.dawn.com/primary/2025/08/021151140f53210.jpg',
      'rating': 4.8,
      'phone': '9876543210',
      'description': 'Experienced plumber',
    },
    {
      'name': 'Usain Bolt',
      'job': 'Electrician',
      'image':
          'https://i.guim.co.uk/img/media/8eddd39e77327c9e25668b565d3b0824fa88f774/0_0_6200_8272/master/6200.jpg?width=465&dpr=1&s=none&crop=none',
      'rating': 4.7,
      'phone': '9871112233',
      'description': 'Minor experiance',
    },
    {
      'name': 'Akshay Kumar',
      'job': 'Cleaner',
      'image':
          'https://img-cdn.publive.online/fit-in/640x430/filters:format(webp)/afaqs/media/post_attachments/6675453f6cb6d666c2846a8977be4c3601ed22da073ed5b1ae2d3e88348bdee3.jpg',
      'description': 'Experienced cleaner',
      'rating': 4.9,
      'phone': '9871112233'
    },
    {
      'name': 'Salman Khan',
      'job': 'Driver',
      'image': 'https://pbs.twimg.com/media/FrwEbB5XsAAnu8Z.jpg',
      'description': 'Sensational driver',
      'rating': 4.8,
      'phone': '9872223344'
    },
    {
      'name': 'Ajay Devgn',
      'job': 'Painter',
      'image':
          'https://im.indiatimes.in/content/2022/Apr/Untitled-design---2022-04-20T110706197_625f9c0b0b73b.png?w=400&h=210&cc=1&webp=1&q=75',
      'description': 'Expert in painting',
      'rating': 4.7,
      'phone': '9873334455'
    },
  ];

  @override
  void initState() {
    super.initState();

    if (widget.recentBookings != null && widget.recentBookings!.isNotEmpty) {
      _recentProfiles = widget.recentBookings!
          .map((w) => w.toMap())
          .toList()
          .followedBy(_dummyProfiles)
          .toList();
    } else {
      _recentProfiles = _dummyProfiles;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Dashboard', style: TextStyle(color: Colors.black)),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InboxPage()),
              );
            },
            icon: Icon(Icons.notifications_none,
                color: Colors.grey.shade700, size: 30),
          )
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(backgroundColor: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            _buildRecentSection(),
            _buildCategoriesSection(),
            _buildSelectCategoryButton(context),
            _buildTopRatedAndNearbySection(),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSection() {
    return FadeInUp(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: Text('View all'))
              ],
            ),
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.92),
                itemCount: _recentProfiles.length,
                itemBuilder: (context, i) {
                  final p = _recentProfiles[i];
                  return _recentProfileCard(p);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentProfileCard(Map<String, dynamic> p) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            offset: Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  p['image'],
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(p['job'],
                      style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.7),
                          fontSize: 18)),
                ],
              )
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkerProfilePage(
                      name: p['name'],
                      jobDescription: p['description'],
                      imageUrl: p['image'],
                      rating: p['rating'],
                      phone: p['phone'],
                    ),
                  ),
                );
              },
              child: const Text('View Profile',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return FadeInUp(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: Text('View all'))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GridView.builder(
                shrinkWrap: true,
                // fixed overflow
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 500 * index),
                    child: serviceContainer(
                        services[index].imageURL, services[index].name, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectCategoryButton(BuildContext context) {
    return FadeInUp(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectService()),
              );
            },
            icon: Icon(Icons.filter_list, color: Colors.white),
            label: Text('Select Category'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15.0),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopRatedAndNearbySection() {
    return FadeInUp(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
        child: SizedBox(
          height: 250, // fixed height to prevent overflow
          child: PageView(
            controller: PageController(viewportFraction: 0.9),
            children: [
              _workerListPage("Top Rated"),
              _workerListPage("Nearby Workers"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _workerListPage(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: workers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () {
                    final w = workers[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerProfilePage(
                          name: w[0],
                          jobDescription: w[5],
                          imageUrl: w[2],
                          rating: w[3],
                          phone: w[4],
                        ),
                      ),
                    );
                  },
                  child: workerContainer(
                    workers[index][0],
                    workers[index][1],
                    workers[index][2],
                    workers[index][3],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget serviceContainer(String image, String name, int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(image, height: 45),
              SizedBox(height: 15),
              Text(name, style: TextStyle(fontSize: 15))
            ]),
      ),
    );
  }

  Widget workerContainer(String name, String job, String image, double rating) {
    return Container(
      margin: EdgeInsets.only(right: 15, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(job,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              SizedBox(width: 5),
              Text(rating.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

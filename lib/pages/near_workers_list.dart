import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:yhome/pages/date_time.dart';
import 'package:yhome/pages/worker_profile.dart';

class NearbyWorkersPage extends StatefulWidget {
  const NearbyWorkersPage({super.key});

  @override
  State<NearbyWorkersPage> createState() => _NearbyWorkersPageState();
}

class _NearbyWorkersPageState extends State<NearbyWorkersPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> nearbyWorkers = [
    {
      'name': 'Shah Rukh Khan',
      'job': 'Plumber',
      'image': 'https://i.dawn.com/primary/2025/08/021151140f53210.jpg',
      'rating': 4.8,
      'phone': '9876543210',
      'description': 'Experienced plumber',
    },
    {
      'name': 'Thor',
      'job': 'Electrician',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTkV5Q5gJPwjzTlROVHS8MXHZ79cWCl4FG7A&s',
      'rating': 4.7,
      'phone': '9871112233',
      'description': 'Expert in fixing',
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
      'description': 'Generational driver',
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

  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _slideAnimations = List.generate(
      nearbyWorkers.length,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      ),
    );

    _fadeAnimations = List.generate(
      nearbyWorkers.length,
      (index) => Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeIn),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildWorkerCard(BuildContext context, Map<String, dynamic> worker) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerProfilePage(
                  name: worker['name'],
                  jobDescription: worker['description'],
                  imageUrl: worker['image'],
                  rating: worker['rating'],
                  phone: worker['phone'],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    worker['image'],
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        worker['job'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            worker['rating'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(100, 36),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkerProfilePage(
                              name: worker['name'],
                              jobDescription: worker['description'],
                              imageUrl: worker['image'],
                              rating: worker['rating'],
                              phone: worker['phone'],
                            ),
                          ),
                        );
                      },
                      child: const Text('Profile',
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(100, 36),
                      ),
                      onPressed: () => _showBookingDialog(context, worker),
                      child: const Text('Book Now',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showBookingDialog(
      BuildContext context, Map<String, dynamic> worker) async {
    final booked = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Confirm Booking',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Do you want to book ${worker['name']} for the service?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (booked == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service booked successfully!')),
      );

      await Future.delayed(const Duration(seconds: 1));

      Worker bookedWorker = Worker(
        name: worker['name'],
        job: worker['job'],
        image: worker['image'],
        rating: worker['rating'],
        phone: worker['phone'],
        description: worker['description'],
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(recentBookings: [bookedWorker]),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DateAndTime()),
            );
          },
        ),
        title:
            const Text('Nearby Workers', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: nearbyWorkers.length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: _slideAnimations[index],
            child: FadeTransition(
              opacity: _fadeAnimations[index],
              child: _buildWorkerCard(context, nearbyWorkers[index]),
            ),
          );
        },
      ),
    );
  }
}

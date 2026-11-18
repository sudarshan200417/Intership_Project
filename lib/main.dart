import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride Tracking',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const RideTrackingScreen(),
    );
  }
}

class RideTrackingScreen extends StatefulWidget {
  const RideTrackingScreen({super.key});

  @override
  State<RideTrackingScreen> createState() =>
      _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {

  // Mock captain details
  String captainName = "Rahul Sharma";
  String vehicleNumber = "GJ 06 AB 1234";
  double rating = 4.8;

  // Ride information
  double fare = 250.0;
  String pickup = "Parul University, Vadodara";
  String destination = "Railway Station, Vadodara";

  // Ride statuses
  final List<String> statuses = [
    "Ride Confirmed",
    "Captain Assigned",
    "Captain Arriving",
    "Ride Started",
    "Ride Completed"
  ];

  int currentStatus = 0;
  bool isCancelled = false;

  // Move to next ride status
  void nextStatus() {
    if (currentStatus < statuses.length - 1) {
      setState(() {
        currentStatus++;
      });
    }
  }

  // Cancel ride with confirmation
  void cancelRide() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cancel Ride?"),
          content: const Text(
              "Are you sure you want to cancel this ride?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCancelled = true;
                });

                Navigator.pop(context);
              },
              child: const Text("Yes, Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ride Tracking"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Captain Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 35),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            captainName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(vehicleNumber),

                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                              Text(" $rating"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Ride Progress
            const Text(
              "Ride Progress",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: List.generate(
                    statuses.length,
                        (index) {

                      bool completed =
                          index <= currentStatus;

                      return ListTile(
                        leading: Icon(
                          completed
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: completed
                              ? Colors.green
                              : Colors.grey,
                        ),

                        title: Text(
                          statuses[index],
                          style: TextStyle(
                            fontWeight: completed
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Current Status
            Center(
              child: Text(
                isCancelled
                    ? "Ride Cancelled"
                    : statuses[currentStatus],

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pickup and Destination
            const Text(
              "Ride Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📍 Pickup: $pickup"),

                    const SizedBox(height: 15),

                    Text("🏁 Destination: $destination"),

                    const Divider(height: 25),

                    Text(
                      "Estimated Fare: ₹$fare",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Next Status Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCancelled ||
                    currentStatus == statuses.length - 1
                    ? null
                    : nextStatus,

                child: const Text("Simulate Next Status"),
              ),
            ),

            const SizedBox(height: 10),

            // Cancel Ride Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isCancelled ||
                    currentStatus == statuses.length - 1
                    ? null
                    : cancelRide,

                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),

                child: const Text("Cancel Ride"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
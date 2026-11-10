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
      title: 'My Profile',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFFFF3E0),
      ),
      home: const MyProfileScreen(),
    );
  }
}

// PROFILE SCREEN
class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.orange,
              child: Text(
                'MK',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Maria Kartika',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Grade 10 Student'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHobbyScreen(),
                  ),
                );
              },
              child: const Text('View My Hobbies'),
            ),
          ],
        ),
      ),
    );
  }
}

// HOBBIES SCREEN WITH CRUD
class MyHobbyScreen extends StatefulWidget {
  const MyHobbyScreen({super.key});

  @override
  State<MyHobbyScreen> createState() => _MyHobbyScreenState();
}

class _MyHobbyScreenState extends State<MyHobbyScreen> {
  final List<String> hobbies = [
    'Writing',
    'Listening to Music',
    'Arts and Crafts',
  ];

  // CREATE AND UPDATE
  void showHobbyDialog({int? index}) {
    final controller = TextEditingController(
      text: index != null ? hobbies[index] : '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Hobby' : 'Edit Hobby'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter hobby name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    if (index == null) {
                      // CREATE
                      hobbies.add(controller.text.trim());
                    } else {
                      // UPDATE
                      hobbies[index] = controller.text.trim();
                    }
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // DELETE
  void deleteHobby(int index) {
    setState(() {
      hobbies.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Hobbies'),
        backgroundColor: Colors.deepOrange,
      ),

      // READ
      body: hobbies.isEmpty
          ? const Center(child: Text('No hobbies yet. Add one!'))
          : ListView.builder(
              itemCount: hobbies.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.favorite,
                      color: Colors.deepOrange,
                    ),
                    title: Text(hobbies[index]),
                    trailing: Wrap(
                      spacing: 5,
                      children: [
                        // EDIT BUTTON
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            showHobbyDialog(index: index);
                          },
                        ),

                        // DELETE BUTTON
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteHobby(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          showHobbyDialog();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

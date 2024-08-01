import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toros_dart/providers/bull_provider.dart';
import 'package:toros_dart/models/bull.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BullProvider(),
      child: MaterialApp(
        title: 'Bull App',
        home: BullHomePage(),
      ),
    );
  }
}

class BullHomePage extends StatefulWidget {
  @override
  _BullHomePageState createState() => _BullHomePageState();
}

class _BullHomePageState extends State<BullHomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    BullListPage(),
    BullSearchPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bull App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BullListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bullProvider = Provider.of<BullProvider>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await bullProvider.loadBulls('assets/bulls.xlsx');
          },
          child: Text('Load Bulls'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: bullProvider.bulls.length,
            itemBuilder: (context, index) {
              final bull = bullProvider.bulls[index];
              return ListTile(
                title: Text('ID: ${bull.id}'),
                subtitle: Text('Num: ${bull.num}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BullSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bullProvider = Provider.of<BullProvider>(context);
    final TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter Bull ID',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final id = _controller.text;
            final bull = bullProvider.getBullById(id);

            if (bull.id.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Bull Details'),
                    content: Text('ID: ${bull.id}\nNum: ${bull.num}'),
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Bull not found'),
                  );
                },
              );
            }
          },
          child: Text('Search'),
        ),
      ],
    );
  }
}

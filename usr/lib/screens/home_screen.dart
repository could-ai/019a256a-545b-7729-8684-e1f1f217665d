import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for ebooks
  final List<Book> _books = [
    Book(
      title: 'The Silent Patient',
      author: 'Alex Michaelides',
      coverUrl: 'https://m.media-amazon.com/images/I/41j2-agI+hL._SY445_SX342_.jpg',
      price: 14.99,
      description:
          'A gripping psychological thriller of a woman\'s act of violence against her husband—and of the therapist obsessed with uncovering her motive.',
    ),
    Book(
      title: 'Atomic Habits',
      author: 'James Clear',
      coverUrl: 'https://m.media-amazon.com/images/I/51-nXsSR0pL._SY445_SX342_.jpg',
      price: 11.99,
      description:
          'An easy & proven way to build good habits & break bad ones. Tiny changes, remarkable results.',
    ),
    Book(
      title: 'The Midnight Library',
      author: 'Matt Haig',
      coverUrl: 'https://m.media-amazon.com/images/I/511Hcc23NfL._SY445_SX342_.jpg',
      price: 12.50,
      description:
          'Between life and death there is a library, and within that library, the shelves go on forever. Every book provides a chance to try another life you could have lived.',
    ),
    Book(
      title: 'Dune',
      author: 'Frank Herbert',
      coverUrl: 'https://m.media-amazon.com/images/I/41y8N2P3n1L._SY445_SX342_.jpg',
      price: 10.99,
      description:
          'Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world where the only thing of value is the “spice” melange, a drug capable of extending life and enhancing consciousness.',
    ),
    Book(
      title: 'Project Hail Mary',
      author: 'Andy Weir',
      coverUrl: 'https://m.media-amazon.com/images/I/51m-4+33ylL._SY445_SX342_.jpg',
      price: 15.99,
      description:
          'Ryland Grace is the sole survivor on a desperate, last-chance mission—and if he fails, humanity and the earth itself will perish.',
    ),
    Book(
      title: 'The Four Winds',
      author: 'Kristin Hannah',
      coverUrl: 'https://m.media-amazon.com/images/I/51r-293M5zL._SY445_SX342_.jpg',
      price: 9.99,
      description:
          'An epic novel of love and heroism and hope, set against the backdrop of one of America’s most defining eras—the Great Depression.',
    ),
  ];

  List<Book> _filteredBooks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredBooks = _books;
  }

  void _filterBooks(String query) {
    final filtered = _books.where((book) {
      final titleLower = book.title.toLowerCase();
      final authorLower = book.author.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredBooks = filtered;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ebook Store'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterBooks,
                decoration: InputDecoration(
                  hintText: 'Search by title or author...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: _filteredBooks.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _filteredBooks.length,
                      itemBuilder: (context, index) {
                        return BookCard(book: _filteredBooks[index]);
                      },
                    )
                  : const Center(
                      child: Text('No books found.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

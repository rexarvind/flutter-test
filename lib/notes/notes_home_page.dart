import 'dart:convert';

import 'package:demo_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../pages/auth_page.dart';
import './notes_single_page.dart';
import './notes_model.dart';
import './notes_list_item.dart';
import '../pages/settings_page.dart';
import '../constants.dart';

class NotesHomePage extends ConsumerStatefulWidget {
  const NotesHomePage({super.key});
  static const routeName = '/notes';

  // List<Note> notes = [
  //   Note(title: 'ab', content: 'asf', isTagged: true, isFavorite: false, isDeleted: false),

  // ];

  @override
  ConsumerState<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends ConsumerState<NotesHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? pushNotificationToken;

  List<Note> _notes = [
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
    Note(
        title: 'asdf',
        content: 'alsj',
        isTagged: false,
        isFavorite: false,
        isDeleted: true),
  ];
  // var _isLoading = false;
  // String? _error;

  void _loadItems() async {
    final url = Uri.https('rexarvind.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        // setState(() {
          // _error = 'Failed to fetch data.';
        // });
      }
      if (response.body == 'null') {
        setState(() {
          // _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<Note> loadedItems = [];
      // for (final item in listData.entries) {
      //   final category = categories.entries
      //       .firstWhere(
      //           (catItem) => catItem.value.title == item.value['category'])
      //       .value;
      //   loadedItems.add(
      //     GroceryItem(
      //       id: item.key,
      //       name: item.value['name'],
      //       quantity: item.value['quantity'],
      //       category: category,
      //     ),
      //   );
      // }
      setState(() {
        _notes = loadedItems;
        // _isLoading = false;
      });
    } catch (e) {
      // setState(() {
        // _error = 'Something went wrong, try again later.';
      // });
    }
  }

  Future<void> _pullRefresh() async {
    return Future<void>.delayed(const Duration(seconds: 5));
  }

  final SliverOverlapAbsorberHandle appBar = SliverOverlapAbsorberHandle();
  final SliverOverlapAbsorberHandle disconnectBar =
      SliverOverlapAbsorberHandle();

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    setState(() {
      pushNotificationToken = token;
    });
    final res = await http.post(
      Uri.https(kApiBase, '/notifications/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'token': token,
          'deviceId': 'web',
        },
      ),
    );
    print(res);
  }

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
    super.initState();
    setupPushNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  sliver: SliverAppBar(
                    title: const Text('Duly Noted $kVersion'),
                    pinned: true,
                    floating: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.restorablePushNamed(
                            context, AuthPage.routeName);
                          // logout().then((_) {
                            // Navigator.of(context).pushAndRemoveUntil(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         const AuthPage(),
                            //   ),
                            //   (route) => false,
                            // );
      
                          // });
                        },
                        icon: const Icon(Icons.logout),
                      ),
                      IconButton(
                        tooltip: 'Settings',
                        onPressed: () {
                          Navigator.restorablePushNamed(
                              context, SettingsPage.routeName);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                      MenuAnchor(
                        builder: (BuildContext context, MenuController controller,
                            Widget? child) {
                          return IconButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                            tooltip: 'Menu',
                          );
                        },
                        menuChildren: List<MenuItemButton>.generate(
                          3,
                          (int index) => MenuItemButton(
                            onPressed: () {
                              // setState(() => selectedMenu = SampleItem.values[index]),
                            },
                            child: const Text('Item 1'),
                          ),
                        ),
                      ),
                    ],
                    bottom: TabBar(
                      isScrollable: false,
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Notes'),
                        Tab(text: 'Favorites'),
                        Tab(text: 'Deleted'),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              RefreshIndicator(
                onRefresh: _pullRefresh,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _notes.length,
                    itemBuilder: (ctx, index) {
                      return const NotesListItem();
                    }),
              ),
              Text('Token $pushNotificationToken'),
              const Text('notes'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Create New Note',
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const NotesEditPage()),
            );
          },
        ),
      ),
    );
  }
}

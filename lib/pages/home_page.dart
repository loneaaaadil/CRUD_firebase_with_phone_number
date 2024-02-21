import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/controllers/database_service.dart';
import 'package:crud_firebase/model/item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff6750a4).withOpacity(0.30),
        title: const Center(child: Text("ITEMS")),
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffffd8e4),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            addItemToList(context);
          }),
    );
  }

  Future<void> addItemToList(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          // height: 440,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Item',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/pick.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const Gap(18),
                    TextFormField(
                      autofocus: true,
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Gap(18),
                    GestureDetector(
                      onTap: () {
                        Item item = Item(
                          title: titleController.text,
                          description: descriptionController.text,
                          image: "",
                          createdAt: Timestamp.now(),
                        );

                        _databaseService.addItems(item);
                        Get.back();
                        titleController.clear();
                        descriptionController.clear();
                      },
                      child: Container(
                        height: 40,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0XFF6750A4),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _listViewItems(),
      ],
    ));
  }

  Widget _listViewItems() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getItems(),
        builder: (context, snapshot) {
          List items = snapshot.data?.docs ?? [];
          if (items.isEmpty) {
            return const Center(
              child: Text('Add Item'),
            );
          }
          print(items);
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              Item item = items[index].data();
              String itemId = items[index].id;
              print("kasudfhasiudhfasidfh ${item.title}");

              return Dismissible(
                // crossAxisEndOffset: 0.3,
                // secondaryBackground: const Icon(Icons.abc),
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  height: 80,
                  width: 102,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                // secondaryBackground: const Icon(Icons.delete),
                key: Key(itemId),
                onDismissed: (direction) => _databaseService.deleteItem(itemId),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff000000).withOpacity(0.15)),
                    child: ListTile(
                      // selectedColor: const Color(0xffFFFBFE).withOpacity(0.15),
                      leading: Image.asset(
                        "assets/images/img.png",
                      ),
                      title: Text(
                        item.title!.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      subtitle: Text(
                        item.description!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      trailing: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff6750a4).withOpacity(
                              0.30,
                            ),
                          ),
                          child: IconButton(
                              onPressed: () {
                                titleController.text = item.title!;
                                descriptionController.text = item.description!;
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      // height: 440,
                                      width: double.maxFinite,
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Edit Item',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 24),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print('pick');
                                                  },
                                                  child: Image.asset(
                                                    'assets/images/edit.png',
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                ),
                                                const Gap(18),
                                                TextFormField(
                                                  autofocus: true,
                                                  controller: titleController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "title",
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const Gap(16),
                                                TextFormField(
                                                  controller:
                                                      descriptionController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Description",
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const Gap(18),
                                                GestureDetector(
                                                  onTap: () {
                                                    Item updateItem = Item(
                                                      title:
                                                          titleController.text,
                                                      description:
                                                          descriptionController
                                                              .text,
                                                      image: "",
                                                      createdAt:
                                                          Timestamp.now(),
                                                    );
                                                    _databaseService
                                                        .updateItems(
                                                            itemId, updateItem);
                                                    Get.back();
                                                    titleController.clear();
                                                    descriptionController
                                                        .clear();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: double.maxFinite,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0XFF6750A4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: const Text(
                                                      'UPDATE',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xff50378B),
                              ))),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:riverpod/riverpod.dart';

class ItemList {
  List<String> items;
  List<String> deletedItems;

  ItemList({required this.items, required this.deletedItems});
}

class ItemNotifier extends StateNotifier<ItemList> {
  ItemNotifier() : super(ItemList(items: [], deletedItems: []));

  void addItem(String item) {
    state.items.add(item);
    state = ItemList(items: state.items, deletedItems: state.deletedItems);
  }

  void deletedItem(String Item) {
    state.items.remove(Item);
    state.deletedItems.add(Item);
    state = ItemList(items: state.items, deletedItems: state.deletedItems);
  }

  void restoredItem(String item) {
    state.items.add(item);
    state.deletedItems.remove(item);
    state = ItemList(items: state.items, deletedItems: state.deletedItems);
  }
}

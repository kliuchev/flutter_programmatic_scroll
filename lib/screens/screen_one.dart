import 'package:flutter/material.dart';
import 'package:flutter_programmatic_scroll/dynamic_content_item.dart';
import 'package:flutter_programmatic_scroll/refresh_button.dart';
import 'package:flutter_programmatic_scroll/scroll_button.dart';

/// The screen one contains a list of items that can be scrolled to programmatically using Scrollable.ensureVisible.
class ScreenOne extends StatefulWidget {
  const ScreenOne(this.items, {super.key});

  final List<String> items;

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  /// The keys of the items in the list.
  /// These keys are used to get the context of the item that is being scrolled to.
  late List<GlobalKey> keys;

  /// The current index of the item that is being scrolled to.
  int currentIndex = 0;

  @override
  void initState() {
    /// Generate a list of keys for each item in the list.
    keys = List.generate(widget.items.length, (index) => GlobalKey());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type one: Scrollable'),
        actions: [
          /// Add a refresh button to scroll to the top of the list.
          RefreshButton(onPressed: scrollToTop),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          /// Return a DynamicContentListItem with the item and key.
          return DynamicContentListItem(widget.items[index], key: keys[index]);
        },
      ),

      /// Add a floating action button to scroll to the next item in the list.
      floatingActionButton: ScrollButton(onPressed: scrollToNext),
    );
  }

  /// Scroll to the top of the list. ( Scroll to the first item )
  void scrollToTop() {
    scrollTo(0);
  }

  /// Scroll to the next item in the list. ( Scroll to item number currentIndex + 1 )
  void scrollToNext() {
    scrollTo(currentIndex + 1);
  }

  /// Scroll to the item at the given index.
  void scrollTo(int index) {
    /// Set the currentIndex to the given index.
    currentIndex = index;

    /// Get the context of the child widget at the given index.
    final childWidgetContext = keys[currentIndex].currentContext;

    /// If the context is not null, scroll to the child widget.
    /// The context can be null if the item is not in the current context ( usually because it is not visible on the screen )
    if (childWidgetContext != null) {
      /// Scroll to the child widget.
      Scrollable.ensureVisible(
        childWidgetContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      /// Show a snackbar if the item is not in the current context.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('Item not in the current context')));
    }
  }
}

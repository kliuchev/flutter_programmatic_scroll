import 'package:flutter/material.dart';
import 'package:flutter_programmatic_scroll/fixed_size_content.dart';
import 'package:flutter_programmatic_scroll/main.dart';
import 'package:flutter_programmatic_scroll/refresh_button.dart';
import 'package:flutter_programmatic_scroll/scroll_button.dart';

/// The screen three contains a list of items that can be scrolled to programmatically using ScrollController.animateTo.
/// This is useful for large lists where the items are of fixed size.
/// This doesn't fit for cases where the items have different sizes.
class ScreenThree extends StatefulWidget {
  const ScreenThree(this.items, {super.key});

  final List<FixedSizeItemData> items;

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  /// The ScrollController is used to scroll ListView to specific offset.
  final _scrollController = ScrollController();

  /// The current index of the item that is being scrolled to.
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen three: ScrollController.scrollTo'),
        actions: [
          /// Add a refresh button to scroll to the top of the list.
          RefreshButton(onPressed: scrollToTop),
        ],
      ),
      body: ListView.builder(
        /// Set the controller to the ScrollController.
        controller: _scrollController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return FixedSizeListItem(
            title: item.title,
            subtitle: item.subtitle,
            icon: item.icon,
          );
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
    if (currentIndex + 1 < widget.items.length) {
      scrollTo(currentIndex + 1);
    } else {
      /// Show a snackbar when the end of the list is reached.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('End of the list')),
        );
    }
  }

  /// Scroll to the item at the given index.
  void scrollTo(int index) {
    currentIndex = index;

    /// Animate the scroll to the given index.
    /// To scroll to the item at the given index, multiply the index by the height of the item.
    /// Current item offset is a sum of all previous items
    _scrollController.animateTo(
      index * FixedSizeListItem.height,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

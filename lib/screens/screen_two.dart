import 'package:flutter/material.dart';
import 'package:flutter_programmatic_scroll/dynamic_content_item.dart';
import 'package:flutter_programmatic_scroll/refresh_button.dart';
import 'package:flutter_programmatic_scroll/scroll_button.dart';

/// The screen two contains a list of items that can be scrolled to programmatically using Scrollable.ensureVisible.
/// The list is wrapped in a SingleChildScrollView to allow for scrolling to items that are not visible on the screen.
class ScreenTwo extends StatefulWidget {
  const ScreenTwo(this.content, {super.key});

  final List<String> content;

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  /// The keys of the items in the list.
  /// These keys are used to get the context of the item that is being scrolled to.
  late List<GlobalKey> keys;

  /// The current index of the item that is being scrolled to.
  var currentIndex = 0;

  @override
  void initState() {
    /// Generate a list of keys for each item in the list.
    keys = List.generate(widget.content.length, (index) => GlobalKey());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen two: SingleChildScrollView + Scrollable'),
        actions: [
          /// Add a refresh button to scroll to the top of the list.
          RefreshButton(onPressed: scrollToTop),
        ],
      ),

      /// Wrap the list in a SingleChildScrollView to allow for scrolling to items that are not visible on the screen.
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,

          /// Create a column of items instead of using a ListView.builder to force keeping all items in BuildContext.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            /// Map the content to a list of DynamicContentListItem widgets.
            children: widget.content.indexed
                .map((element) =>
                    DynamicContentListItem(element.$2, key: keys[element.$1]))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: ScrollButton(onPressed: scrollToNext),
    );
  }

  /// Scroll to the top of the list. ( Scroll to the first item )
  void scrollToTop() {
    scrollTo(0);
  }

  /// Scroll to the next item in the list. ( Scroll to item number currentIndex + 1 )
  void scrollToNext() {
    /// If the current index is the last item in the list, scroll to the top of the list.
    if (currentIndex >= widget.content.length - 1) {
      scrollToTop();
    } else {
      /// Otherwise, scroll to the next item in the list.
      scrollTo(currentIndex + 1);
    }
  }

  void scrollTo(int index) {
    currentIndex = index;

    /// Get the context of the child widget at the given index.
    final childWidgetContext = keys[index].currentContext;

    /// If the context is not null, scroll to the child widget.
    /// In this case the context can't be null because SingleChildScrollView with Column keeps all items in the BuildContext.
    if (childWidgetContext != null) {
      Scrollable.ensureVisible(
        childWidgetContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

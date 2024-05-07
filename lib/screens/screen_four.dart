import 'package:flutter/material.dart';
import 'package:flutter_programmatic_scroll/dynamic_content_item.dart';
import 'package:flutter_programmatic_scroll/refresh_button.dart';
import 'package:flutter_programmatic_scroll/scroll_button.dart';

/// The screen four contains a list of items that can be scrolled to programmatically using ScrollController.animateTo.
/// This is useful for large lists where the items have different sizes.
/// The main idea is to precalculate the offsets of the items in the list and use them to scroll to the desired item.
class ScreenFour extends StatefulWidget {
  const ScreenFour(this.content, {super.key});
  final List<String> content;

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  /// The ScrollController is used to scroll ListView to specific offset.
  final _scrollController = ScrollController();

  /// The precalculated offsets of the items in the list.
  final _precalculatedOffsets = <double>[];

  /// The current index of the item that is being scrolled to.
  var currentIndex = 0;

  /// Precalculate the offsets of the items in the list.
  void _precalculateOffsets(double width) {
    /// Clear the precalculated offsets list.
    _precalculatedOffsets.clear();
    for (var i = 0; i < widget.content.length; i++) {
      /// Get the text of the item.
      final content = widget.content[i];

      /// Calculate the height of the item with the given content;
      final height = DynamicContentListItem.getHeight(content, maxWidth: width);

      /// If it's the first item, add 0 as the offset. It's the first item's offset
      if (i == 0) {
        _precalculatedOffsets.add(0);
      }

      /// Calculate the offset of the next item. ( i + 1 )
      /// If it's the last item, break the loop.
      if (i == widget.content.length - 1) {
        break;
      }

      /// If it's the first item, add the height of the item as the offset.
      /// Otherwise, add the previous offset + the height of the item as the offset.
      final double nextItemOffset =
          i == 0 ? height : _precalculatedOffsets[i] + height;

      /// Add the offset to the precalculated offsets list.
      _precalculatedOffsets.add(nextItemOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen four: Precalculations'),
        actions: [
          /// Add a refresh button to scroll to the top of the list.
          RefreshButton(onPressed: scrollToTop),
        ],
      ),

      /// Wrap the list in a LayoutBuilder to get the width of the screen.
      body: LayoutBuilder(
        builder: (context, constraints) {
          /// Precalculate the offsets of the items in the list.
          _precalculateOffsets(constraints.maxWidth);

          return ListView.builder(
            controller: _scrollController,
            itemCount: widget.content.length,
            itemBuilder: (context, index) {
              return DynamicContentListItem(widget.content[index]);
            },
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
    if (currentIndex + 1 < widget.content.length) {
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
    //// Scroll to the item at the given index if there is a precalculated offset for it.
    if (index < _precalculatedOffsets.length) {
      _scrollController.animateTo(
        _precalculatedOffsets[index], // Scroll to the offset of the item.
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

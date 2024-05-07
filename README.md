# Flutter programmartic scroll
Here are a few examples of how to scroll programmatically in Flutter.
In this projects I have used four different ways to scroll programmatically in Flutter. 
Here are the four ways:
1. Scrollable + ListView - Good for any size list with a fixed and a dynamic height of the list items both. But it works only with widgets in current context ( usually for which ones are visible on the screen ).
2. Scrollable + SingleChildScrollView - Good for small lists where you need to scroll to a non-visible widget. But for large lists, it will be slow.
3. ScrollController - Good for any size list with fixed height list items. It's simple and easy to use, you can't use that for dynamic height items in the list.
4. ScrollController + Precalculated offsets - Good for any size list with fixed and dynamic height list items. It's a bit complex and doesn't worth it for small lists, but for large lists, it's the best way to scroll programmatically.

The full story here: [Flutter programmatic scroll. 4 ways](link)
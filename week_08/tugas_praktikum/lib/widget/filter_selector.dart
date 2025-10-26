import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;
import 'package:tugas_praktikum/widget/carousel_flowdelegate.dart';
import 'package:tugas_praktikum/widget/filter_item.dart';

@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  final List<Color> filters;
  final void Function(Color selectedColor) onFilterChanged;
  final EdgeInsets padding;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;
  late int _page;

  int get filterCount => widget.filters.length;

  Color itemColor(int index) => widget.filters[index % filterCount];

  @override
  void initState() {
    super.initState();
    _page = 0;
    _controller = PageController(
      initialPage: _page,
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    if (page != _page) {
      _page = page;
      widget.onFilterChanged(itemColor(page));
    }
  }

  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: _controller,
      axisDirection: AxisDirection.right,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, viewportOffset) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final itemSize = constraints.maxWidth * _viewportFractionPerItem;
            viewportOffset
              ..applyViewportDimension(constraints.maxWidth)
              ..applyContentDimensions(0.0, itemSize * (filterCount - 1));

            // Constrain the stack height so the carousel, shadow and
            // selection ring all share the same center line. Previously
            // the shadow used a larger height which changed the Stack's
            // center and caused the selector to be vertically offset.
            return SizedBox(
              height: itemSize + widget.padding.vertical,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildShadowGradient(itemSize),
                  _buildCarousel(
                    viewportOffset: viewportOffset,
                    itemSize: itemSize,
                  ),
                  _buildSelectionRing(itemSize),
                  // Debug overlay: visible only in debug mode. Helps verify
                  // where the Stack's center is and what the controller
                  // reports as the current page while interacting.
                  if (kDebugMode)
                    IgnorePointer(
                      child: SizedBox.expand(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 2,
                              height: itemSize,
                              color: Colors.red.withOpacity(0.6),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'page: ${(_controller.hasClients ? (_controller.page ?? _page).toStringAsFixed(2) : _page.toString())}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildShadowGradient(double itemSize) {
    // Match the shadow height to the overall selector area so it doesn't
    // change the Stack sizing and move the centre point used by the
    // carousel and selection ring.
    return SizedBox(
      height: itemSize + widget.padding.vertical,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }

  Widget _buildCarousel({
    required ViewportOffset viewportOffset,
    required double itemSize,
  }) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      child: Flow(
        delegate: CarouselFlowDelegate(
          viewportOffset: viewportOffset,
          filtersPerScreen: _filtersPerScreen,
        ),
        children: [
          for (int i = 0; i < filterCount; i++)
            FilterItem(
              color: itemColor(i),
              onFilterSelected: () => _onFilterTapped(i),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          // Make the ring slightly smaller than the full item slot so it
          // surrounds the visible circular thumbnail which has internal
          // padding. The FilterItem uses 8px padding, so subtract that
          // on both sides to better match the visual circle.
          width: math.max(0, itemSize - 16),
          height: math.max(0, itemSize - 16),
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(width: 6, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

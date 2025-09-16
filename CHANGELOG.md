# Changelog

All notable changes to this package will be documented in this file.

## [0.0.1] - 2025-09-16
### Added
- Initial release of `nested_circular_progress_widget` package.
- `NestedCircularProgress` widget with:
    - Animated circular progress indicator.
    - Customizable size, stroke width, progress color, and background color.
    - Optional child widget centered inside the circle.
    - TweenAnimationBuilder with `Curves.easeOutCubic` for smooth progress animation.
- `CircularProgressPainter` used internally for drawing the progress ring.

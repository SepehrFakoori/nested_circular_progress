# Changelog

All notable changes to this package will be documented in this file.

---

## [0.0.2] - 2025-09-20
### Added
- Documentation comments for public classes, methods, and parameters to improve IntelliSense and Dartdoc.

---

## [0.0.1] - 2025-09-16
### Added
- Initial release of **`nested_circular_progress_widget`**.
- **`NestedCircularProgress`** widget with:
  - Animated circular progress indicator.
  - Customizable:
    - `size`
    - `strokeWidth`
    - `progressColor`
    - `progressBackgroundColor`
  - Optional child widget centered inside the circle.
  - Smooth animations using `TweenAnimationBuilder` with `Curves.easeOutCubic`.
- **`CircularProgressPainter`** used internally for rendering the circular progress ring.


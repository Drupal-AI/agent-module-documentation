<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Range NoUiSlider — agent orientation

Facets widget module (D9/D10, package "Search") adding a noUiSlider range slider UI to range facets.

- Depends on `facets` and `facets_range_widget`.
- Widget plugins: `src/Plugin/facets/widget/NoUiSliderWidget.php` and `RangeNoUiSliderWidget.php`.
- Purely a display/UI widget for numeric range facets; select it on the facet edit form.
- No routes, no permissions, no server-side request handling. No notable security surface.

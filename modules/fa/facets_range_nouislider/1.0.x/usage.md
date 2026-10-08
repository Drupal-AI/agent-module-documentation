<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Range NoUiSlider provides a noUiSlider-based range widget for the Facets module, letting site visitors filter results with a draggable dual-handle slider (and optional numeric min/max input boxes) instead of a list of range links.

It builds on the Facets and Facets Range Widget modules, adding two widget plugins (a plain noUiSlider widget and a range noUiSlider widget) with configuration for handles, steps, and min/max bounds.

---

- Depends on the `facets` and `facets_range_widget` contrib modules; Drupal 9 or 10.
- Enable with `drush en facets_range_nouislider`.
- Create a numeric range facet in a Search API facet source, then on the facet edit page select the noUiSlider widget.
- Configure the widget's min, max, step and input options on the facet's settings form.
- The noUiSlider JS library is attached automatically when the widget renders.

---

- Filter Search API results by a numeric range with a draggable slider.
- Offer a dual-handle range selection (lower and upper bound).
- Show optional min/max input boxes alongside the slider.
- Configure slider min, max, and step increments per facet.
- Replace the default list-of-links range facet with a modern UI control.
- Use for price, rating, year, or any numeric field facet.
- Integrate with Facets' AJAX-updating result blocks.
- Provide both a plain slider and a range slider widget variant.
- Apply to any facet whose source field is numeric.
- Keep facet processors (e.g. range) working under the slider UI.
- Improve UX for large numeric ranges over checkbox lists.
- Attach the noUiSlider library only where the widget is used.
- Support theming/overrides of the slider markup.
- Work within exposed Search API filter blocks.
- Localize min/max labels through Facets configuration.
- Combine with other facets on the same search page.

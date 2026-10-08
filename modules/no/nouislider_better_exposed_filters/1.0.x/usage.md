<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NoUiSlider integrates the noUiSlider JavaScript library into Better Exposed Filters so a multi-value select exposed filter renders as a drag slider instead of a select list.

---

The module registers a single `BetterExposedFiltersFilterWidget` plugin (id `bef_nouislider`). When applied to an exposed filter, it only acts on `select` elements that are `#multiple`; it hides the underlying select with a `d-none` class and injects an adjacent `<div>` carrying the slider's data attributes (min/max derived from the option order, a JSON option→id mapping, the current selection, and a pips mode). A small `nouislider-init` library (`js/nouislider.js`, depending on `core/drupal`, `core/once`, and the bundled noUiSlider library) then builds the slider and keeps the hidden select in sync so the normal Views exposed-form submit still works. The one configurable option is **Pips mode** — `range` (continuous scale) or `steps` (discrete stops).

Setup: install the noUiSlider library (>=15.7.x) into `/libraries/nouislider` (e.g. via `composer require oomphinc/composer-installers-extender npm-asset/nouislider`), enable this module and Better Exposed Filters, then in a View's exposed-filter BEF settings pick the **NoUiSlider** widget for the relevant filter and choose a pips mode. The module has no routes, permissions, services, or admin config of its own — all configuration lives inside the View. Because it decorates an existing exposed filter, its access posture is entirely that of the View it is placed on.
---
- Turn a multi-value select exposed filter into a drag slider
- Let visitors filter a View by dragging across an ordered range of terms
- Render an entity-reference exposed filter as a slider of labels
- Choose `range` pips mode for a continuous labelled scale
- Choose `steps` pips mode for discrete labelled stops
- Provide a touch-friendly filter control on mobile Views
- Replace a long, unwieldy multi-select box with a compact slider
- Show tick marks (pips) under the slider for orientation
- Preserve the user's current selection when the exposed form reloads
- Pair with Better Exposed Filters' other widget styling on the same View
- Filter a product listing by an ordered attribute (e.g. size) via slider
- Filter content by an ordered taxonomy (e.g. rating buckets) via slider
- Keep the underlying select in sync so AJAX Views refresh normally
- Style the slider with Bootstrap-friendly wrapper classes
- Install the noUiSlider library via Composer installers-extender
- Install the noUiSlider library manually into /libraries/nouislider
- Apply the widget per-filter from the View's BEF settings
- Use on any View display type that exposes a multiple select filter
- Provide a min/max handle range over an ordered option set
- Combine with exposed-filter default values to pre-position the handles

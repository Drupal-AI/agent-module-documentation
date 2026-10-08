<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Range Slider wraps the rangeslider.js library around Drupal's core HTML5 range input, providing a `range_slider` render/form element, a numeric field widget, and a Webform element so numbers can be entered with a draggable slider.

---

The module registers a `range_slider` form element (`Element\RangeSlider`, extending core's `Range`) that behaves like a normal range input but attaches the `range_slider/element.rangeslider` library — which pulls in rangeslider.js (2.3.2) from a CDN — and adds optional live output of the current value plus vertical orientation. It ships a field widget (`RangeSliderWidget`, id `range_slider`) usable on core `integer`, `decimal` and `float` fields; its two per-widget settings, **orientation** (horizontal/vertical) and **output** (none/below/above/left/right), are stored under `field.widget.settings.range_slider` on the form-display component and drive the element's `#data-orientation` and `#output` properties. A Webform element (`Plugin/WebformElement/RangeSlider`, category "Advanced elements") exposes the same slider inside Webform. The element also honours `#output__field_prefix` / `#output__field_suffix` for decorating the printed value (e.g. `$…USD`) and reads `#min`/`#max`/`#step` like any range element (the widget copies the field's min/max settings). There is no admin settings form, no permissions, no Drush, and no configure route — configuration is entirely per field-widget or per render-element usage.

---

- Let editors set a numeric field value by dragging a slider instead of typing.
- Add a range slider to an integer field (e.g. a 1–10 rating) via Manage form display.
- Add a range slider to a decimal or float field (e.g. a price or weight).
- Show the live value above, below, left, or right of the slider as the user drags.
- Prefix/suffix the printed value with units (e.g. `$` … `USD`, `kg`, `%`).
- Orient a slider vertically instead of horizontally.
- Use the `range_slider` form element directly in a custom form or render array.
- Constrain input to a field's configured min/max (the widget passes them through).
- Provide a slider input inside a Webform via the "Range Slider" advanced element.
- Replace a plain number field with a friendlier touch-friendly control on mobile.
- Build a "quantity" selector with a slider and a visible current value.
- Create a satisfaction / likelihood scale (0–100) with an on-slider readout.
- Set a step-based slider (whole numbers, or decimals) using the field's step.
- Keep values bounded so users cannot enter out-of-range numbers.
- Give a configuration form a slider for a percentage or intensity setting.
- Offer a volume/brightness-style control in a settings UI.
- Standardize numeric entry UX across content types with one widget.
- Add an accessible HTML5-range-based slider that degrades to a native range input.
- Display the selected number inline for immediate feedback without JavaScript alerts.
- Use vertical sliders in space-constrained layouts (e.g. a sidebar filter).

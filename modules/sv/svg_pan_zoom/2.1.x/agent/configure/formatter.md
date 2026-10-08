<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the SVG Pan Zoom formatter

Set on **Structure → Content types → Manage display** (or any entity's display) for an `image` field.

Choose formatter **"Svg Pan Zoom"**, then configure:

- **width / height** — text values applied as attributes on the rendered element (blank = intrinsic).
- **display** — `embed` (wraps file in `<embed type="image/svg+xml">`, safest) or `inline` (prints raw SVG markup so it can be styled/scripted with CSS/JS).
- **pan_enabled** (panEnabled), **zoom_enabled** (zoomEnabled), **control_icons_enabled** (controlIconsEnabled), **dbl_click_zoom_enabled**, **mouse_wheel_zoom_enabled**, **prevent_mouse_events_default** — booleans emitted as `data-*="true|false"`.
- **zoom_scale_sensitivity**, **min_zoom**, **max_zoom** — numeric zoom tuning.
- **fit**, **contain**, **center** — initial sizing/placement.
- **refresh_rate** — svg-pan-zoom refreshRate (`auto` or a number).

Each setting is emitted as a `data-<option>` attribute; `drupalSettings.svgPanZoom.availableOptions` maps snake_case setting names to the library's camelCase option names, and `js/` initialises the library on `.js-svg-pan-zoom` elements.

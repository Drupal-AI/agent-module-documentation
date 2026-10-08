<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Color Scales gives every numeric field in Views an optional Excel-style color-scale (heatmap): when enabled per field, each cell's value is interpolated to a background color between a low ("red") and high ("green") color, with an auto-contrasting black/white text color.

---

The module ships one Views field handler, `NumericColorScale` (plugin id `numeric_color_scale`), in `src/Plugin/views/field/NumericColorScale.php`, extending core's `NumericField`. It does **not** add a new field to Views. Instead `hook_views_data_alter()` in `views_color_scales.module` rewrites the handler `id` of every field whose `field.id` is `numeric` to `numeric_color_scale`, so all existing numeric fields transparently gain the extra options while behaving exactly like core numeric fields until you turn the feature on. Coloring is off by default (`color_scale` = FALSE) and configured per field in the Views UI (Add/edit a numeric field → *Color Scale* options): enable it, choose auto-detected or manual min/max, and pick the min-value and max-value colors (defaults `#FFB3B3` and `#B3FFB3`). At render time `render()` clamps the value into the range, computes the background color by linear RGB interpolation (`calculateColor()` → `hexToRgb()`, always emitted as a safe `#RRGGBB` hex string), and picks black or white text from a luminance formula (`getContrastColor()`). Auto mode (`getAutoMinMax()`) derives min/max from the numeric values of the current result set; manual mode uses the configured `color_scale_min`/`color_scale_max`. The colored cell is rendered through a Single Directory Component `views_color_scales:scale_popover` (`components/scale_popover/`), which sets CSS custom properties `--vcs-bg`/`--vcs-fg`. Modules can attach extra hover/focus content (gauges, images, tables) via `hook_views_color_scale_popover_alter($content, $context)` (see `views_color_scales.api.php`); when they do, the component renders a native HTML `popover` positioned by `scale_popover.js`. All standard core numeric-field formatting (precision, decimals, prefix/suffix, hide-empty) still applies because the handler subclasses `NumericField`. Config schema for the six options lives in `config/schema/views_color_scales.views.schema.yml`. Requires only core `views`; core requirement `^10.3 || ^11`; no permissions, routes, services, install file, or Drush commands.

---

- Turn a column of sentiment scores into a red-to-green heatmap for at-a-glance reading.
- Color-code performance metrics (KPIs, conversion rates) in an admin Views dashboard.
- Highlight survey or rating results so high and low values stand out visually.
- Shade financial figures (revenue, margin, cost) on a report View.
- Add a heatmap to inventory counts to spot low-stock rows quickly.
- Visualize test scores or grades on a student-results View.
- Emphasize outliers in analytics tables without a charting library.
- Use auto-detect min/max to instantly scale colors to whatever the current result set contains.
- Set fixed manual min/max thresholds so the same value always maps to the same color across pages and Views.
- Give different numeric fields in one View independent color schemes.
- Pick brand or theme-appropriate min/max colors instead of the red/green defaults.
- Keep all core numeric formatting (decimal precision, thousands separator, prefix/suffix) while adding color.
- Enable coloring on only the fields that benefit, leaving other numeric fields untouched.
- Rely on the automatic black/white text contrast for readability on any background color.
- Show a richer hover/focus popover (gauge, chart, image) on colored values via `hook_views_color_scale_popover_alter()`.
- Build an executive dashboard where several numeric columns each carry their own gradient.
- Compare rows quickly by scanning color intensity rather than reading numbers.
- Apply a consistent heatmap look across multiple Views by reusing the same manual range and colors.
- Enhance an existing View non-destructively — no new field, no template overrides, just per-field settings.
- Provide a lightweight, dependency-free alternative to embedding third-party visualization JS for simple value shading.

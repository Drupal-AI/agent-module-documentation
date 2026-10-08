<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Color Scales (views_color_scales) — agent index

Adds an optional **Excel-style color scale (heatmap)** to numeric Views fields: each cell's value
is interpolated to a background color between a low and a high color, with auto-contrasting text.
Package `Views`. Depends only on core **`views`**. Core `^10.3 || ^11`. GPL-2.0-or-later.
Version 1.x (installed 1.1.0).

- **The field handler, its six options, config schema, and how to enable coloring** →
  [fields/color_scale.md](fields/color_scale.md)
- **The popover component + `hook_views_color_scale_popover_alter()` extension point** →
  [api/popover.md](api/popover.md)

## What it actually is

- One Views field handler: `NumericColorScale` (plugin id **`numeric_color_scale`**, attribute
  `#[ViewsField("numeric_color_scale")]`), in `src/Plugin/views/field/NumericColorScale.php`,
  **extending core `NumericField`**. No new Views field is added.
- `hook_views_data_alter()` in `views_color_scales.module` rewrites **every** field whose
  `field.id === 'numeric'` to `numeric_color_scale`, so all existing numeric fields gain the
  Color Scale options and otherwise behave identically until coloring is enabled.
- One Single Directory Component **`views_color_scales:scale_popover`**
  (`components/scale_popover/`: `.twig`, `.css`, `.js`, `.component.yml`).
- One alter hook: **`hook_views_color_scale_popover_alter($content, $context)`**
  (`views_color_scales.api.php`).
- No permissions, no routes, no services, no `.install`, no Drush, no submodules.
  Config schema for the six field options: `config/schema/views_color_scales.views.schema.yml`.

## Mechanism (from source)

- `defineOptions()` adds: `color_scale` (FALSE), `color_scale_auto` (TRUE),
  `color_scale_min` ('0'), `color_scale_max` ('100'), `color_scale_min_color` (`#FFB3B3`),
  `color_scale_max_color` (`#B3FFB3`). `buildOptionsForm()` renders them under the field's
  settings, gated with `#states` on the *Enable Color Scale* checkbox.
- `render()`: gets the value, calls `parent::render()` for the formatted display value; if
  coloring is off (or the value is hidden-empty) it returns the parent render unchanged.
  Otherwise it resolves the interpolation range (auto = `getAutoMinMax()` over
  `$this->view->result`; manual = configured min/max, guarded so min==max → max+1), computes the
  background via `calculateColor()` and text color via `getContrastColor()`, builds the
  `scale_popover` component and returns `getRenderer()->render($build)`.
- `calculateColor()` clamps the value, linearly interpolates each RGB channel between the two
  configured hex colors (`hexToRgb()`), and returns `sprintf('#%02X%02X%02X', …)` — always a
  well-formed hex string. `getContrastColor()` returns `'black'`/`'white'` from the
  `(r*299 + g*587 + b*114)/1000` luminance.
- The component twig sets `style="--vcs-bg: {bg}; --vcs-fg: {fg}"` and slots the parent's rendered
  display value; when a popover-alter hook supplies content, a native `popover` div is added and
  positioned by `scale_popover.js` (`Drupal.behaviors.vcsScalePopover`, `core/once`).

## Notes / caveats

- Because the handler subclasses `NumericField`, all core numeric formatting (precision, decimals,
  prefix/suffix, hide-empty) still applies. Field/query access is core's, unchanged.
- Auto min/max is computed from the **current page's** result set, so the same value can map to a
  different color across pages; use manual min/max for stable thresholds.
- **Accessibility:** color should not be the only signal (color-blind users); the values remain
  visible in the cell.

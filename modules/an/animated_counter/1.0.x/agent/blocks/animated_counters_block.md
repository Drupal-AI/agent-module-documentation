<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animated Counters block (`animated_counters_block`)

The module's only feature. Class `AnimatedCountersBlock`
(`src/Plugin/Block/AnimatedCountersBlock.php`), `@Block(id = "animated_counters_block",
admin_label = "Animated Counters (Multiple)")`, extends core `BlockBase`. All configuration lives in
the block placement form — there is **no** `/admin/config` page, route, permission, or service.

## Install / enable

- `ddev drush en animated_counter -y`. `hook_install()` (`animated_counter.install`) installs
  `block_animate` if it is not already enabled. Requires core `block` (dependency).
- Place the block: Structure → Block layout → *Place block* → "Animated Counters (Multiple)", or via
  `block_content`/theme region as usual. Placing/configuring needs the **`administer blocks`**
  permission (standard core block placement).

## Block-level settings (`blockForm()`)

Stored in `$this->configuration` by `blockSubmit()`:

- `columns` — select: `auto` | `2` | `3` | `4` (CSS class `columns-<v>`).
- `style` — select: `card` | `bordered` | `minimal` (CSS class `style-<v>`).
- `gradient` — select: `none` | `blue` | `purple` | `sunset` | `green` (CSS class `gradient-<v>`).
- `ripple` — checkbox; when on, `build()` passes the class `ripple-enabled` and `counter.js` wires a
  click ripple on linked tiles.
- `top_content` — a **`text_format`** element (default format `basic_html`); optional rich-text
  region rendered above the tiles.
- `wrapper_class` — textfield; extra CSS class placed on `.animated-counter-wrapper`.

## Counter items table (`#type => table`, draggable)

Each row (`$form['items'][$delta]`) has these fields, defaulted from `$item[...]`:

| Field | FAPI `#type` | Notes |
|-------|--------------|-------|
| `value` | `number` | target number; `#required` |
| `suffix` | `textfield` | e.g. `%`, `+`, `K` |
| `label` | `textfield` | tile caption |
| `icon` | `textfield` | Font Awesome class, e.g. `fa-solid fa-cloud` |
| `icon_color` | `color` | HTML5 color picker, default `#2563eb` |
| `url` | `url` | optional link target |
| `duration` | `number` | animation ms, default `1500` |
| `weight` | `weight` | drag order (`counter-weight` tabledrag group) |
| `remove` | `submit` | `removeItem()` handler, `#limit_validation_errors => []` |

- **Add item** submit → `addItem()` appends a blank row (default `duration` 1500,
  `icon_color` `#2563eb`) and `setRebuild(TRUE)`.
- **Remove** submit (`remove_<delta>`) → `removeItem()` unsets that delta, re-indexes, rebuilds.
- `blockValidate()` just stashes the raw items in form state.
- `blockSubmit()` drops rows where both `value` and `label` are empty (`array_filter`), `usort()`s by
  `weight`, and stores `array_values($items)` in `configuration['items']`.
- A "Live Preview" `details` (`#weight => 100`) contains `<div id="counter-preview">`; the form
  attaches library `animated_counter/admin-preview` so `js/admin-preview.js` fills it from the
  current field values on `input`/`change`.

## Render (`build()`)

- Returns nothing (`[]`) when `configuration['items']` is empty.
- Otherwise returns `#theme => 'animated_counters'` with `#items`, `#columns`, `#style`,
  `#gradient`, `#ripple` (`'ripple-enabled'` or `''`), `#top_content`, `#wrapper_class`, attaches
  library `animated_counter/counter`, and sets `#cache` contexts `['url', 'user.roles']`,
  tag `config:block.block.<plugin_id>`, `max-age => -1` (permanent).

## Theme + client behavior

- Theme hook `animated_counters` (`animated_counter_theme()` in `.module`) →
  `templates/animated-counters.html.twig`. Each item becomes a `.counter-item`; the tile has a
  `.counter` div with `data-target="{{ item.value }}"`, `data-suffix`, `data-duration`, an optional
  `.counter-icon` `<i class="{{ item.icon }}">`, and a `.counter-label`. Items with a `url` are
  wrapped in an `<a>` (external `http…` URLs get `target="_blank" rel="noopener noreferrer"`).
- `js/counter.js` — `Drupal.behaviors.animatedCounter`: reads `data-target`/`data-duration`,
  animates 0→target with `requestAnimationFrame`, appends the suffix at the end; an
  `IntersectionObserver` (threshold 0.4) starts each counter once when it scrolls into view and then
  unobserves it. Also binds the ripple click handler under `.ripple-enabled`.

## Operating notes

- No config schema ships (no `config/` dir), so the block's item structure is not covered by a
  schema; it still exports as part of the `block.block.*` config.
- `top_content` is a full `text_format` value (`{value, format}`); author it with a trusted text
  format since it is block-owner content displayed to all visitors.
- Because `hook_page_attachments()` attaches the `counter` library site-wide, the block's CSS/JS and
  the Font Awesome CDN load on every page even without a placed block.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stored markup contract & rendering

The saved DOM is `div.advanced-container > div.advanced-column` (columns nest arbitrary editor
content; containers may nest containers up to `max_nesting_depth`). Every layout option is emitted
**twice**: as an inline `style` (immediate rendering) and as a `data-*` attribute (source of truth).
If a text format's HTML filter strips the inline `style`, `js/container.js` rebuilds the styling from
the `data-*` attributes. This is what makes the module filter-safe.

## Allowed elements (from `getElementsSubset()`)

The plugin whitelists a fixed set of `data-*` attributes plus `class` and `id` on the two element
types, and a `<div class>` wildcard so any editor-chosen class survives filtering. It does **not**
whitelist the raw `style` attribute, `attributes: true`, event handlers (`on*`), `href`/`src`, or
`<script>`/`<iframe>`. Container attributes: `data-container-width`, `data-gap`, `data-align`,
`data-padding`, `data-margin`, `data-background`, per-device `data-{width,gap,padding,margin}-{mobile,
tablet,desktop}`, the border set (`data-border-style/color/width/radius`, `data-border-sides`,
`data-border-inside`, per-side `data-border-{width,color}-{top,right,bottom,left}`, per-corner
`data-border-radius-{top-left,…}`), `data-shadow` (`soft|medium|strong`), `data-auto-stack`,
`data-auto-stack-tablet`, and `data-schema-type` / `data-schema-id` (Schema.org passthrough for
companion modules). Column attributes: `data-width` (+ `data-width-pct` flags), per-device widths,
`data-padding`, `data-background`, `data-valign` (`top|center|bottom`), the same border set,
`class`, `id`.

## CSS custom-property contract

The frontend stylesheet (`css/container.css`) consumes CSS variables the editor/JS declare **on the
element** (never inherited, so a nested container does not pick up its parent's width/gap):
`--container-width|gap|background`, `--column-width|padding|background`, per-device variants
(e.g. `--container-gap-mobile`), `--adv-gap` (the gap share each percentage column hands back so
`50% + 50% + gap` no longer wraps — `flex-basis: calc(width − gap × (n−1)/n)`), `--adv-cols` (column
count, resolved via CSS `:has()`), and `--adv-divider` (inside vertical dividers between columns).

## Frontend rebuild (`js/container.js`, library `container.frontend`)

`Drupal.behaviors.advancedContainer` processes each un-processed `.advanced-container`, marking it
`--processed`. For the container and each column it: sets the CSS custom properties above from the
`data-*` values; restores padding/margin/per-device spacing only when the inline style is absent
(`if (!el.style.padding)` style guards — inline downcast styles always take precedence); and
recomposes borders (uniform, per-side longhands, per-corner radii, inside dividers) from `data-*`
mirroring the editor's `getBorderStyles()`. It **only ever writes CSS style properties / custom
properties** — it does not use `innerHTML`, `setAttribute` on arbitrary attributes, or any HTML sink
with content-derived data. (The two `innerHTML` writes in the editor property views assign from a
fixed built-in icon dictionary, not user input.)

## Client-side value sanitization

`CKEditor5.advancedContainer.sanitize()` (`js/container.utils.js`) strips `<...>` tags,
`javascript:`, `expression(`, `url(`, `@import/@font-face/@charset/@namespace`, `;{}`, and CSS
comment delimiters from every value before it reaches the model; `isValidDimension()` /
`isValidColor()` restrict values to CSS units / `calc()` / a named-color and pattern set. This is a
UX/defense-in-depth layer on top of Drupal's text-format filter — the security boundary is the
elements subset, which does not permit `style` or scriptable attributes through the filter.

## Library attachment (`.module`)

`container.frontend` is attached lazily, only when rendered output contains the substring
`advanced-container`:
- `hook_entity_view` — scans `text_long` / `text_with_summary` / `text` fields that are visible in the
  display; fires before render-cache check so `#attached` is cached (works for anonymous page-cache).
- `hook_preprocess_field` — fallback for Views fields / custom render arrays; attaches at both the
  field-variables and item-content levels.
- `hook_preprocess_block` — fallback for `block_content` / custom blocks (iterates all field children,
  not just `body`).

Editor visibility is handled by `hook_library_info_alter`, which injects `css/container.admin.css`
(this module's `ckeditor5-stylesheets`) into core's `internal.drupal.ckeditor5.stylesheets` library —
core reads that info key only from themes, so a module shipping editor CSS must inject it itself. A
manual `?v=CKEDITOR_ADVANCED_CONTAINER_EDITOR_CSS_VERSION` query (preprocess disabled) busts proxy
caches, since bumping the module's own library version does not change core's injected URL.

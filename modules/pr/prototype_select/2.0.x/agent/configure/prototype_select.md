<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Prototype Select

One settings form, gated by core permission `administer site configuration`:

- **Prototype Select** — `/admin/config/user-interface/prototype_select`
  (route `prototype_select.admin`, form `\Drupal\prototype_select\Form\PrototypeSelectConfigForm`,
  config object `prototype_select.settings`). Menu link under *System → User interface*.

Enabling the module is enough to start enhancing selects: `hook_preprocess_select` adds the
`data-prototype-select` marker attribute to rendered `<select>` elements (when enabled for the active
theme) and attaches the `prototype_select/prototype_select` library. All global values are published to
`drupalSettings.prototype_select` by `hook_page_attachments_alter`.

## `prototype_select.settings` keys (config/install defaults)

```yaml
search_enable_threshold: 10      # min option count before the search box appears; 0 = disabled, 1 = always
max_shown_results: null          # cap matching options rendered (perf); blank/null = show all
selector: '[data-prototype-select]'   # comma-separated CSS selectors to enhance
exclude_selector: ''             # comma-separated CSS selectors to leave native
search_contains: false           # match inside words, not only at their start
show_selected: true              # show selected-value chips for multi-selects
prototype_select_include: 2      # 2 = everywhere, 0 = admin theme only, 1 = default (front-end) theme only
text_help: 'Use tab (or the down arrow key) to navigate through the list of suggestions'
text_placeholder: 'Search in the list'
text_no_result: 'No result'
text_results: '{x} suggestion(s) available'   # {x} = result count
text_delete_item: 'Remove {t}'   # {t} = option text; chip remove accessible name
text_delete: 'Remove'            # visible chip remove text
text_button: '<label>'           # multi-select trigger text; <label> uses the native select label
```

- The `prototype_select_include` radio maps to `PrototypeSelectConstants`:
  `PROTOTYPE_SELECT_INCLUDE_EVERYWHERE = 2`, `PROTOTYPE_SELECT_INCLUDE_ADMIN = 0`,
  `PROTOTYPE_SELECT_INCLUDE_NO_ADMIN = 1`. `ThemeOptions::isThemeEnabled()` compares the active theme
  against `system.theme` `admin`/`default` accordingly; the library/marker attribute are skipped when the
  gate returns FALSE.
- The `text_*` strings are required on the form. They are emitted into `drupalSettings` as plain data and
  the JS renders them with `textContent` / `setAttribute` (no HTML sink), so markup is not interpreted.
- Set via drush, e.g. `drush config:set prototype_select.settings search_enable_threshold 5`.

## Per-select override API (`data-prototype-select-*`)

Per-select data attributes override the global/constructor values. Booleans accept `true`, `false`,
`1`, `0`.

| Option | Data attribute | Notes |
| --- | --- | --- |
| `searchEnabledThreshold` | `data-prototype-select-search-enabled-threshold` | `0` disables search |
| `maxResults` | `data-prototype-select-max-results` | empty/`0` shows all matches |
| `searchContains` | `data-prototype-select-search-contains` | match inside words |
| `showSelected` | `data-prototype-select-show-selected` | chips for multi-selects |
| `focusSelected` | `data-prototype-select-focus-selected` | per-select only (no global/form key); makes the selected option active when a single-select opens |
| `text.help` | `data-prototype-select-text-help` | |
| `text.placeholder` | `data-prototype-select-text-placeholder` | |
| `text.noResult` | `data-prototype-select-text-no-result` | |
| `text.results` | `data-prototype-select-text-results` | `{x}` = count |
| `text.deleteItem` | `data-prototype-select-text-delete-item` | `{t}` = option text |
| `text.delete` | `data-prototype-select-text-delete` | |
| `text.button` | `data-prototype-select-text-button` | `<label>` = native label |

## JavaScript API

The library exports `PrototypeSelect`. The Drupal behavior (`Drupal.behaviors.prototypeSelect`,
using `core/once`) matches the configured selector, skips anything matching the exclude selector, and
calls `new PrototypeSelect(selectElement, options)`. The instance is attached to the original select as
`selectElement.prototypeSelect`; the native select remains the form-value source. `detach` on `unload`
calls `destroy()`, which removes the enhancement and clears `selectElement.prototypeSelect`.

```js
import PrototypeSelect from './PrototypeSelect';
const el = document.querySelector('#edit-category');
const ps = new PrototypeSelect(el, { maxResults: 25, searchContains: true });
ps.destroy();
```

## Theming the popup

Each select creates one native `<dialog>`, kept relative to its trigger, defaulting to logical
`bottom-start` placement and flipping above / to the logical end when the viewport requires. Page scroll
is locked while open. CSS custom properties on `.c-prototype-select` adjust the collision boundary and gap
(logical properties, so placement follows RTL automatically):

```css
.c-prototype-select {
  --prototype-select-viewport-offset-block-start: 8px;
  --prototype-select-viewport-offset-block-end: 8px;
  --prototype-select-viewport-offset-inline-start: 8px;
  --prototype-select-viewport-offset-inline-end: 8px;
  --prototype-select-popup-gap: 4px;
}
```

## Upgrading from 1.x

Run database updates after deploying 2.0.x. `prototype_select_update_20001()` rewrites configured
`[data-select-a11y]` selector tokens to `[data-prototype-select]`, sets the `exclude_selector` default
when missing, and clears stale `disabled_themes` config. The old `select-a11y.js` library,
`data-select-a11y` attribute, and `c-select-a11y__*` classes are removed — retheme custom CSS/JS to the
`c-prototype-select__*` / `data-prototype-select-*` namespace.

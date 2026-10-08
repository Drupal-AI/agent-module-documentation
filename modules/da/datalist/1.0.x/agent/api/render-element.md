# The `datalist` render element

Class `Drupal\datalist\Element\Datalist` (`src/Element/Datalist.php`), declared `@FormElement("datalist")`,
extends core `Drupal\Core\Render\Element\Textfield`. Use it in any form/render array with
`'#type' => 'datalist'`. It renders a **textfield bound to an HTML5 `<datalist>`**: the browser shows
the options as native suggestions while the field still accepts free text. Multivalue and option
grouping are not supported.

```php
$form['fruit'] = [
  '#type' => 'datalist',
  '#title' => $this->t('Fruit'),
  '#options' => [
    'ap' => 'Apple',
    'ba' => 'Banana',
  ],
  '#required' => TRUE,
  // Optional: server-side autocomplete fallback for unsupported mobile browsers.
  '#autocomplete_route_name' => 'my_module.fruit_autocomplete',
];
```

`#options` must be an **associative `key => label` array**. By default the **label is shown and the key
is submitted** (see "Value handling" below). If the field must be restricted to the options, add your
own validation — a `<datalist>` is a suggestion, not a constraint, and the field accepts any typed value.

## Element properties (from `getInfo()`, `src/Element/Datalist.php:46`)

| Property | Default | Meaning |
|---|---|---|
| `#options` | `[]` | Associative `key => label` suggestion list. |
| `#use_keys` | `FALSE` | `FALSE`: label is shown/typed, the key is the submitted value. `TRUE`: the key itself is shown and submitted (label is the option text). |
| `#list` | `NULL` | `<datalist>` id to bind to. If empty, the element generates `"{#id}-datalist"` and renders its own `<datalist>` tag. If set, it binds to an existing datalist and renders no tag of its own. |
| `#clear_button` | `'✖'` | Label of the "clear" button. **When non-empty, the `datalist/datalist` library (JS+CSS) is attached** and the clear/down buttons render. Set to `''`/`FALSE` for a pure no-JS element. |
| `#down_button` | `'▼'` | Decorative dropdown-affordance glyph (rendered next to the clear button). |
| `#clear_button_description` | `t('Clear field')` | Visually-hidden accessible label for the clear button. |
| `#autocomplete_route_name` | `NULL` | Route for the server-side autocomplete fallback (see "Browser fallback"). |
| `#autocomplete_route_parameters` | `[]` | Parameters for that route. |
| `#parent_textfield` | `parent::getInfo()` | Stashed base Textfield definition used by `fallbackTextfield()`. |

Inherits all `Textfield` properties (`#size`, `#maxlength`, `#placeholder`, `#pattern`, `#ajax`, …).
Button-label defaults come from static getters: `getClearButton()` (`✖`), `getDownButton()` (`▼`),
`getClearButtonDescription()` (`t('Clear field')`).

## Value handling (`valueCallback`, `src/Element/Datalist.php:148`)

With `#use_keys = FALSE` (default):
- The `<datalist>` `<option>`s are rendered with the **label** as their `value` (template
  `input--datalist.html.twig`), so the user sees/picks labels.
- On submit the input holds a label; `valueCallback` does `array_search($input, $element['#options'], TRUE)`
  and returns the matching **key**. If the input is already a key (value set in code) it is returned as-is.
- `preRenderDatalist` (`:179`) converts a key `#value` back to its label for display.
- Empty submit / required handling: `processDatalist` (`:99`) adds special handling so that an empty
  submission on a non-required field yields `NULL` rather than an "illegal choice" validation error
  (core would otherwise validate the submitted value against `#options`).

With `#use_keys = TRUE`: options render as `<option value="{key}">{label}</option>`, and the key is both
shown and submitted (`valueCallback` returns the input unchanged).

## Processing / render pipeline

- `#process`: `processDatalist`, `processAutocomplete`, `processAjaxForm`, `processPattern`, `processGroup`.
- `#pre_render`: `preRenderDatalist`, `preRenderGroup`.
- `preRenderDatalist` sets `type=text`, `autocomplete=off`, and adds classes: wrapper
  `form-type--datalist`; input `form-element`, `form-text`, `form-datalist`.
- `preRenderAjaxForm` (`:211`) defaults the AJAX trigger event to `change` when `#ajax` is set without one.

## Theming

- Theme hook `input__datalist`, registered by `datalist_theme()` (`datalist.module:27`), base hook `input`,
  template `templates/input--datalist.html.twig`.
- Preprocess `datalist_preprocess_input__datalist()` (`datalist.module:46`) exposes vars: `attributes`,
  `input`, `datalist`, `use_keys`, `clear_button`, `down_button`, `clear_button_description`, `options`,
  `children`.
- Markup: a `.datalist-container` wrapper holding the `<input>`, an optional clear `<button class="clear">`
  + `<span class="datalist__down-button">` (only when `#clear_button`), and the `<datalist>` (only when the
  element renders its own list). CSS lives in `assets/css/datalist.css` (positions the clear/down buttons,
  includes Gin admin-theme tweaks).

## JavaScript behavior (`datalist/datalist`, `assets/js/datalist.js`)

`Drupal.behaviors.datalist` runs **only when `#clear_button` is set** (that is what attaches the library).
Library deps: `core/drupal`, `core/drupal.announce`, `core/once`. It:
- Shows/hides the clear button as the input gains/loses a value; clicking it empties the input and
  refocuses.
- On `blur`/form `submit`, `selectFirstResult` snaps a non-matching typed value to the **first option whose
  text contains the typed substring** (case-insensitive) and announces the change via `Drupal.announce`.
- Applies the browser fallback (next section).

## Browser fallback (unsupported mobile browsers)

Native `<datalist>` suggestions are broken on some mobile browsers. The module treats these as
unsupported (both client- and server-side): **mobile Firefox on Android/iOS** and **mobile Edge on
Android/iOS** (user-agent sniff).

- Client-side (`datalist.js` `browserSupported()`): on an unsupported browser `removeDataList()` strips the
  `list` attribute and removes the `<datalist>`/down-button so a core `#autocomplete_route_name` autocomplete
  takes over; on a supported browser `removeAutocomplete()` strips the autocomplete classes so the native
  datalist is used instead.
- Server-side helpers (provided, not auto-invoked — call them from your own code to swap before render):
  - `Drupal\datalist\DatalistSupportedHelper::isSupportedBrowser(): bool` (`src/DatalistSupportedHelper.php`) —
    same user-agent check against `$_SERVER['HTTP_USER_AGENT']`.
  - `Datalist::fallbackTextfield(array $element): array` (`src/Element/Datalist.php:32`) — returns the element
    reset to a plain `#type = 'textfield'` while preserving `#autocomplete_route_name`.
  - Cache context **`datalist_supported`** (service `cache_context.datalist_supported`,
    `DatalistSupportedCacheContext`) — returns `'1'`/`'0'` from `isSupportedBrowser()`. Add
    `'#cache' => ['contexts' => ['datalist_supported']]` to any render array that branches on browser support
    so the two variants cache separately. (Its `getCacheableMetadata()` returns an empty `CacheableMetadata`.)

To use the fallback: supply `#autocomplete_route_name` (+ `#autocomplete_route_parameters`) pointing at a
route that returns core autocomplete JSON, and be sure the field has a working `autocomplete`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remote select element (`webform_remote_select_element`)

The module's only feature: a Webform select element that fills its `#options` from a REST/JSON endpoint.

## Install / enable

- `composer require drupal/webform_remote_select` (project ships nothing extra in `require`); the module
  depends on `webform`. Enable: `drush en webform_remote_select`.
- No permissions, no config-install objects, no config schema of its own, no routes, no services, no
  update hooks. Everything is configured per element inside the Webform UI (*Structure → Webforms →
  edit → Build → Add element → Remote select element*). The element category is *"Advanced elements"*.

## The two plugin classes

Webform elements are a pair (a Webform element plugin + a render/`FormElement`):

- **`src/Plugin/WebformElement/WebformRemoteSelectElement.php`** — `@WebformElement id =
  "webform_remote_select_element"`, **extends `Drupal\webform\Plugin\WebformElement\TextField`**.
  Provides the element config form, defaults, the HTTP fetch and JSON→options mapping, and validation.
- **`src/Element/WebformRemoteSelectElement.php`** — `@FormElement("webform_remote_select_element")`,
  **extends core `Drupal\Core\Render\Element\Select`**. Adds `#input`, `#multiple` (default FALSE),
  `#sort_options`/`#sort_start`, and the select process/pre-render callbacks; `processSelect()` prepends
  the empty option, `valueCallback()` resolves submitted values (multiple → `array_combine`, empty option
  → `#empty_value`).

## Element properties (`getDefaultProperties()`)

Each is an element `#property`; the config form fields live under a *Remote settings* fieldset in
`form()`:

| Property | Form field | Meaning |
|---|---|---|
| `endpoint` (required) | *Endpoint* (textarea) | URL fetched via GET. **Supports Drupal tokens.** |
| `headers` | *Headers* (textarea) | JSON object of request headers, e.g. `{'Content-Type': 'application/json'}`. |
| `response_key` | *Response data key* | Dotted path into the response before mapping items, e.g. `contentResponse.data.items`. Empty = use the top level. |
| `data_key` | *Response items key* | For a list of objects / associative data: which field is the option **value/key**. |
| `data_value` | *Response items value* | Which field is the option **label**. |
| `allow_duplicated_values` | checkbox | If multiple, allow the same value chosen more than once. |
| `use_empty_option` | checkbox | Show an empty/placeholder option. |
| `empty_option` | textfield | Override the empty-option label (else `- Select -` if required, `- None -` otherwise). |
| `use_select2` | checkbox | Enhance with Select2 (attaches `select2_full` + JS, adds `webform-select2` classes). |
| `cache_response` | checkbox | Cache the decoded response permanently. |

Translatable properties (from the render element's `defineTranslatableProperties()`): `endpoint`,
`headers`, `response_key`, `data_key`, `data_value`, `empty_option`.

## How options are fetched — `executeRequest($element, $webform_submission)`

Called from `prepare()` (when the form is rendered) and `formatHtmlItem()` (when a submitted value is
displayed). Steps:

1. `$client = \Drupal::httpClient();` (Guzzle; **default TLS verification — no `verify => false`**).
2. `#headers` is `json_decode`d after stripping `\r`/`\n`.
3. `#endpoint` is passed through `\Drupal::token()->replace($endpoint, $token_data, ['clear' => TRUE,
   'callback' => '_webform_remote_select_token_cleaner'])`. `$token_data` is empty for no submission,
   else `['webform' => …, 'webform_submission' => …]`. The callback `addslashes()`-escapes non-`:files:`
   replacements.
4. **Cache check:** `$cache_id = $endpoint` (the resolved URL). If `\Drupal::cache()->get($cache_id)`
   hits, use it; otherwise `GET` the endpoint with the headers, read the body, `json_decode(..., TRUE)`.
   If `#cache_response` is set and data is non-empty, `\Drupal::cache()->set($cache_id, $data,
   Cache::PERMANENT)`.
5. **Mapping** (after optional `#response_key` drill via `getJsonValue()`):
   - Flat indexed array of scalars → `#options[$item] = $item`.
   - Indexed array of objects → requires `#data_key` + `#data_value`: `#options[$item[data_key]] =
     $item[data_value]` (else returns `FALSE`).
   - Associative array → iterate, `#options[$item[data_key]] = is_array($item) ? $item[data_value] :
     $item`.
6. Any `\Exception` (network error, bad JSON shape) → returns `FALSE`; the caller keeps the element as a
   plain field with no remote options. `getJsonValue()` walks the dotted path, tolerating missing keys
   (leaves the array unchanged for a missing segment).

`getJsonValue()`, `isAssoc()` are private helpers; `formatHtmlItem()` re-runs `executeRequest()` to turn a
stored value back into its remote label (`$element['#options'][$value]`).

## Validation (multiple selects)

Wired in `prepare()` via `#element_validate`:

- `validateUniqueMultiple()` — errors if a value repeats (unless `#allow_duplicated_values`), and enforces
  the `#multiple` max count (mirrors core's "cannot hold more than @count values").
- `validateEmptyValues()` — errors if a multiple element has empty in-between item values.

## Front-end / libraries

- `js/webform_remote_select_element.js` (`Drupal.behaviors.webformRemoteSelectElement`) reads
  `drupalSettings.webform.remoteSelect[<key>].use_select2` and calls `.select2({})` on the matching
  `[data-id]` element. `prepare()` sets `data-id`, the `js-webform-remote-select-element` class, and (for
  `#use_select2`) the `webform-select2`/`js-webform-select2` classes plus the two libraries.
- `select2_full` loads Select2 **3.5.4** CSS/JS from `cdnjs.cloudflare.com` (external, `core/jquery` dep).

## Operating notes

- The endpoint must return JSON; pick `#response_key`/`#data_key`/`#data_value` to match the shape (see
  the table above). Mismatched shape yields no options rather than an error.
- With `#cache_response`, the cache id **is the fully token-resolved URL**, so token-varying URLs cache
  separately and a stale cache persists until the bin is cleared (`drush cr`).
- The element extends `TextField`, so it inherits TextField's non-remote settings/behaviours too.

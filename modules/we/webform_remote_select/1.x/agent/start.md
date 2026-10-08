<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Remote Select (webform_remote_select) — agent index

A single **Webform element** whose `#options` are fetched at render time from a **REST/JSON endpoint**
configured on the element. Package `Webform`. Depends on **`webform`** (`webform:webform`). Core
requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version 1.0.9 (doc dir `1.x`,
single-branch label). No permissions, no routes, no services, no admin settings page, no Drush, no
submodules (a `tests/modules/webform_remote_select_test` fixture is test-only, not shipped/enabled).

- **The element, all its properties, how options are fetched and mapped, caching, tokens, Select2, validation** →
  [plugins/remote_select_element.md](plugins/remote_select_element.md)

## What it actually is

- **Two classes for one element** (Webform elements are a render/`FormElement` pair):
  - `src/Plugin/WebformElement/WebformRemoteSelectElement.php` — the Webform element plugin
    (`@WebformElement id = "webform_remote_select_element"`, label *"Remote select element"*,
    category *"Advanced elements"*), **extends `Drupal\webform\Plugin\WebformElement\TextField`**.
    Defines the configuration form (`form()`), default properties (`getDefaultProperties()`), the
    server-side fetch (`executeRequest()`), JSON mapping (`getJsonValue()`, `isAssoc()`), multiple-value
    validation (`validateUniqueMultiple()`, `validateEmptyValues()`), and label formatting
    (`formatHtmlItem()`).
  - `src/Element/WebformRemoteSelectElement.php` — the render element
    (`@FormElement("webform_remote_select_element")`, **extends core `Drupal\Core\Render\Element\Select`**).
    Handles empty-option processing (`processSelect()`), value resolution (`valueCallback()`),
    attributes (`preRenderSelect()`), and declares translatable props (`defineTranslatableProperties()`:
    `endpoint`, `headers`, `response_key`, `data_key`, `data_value`, `empty_option`).
- **`webform_remote_select.module`** — one helper, `_webform_remote_select_token_cleaner()`, a token
  post-process callback that `addslashes()`-escapes non-file token replacements used in the endpoint URL.
- **`webform_remote_select.libraries.yml`** — `webform_remote_select_element` (attaches
  `js/webform_remote_select_element.js`, which only initialises Select2 on flagged elements) and
  `select2_full` (Select2 **3.5.4** CSS/JS from `cdnjs.cloudflare.com`, depends on `core/jquery`).

## Mechanism (from source)

- Options are fetched in **`executeRequest()`** using `\Drupal::httpClient()->get($endpoint, ['headers' => …])`.
  It is called from `prepare()` (form render) and `formatHtmlItem()` (submission display). Default Guzzle
  TLS verification applies (no `verify => false`).
- The **endpoint URL is an element property** (`#endpoint`, set in the Webform builder), run through
  `\Drupal::token()->replace()` with `webform` + `webform_submission` token data and the
  `_webform_remote_select_token_cleaner` callback.
- Response body → `json_decode(..., TRUE)`; optional dotted `#response_key` path via `getJsonValue()`;
  then mapped to `#options` three ways depending on whether the data is a flat array, a list of objects
  (`#data_key`/`#data_value`), or an associative array. Any exception → `FALSE` (element renders with no
  remote options).
- **Caching:** when `#cache_response` is on, the decoded data is stored `Cache::PERMANENT` in the default
  cache bin **keyed by the resolved endpoint URL**.

## Element properties (`getDefaultProperties()`)

`endpoint` (''), `headers` (''), `response_key` (''), `data_key` (''), `data_value` (''),
`allow_duplicated_values` (FALSE), `use_empty_option` (FALSE), `empty_option` (''), `use_select2` (FALSE),
`cache_response` (FALSE), plus everything inherited from `TextField`. Full semantics, JSON-shape examples,
and validation details in [plugins/remote_select_element.md](plugins/remote_select_element.md).

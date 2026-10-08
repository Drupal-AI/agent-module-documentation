<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget: `citeref_field_widget`

`src/Plugin/Field/FieldWidget/CiterefFieldWidget.php` (extends `WidgetBase`). Only widget for
the `citeref_field` type. Injects `config.factory` and `http_client` (Guzzle) via `create()`.

## Form (`formElement()`)

Everything is wrapped in a `details` element (`osp_citeref_field`, `#open`) with a unique
wrapper id `citeref-data-wrapper-<Html::getUniqueId>`. Sub-elements (each hideable — see
settings):

- `citeref_type` — `select`, options **DOI, Handle, ARK, URL, URN, Other** (default `DOI`).
  On `change` runs AJAX `citerefSelectCallback` → resets style to `apa`, clears ID/record, and
  updates the ID field's title/description via `getCitationIdTitle()` / `getCitationIdDescription()`.
- `citeref_style` — `textfield` with `#autocomplete_route_name = citeref_field.autocomplete`;
  only visible (`#states`) when type = DOI; default `apa`. On `autocompleteclose` runs AJAX
  `citerefAutocompleteCallback` (re-fetches the DOI citation with the new style).
- `citeref_id` — `textfield` (`#maxlength 255`), class `debounce-ajax`; the bundled JS fires a
  custom `debouncedInput` event that triggers AJAX `citerefCallback`.
- `citeref_record` — `textarea`, the free-form "Citation" text (editor-editable; AJAX callbacks
  pre-fill its `#value`).
- `message` — `#markup` placeholder where status/warning/error HTML is injected.

Attaches libraries `citeref_field/citeref_field_twig_default` and
`citeref_field/citeref_field_ui_default`. If field cardinality is 1 it also appends an `<h4>`
markup header built from the field name.

## AJAX lookup logic (`citerefCallback()`)

Dispatches on the selected `citeref_type`; `$value` = trimmed ID, `$citeref_id = urlencode($value)`:

- **DOI** — requires `preg_match('/^10[.]/', $value)`; GETs `doi_url . '/' . $citeref_id` with
  header `Accept: text/x-bibliography; style=<citeref_style>` (DOI content negotiation). Strips a
  leading `1.` / `(1)` / `[1]` from the returned bibliography line; detects an HTML error page
  (`<head>`).
- **Handle** — GETs `handle_net_url . '/' . $citeref_id . '?type=URL&type=EMAIL'`, JSON-decodes,
  collects `URL`/`EMAIL` values.
- **ARK** — GETs `ark_url . $citeref_id . '/??'` (N2T inflection).
- **URL** — validates with `UrlHelper::isValid($value, TRUE)`, GETs the URL, extracts `<title>`
  via `getTitle()` regex, builds `URL: <title>. Accessed <d Mon Y> from <url>`.
- **URN** — lowercased; `isbn:` → `getIsbn()` (Google Books `isbn_url . '?q=isbn:<n>'`),
  `issn:` → `getIssn()` (ISSN Portal `issn_url . '/<n>'`).
- **Other** — returns the element unchanged (no lookup).

`citerefAutocompleteCallback()` is the DOI-only re-fetch keyed on a newly chosen style.
Base URLs come from config object `citeref_field.settings` (read via `getEditable()`).

## Widget settings (`defaultSettings()` / `settingsForm()`)

Booleans `hideCiterefType`, `hideCiterefStyle`, `hideCiterefID`, `hideCiterefRecord` (default
FALSE) and labels `citeTypeLabel`, `citeStyleLabel`, `citeRecordLabel`,
`citeRecordDescriptionLabel`, `citeDetailLabel`. `sanitizeSettings()` casts the four hide flags
with `boolval()`. `settingsSummary()` lists hidden fields + labels.

## Save (`massageFormValues()`)

Lifts the four values out of the `osp_citeref_field` wrapper into `citeref_type`,
`citeref_style` (empty → `apa`), `citeref_id`, `citeref_record`; empty strings become `NULL`.

## Operate

Set the widget on *Manage form display* (it is the default for the field type). Enter an ID,
choose a type; the AJAX round-trip fills the citation text. Editors can also type the citation
text directly. External lookups need the site to reach doi.org / hdl.handle.net / n2t.net /
googleapis.com / portal.issn.org.

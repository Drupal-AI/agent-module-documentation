<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The TOC field type, widget & formatter

## Install & enable

```bash
composer require drupal/custom_toc
drush en custom_toc -y
```

Requires **`toc_api`** (`^2.0`) enabled. No sub-modules, no permissions, no Drush of its own.

## Add the field to a bundle

1. *Structure → Content types → (bundle) → Manage fields → Add field* → choose field type
   **"TOC (CKEditor)"** (`toc_link_overrides`).
2. On the field settings form (`fieldSettingsForm()` in `TocLinkOverridesItem`), set:
   - **Source field for TOC** (`source_field`) — a select of the bundle's formatted-text fields.
     Only `text_with_summary`, and `text_long` / `text` **with `text_processing` enabled**, are
     offered; if none exist it falls back to `body`. Required.
   - **Allowed text formats** (`allowed_formats`) — checkboxes from `filter_formats()`. Keep only
     **Full HTML** for CKEditor Full-HTML output. Required.
   - **Default text format** (`default_format`) — select from `filter_formats()`. Required.
3. The widget defaults to **"TOC CKEditor"** (`toc_link_overrides_widget`) and the formatter to
   **"TOC HTML"** (`toc_link_overrides_formatter`).

The source field must be **formatted text with text processing on**; plain-text fields are
excluded by the select filter. Best practice: add the TOC field to the **same bundle** as a Body
(or similar CKEditor) field.

## Field type — `TocLinkOverridesItem`

`id = toc_link_overrides`, `default_widget = toc_link_overrides_widget`,
`default_formatter = toc_link_overrides_formatter`.

Properties / schema columns:

| Property | Column type | Meaning |
|---|---|---|
| `value` | `text` (big) | The TOC HTML (main property, `mainPropertyName()`). |
| `format` | `varchar(255)` | Text format id the value was authored in. |
| `overrides` | `text` (big) | JSON string of per-entry text overrides (stored via a hidden widget element). |

`isEmpty()` returns TRUE only when **both** `value` and `overrides` are blank/whitespace.

Default field settings (`defaultFieldSettings()`): `source_field => 'body'`,
`default_format => 'full_html'`, `allowed_formats => ['full_html']`.

## Widget — `TocLinkOverridesWidget`

`formElement()` builds an AJAX container (`toc_container`) holding:

- a **`text_format`** element (`toc_container.value`) — `#allowed_formats` from the field's
  `allowed_formats` (falling back to `default_format` or `full_html`), pre-filled from any
  form-state-generated value else the stored `value`/`format`;
- a **"Regenerate TOC"** submit button (`toc_container.regenerate`) with an `#ajax` callback
  `ajaxRegenerate()` that re-renders the container; `#limit_validation_errors => []` so it runs
  without validating the whole node form; it carries `#toc_source_field`, `#toc_field_name`,
  `#toc_delta`, `#toc_default_format`;
- a **hidden** `overrides` element holding the stored overrides JSON.

Widget setting (`defaultSettings()`): `empty_message` (default *"No headings found in the selected
source field."*).

`massageFormValues()` flattens `toc_container` back into `value` / `format` / `overrides` for
storage.

### Regenerate flow (`regenerateSubmit()`)

1. Reads the source field text from user input / form values / the entity (via
   `getSourceFieldValue()`), tolerating the various `text_format` nesting shapes.
2. If the raw source already contains `<h1..6>` (`hasHtmlHeadings()`) it is used directly and the
   source is flagged for rewrite; otherwise it is run through `check_markup()` first
   (`getSourceFieldHtml()`).
3. `buildTocData()` loads the `toc_api` **"default" `TocType`** options, calls
   `toc_api.manager->create('toc_filter', $html, $options)`, and — when the TOC `isVisible()` —
   renders it with `toc_api.builder->buildToc()`. It returns the TOC HTML **and** the
   `$toc->getContent()` source HTML with heading IDs applied.
4. The generated TOC HTML and format are written back into form state, values, and user input so
   the CKEditor field shows them; the rewritten source HTML is pushed back into the source field's
   value and stashed in `custom_toc_regenerated_source_html`. Flags
   `custom_toc_regenerated` / `custom_toc_regenerated_source_field` are set and the form rebuilds.

`extractHeadings()` (DOM-based id→text map) and `buildTocHtml()` exist as helpers but are not on
the main regenerate path.

## Formatter — `TocLinkOverridesFormatter`

`viewElements()` renders each item as:

```php
[
  '#type'   => 'processed_text',
  '#text'   => (string) $item->value,
  '#format' => (string) $item->format,
]
```

So the stored TOC HTML is run through the **saved text format's filter pipeline** on display
(standard Drupal `processed_text` behavior). Select it per view-display on *Manage display*; it can
be hidden there and still injected by the module's `hook_node_view` (see
[../api/module-hooks.md](../api/module-hooks.md)).

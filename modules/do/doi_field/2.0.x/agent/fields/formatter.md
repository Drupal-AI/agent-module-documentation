<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `doi_field_formatter` (publication metadata display)

`src/Plugin/Field/FieldFormatter/DoiFieldFormatter.php`, extends `FormatterBase`.
`@FieldFormatter(id="doi_field_formatter", label="Doi Field", field_types={"doi_field"})`. This is
the field type's `default_formatter`; select it on **Manage display**.

## What it does

For each stored DOI, the formatter fetches publication metadata and renders selected parts of it.

- It depends on the **`doi_search`** service `doi_search.manager`
  (`\Drupal\doi_search\DoiSearchManager`), injected via `create()` /
  `$container->get('doi_search.manager')`.
- `viewElements()` loops the items, calling `getInfo($item->value)` per DOI, and builds a
  `#theme => 'doi_field'` render array with `#items`, `#multiple` (from field cardinality),
  `#label`, `#field_name`, `#label_hidden` and `#data_labels` (the `labels` setting).
- `getInfo()` calls `$this->doiSearchManager->getData($doi)` (which requests the **Crossref** works
  API and returns the decoded `message` object), then, for each selected element, extracts:
  - `title` — first non-container `*title*` property (`getPublicationTitle()`).
  - `author` — `formatAuthors()` joins `given family` (or falls back to `name`) with `, `.
  - `abstract` — `data->abstract` as-is.
  - `date` — `data->created['date-time']` formatted as `d M Y`, plus the raw datetime.
  - `link` — `data->URL`.
  - `pdf` — first `data->link[].URL` ending in `pdf` (`getPdfLink()`).

The lookup happens **at display/render time on every uncached view** — there is no caching layer in
this version (the project page notes one may be added later), so each render can issue an HTTP
request per DOI.

## Settings (`defaultSettings()` / `settingsForm()`)

| Key | Default | Meaning |
|---|---|---|
| `show` | `['title', 'author']` | Checkboxes selecting which elements render. Options: `title`, `author`, `abstract`, `date`, `link`, `pdf` (PDF link if available). **Required.** |
| `labels` | `0` | Checkbox: when on, print an `<h4>` label above each element (author/abstract/date/link). |

`settingsSummary()` shows "Visible Elements: …" and whether labels are shown. There is **no config
schema** shipped for these settings, so strict config-schema tooling may warn on the view-display
config; the settings still save and work.

Example view-display config:

```yaml
# core.entity_view_display.node.article.default
content:
  field_doi:
    type: doi_field_formatter
    label: above
    settings:
      show:
        title: title
        author: author
        abstract: '0'
        date: '0'
        link: '0'
        pdf: '0'
      labels: 0
```

## Template — `templates/doi-field.html.twig`

Theme hook `doi_field` is declared in `doi_field.module` `hook_theme()` with variables `items`,
`multiple`, `label`, `field_name`, `label_hidden`, `data_labels`. The template wraps output in
`field field--name-<name> field--type-doi_field`, optionally prints the field label, then per item
renders the selected pieces: title in `<h3 class="publication-title">`, author/abstract in `<div>`s,
date in a `<time>` element, and link/pdf as `<a target="_blank" rel="noopener noreferrer">`. To
customise output, copy the template into your theme and override it (standard Drupal template
override).

# Configure the `glossify_taxonomy` filter

Enable on a text format at `/admin/config/content/formats` → tick **"Glossify: Tooltips with
taxonomy"** → set options. Stored in `filter.format.<format>` → `filters.glossify_taxonomy.settings`.

## Settings keys (schema `filter_settings.glossify_taxonomy`)

| Key | Default | Meaning |
|---|---|---|
| `glossify_taxonomy_case_sensitivity` | `true` | Case-sensitive matching. |
| `glossify_taxonomy_first_only` | `true` | Link only first occurrence per field. |
| `glossify_taxonomy_ignore_tags` | `""` | Comma-separated tags to skip. |
| `glossify_taxonomy_type` | `tooltips` | `tooltips` \| `links` \| `tooltips_links` (**required**). |
| `glossify_taxonomy_tooltip_truncate` | `false` | Truncate tooltip to 300 chars. |
| `glossify_taxonomy_vocabs` | `NULL` | Source vocabularies — **required when enabled**. `;`-joined vid string. |
| `glossify_taxonomy_urlpattern` | `/taxonomy/term/[id]` | Link URL; `[id]` → term id. |
| `glossify_taxonomy_synonyms_field` | `""` | Text (plain) field on terms whose values also match. |

`glossify_taxonomy_vocabs` is checkboxes persisted as a semicolon-joined string; empty selection fails
validation when the filter is on.

## Term source (`process()`)

Queries `taxonomy_term_field_data` (alias `tfd`): `status = 1`, `vid IN (selected)`, current
`langcode`; `description__value` is the tooltip text. Query tag `glossify_taxonomy_tooltip`
(`hook_query_glossify_taxonomy_tooltip_alter()`). Before querying it calls
`moduleHandler->alter('glossify_taxonomy_vocabs', $vocabs)` so you can change the vocab list at runtime
(`hook_glossify_taxonomy_vocabs_alter()`). Cache tags `taxonomy_term_list:<vid>` are added.

## Configure via drush (example)

```php
$f = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$f->setFilterConfig('glossify_taxonomy', [
  'status' => TRUE,
  'settings' => [
    'glossify_taxonomy_type' => 'tooltips',
    'glossify_taxonomy_vocabs' => 'tags',              // ;-joined vids
    'glossify_taxonomy_urlpattern' => '/taxonomy/term/[id]',
    'glossify_taxonomy_case_sensitivity' => FALSE,
    'glossify_taxonomy_first_only' => TRUE,
  ],
]);
$f->save();
```

Read back: `drush cget filter.format.basic_html filters.glossify_taxonomy`. Render a string through the
format to test: `check_markup($text, 'basic_html')` — matched term names become
`<abbr class="glossify-tooltip-tip">` (tooltips) or `<a class="glossify-tooltip-link">` (links).

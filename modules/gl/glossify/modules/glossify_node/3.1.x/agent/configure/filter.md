# Configure the `glossify_node` filter

Enable on a text format: *Configuration → Content authoring → Text formats and editors* → edit a
format → tick **"Glossify: Tooltips with nodes"** → set options under *Filter settings*. Stored in
`filter.format.<format>` → `filters.glossify_node.settings`.

## Settings keys (schema `filter_settings.glossify_node`)

| Key | Default | Meaning |
|---|---|---|
| `glossify_node_case_sensitivity` | `true` | Case-sensitive matching. |
| `glossify_node_first_only` | `false` | Link only the first occurrence per field. |
| `glossify_node_ignore_tags` | `""` | Comma-separated HTML tags to skip (e.g. `h1,h2,strong`). |
| `glossify_node_type` | `tooltips` | `tooltips` \| `links` \| `tooltips_links` (**required**). |
| `glossify_node_tooltip_truncate` | `false` | Truncate tooltip to 300 chars. |
| `glossify_node_bundles` | `NULL` | Source content types — **required when enabled**. Stored as a `;`-joined string of type ids. |
| `glossify_node_urlpattern` | `/node/[id]` | Link URL; `[id]` → node id. |
| `glossify_node_synonyms_field` | `""` | A Text (plain) field on the nodes whose values also match. |

`glossify_node_bundles` is presented as checkboxes but persisted as a semicolon-joined string
(`setConfiguration()` collapses the array); an empty selection fails validation when the filter is on.

## Term source (`process()`)

Queries `node_field_data` (alias `nfd`) for `status = 1`, `type IN (selected)`, current `langcode`,
left-joined to `node__body` (alias `nb`) for the body text used as the tooltip. Query tag
`glossify_node_tooltip` (alter via `hook_query_glossify_node_tooltip_alter()`). Cache tags `node:<id>`
are added for each matched node.

## Synonyms

Set `glossify_node_synonyms_field` to a plain-text (`string`) field that exists on the selected
content types; its values are matched in addition to the title. Make sure the field exists on **every**
selected bundle or synonyms are skipped for the missing ones.

## Configure via drush (example)

```php
$f = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$f->setFilterConfig('glossify_node', [
  'status' => TRUE,
  'settings' => [
    'glossify_node_type' => 'links',
    'glossify_node_bundles' => 'article',        // ;-joined type ids
    'glossify_node_urlpattern' => '/node/[id]',
    'glossify_node_case_sensitivity' => FALSE,
    'glossify_node_first_only' => TRUE,
  ],
]);
$f->save();
```

Read back: `drush cget filter.format.basic_html filters.glossify_node`.

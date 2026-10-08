# Configure the HTML Element Filter processor

This module has **no configure route** (`configure: null`). You enable and configure the
`html_element_filter` processor **per Search API index**.

## Via the UI

1. Go to *Configuration › Search and metadata › Search API*, edit your index, open the
   **Processors** tab (`/admin/config/search/search-api/index/<id>/processors`).
2. Tick **HTML Element Filter**.
3. In its settings enter one **CSS selector per line** in **CSS Selectors** (required), e.g.
   ```
   .sidebar-filters
   .advert
   nav
   ```
4. Optionally leave **Enable post-process query** checked so result-item field values are also
   cleaned (uncheck to clean only the index).
5. Save. Re-index the index for existing content to be re-processed.

Because it extends `FieldsProcessorPluginBase`, the standard processor field selection applies —
choose which text/fulltext fields it runs on (or all of them).

## Settings (config)

Stored inside the index config entity `search_api.index.<id>` under
`processor_settings.html_element_filter`:

| Key | Type | Meaning |
|---|---|---|
| `css_selectors` | string (newline-separated) | Selectors of elements to remove. Split on `\r\n`. |
| `enable_postprocess_query` | boolean (default TRUE) | Also strip elements from returned result item fields. |
| `fields` / `all_fields` | from FieldsProcessorPluginBase | Which fields the processor applies to. |
| `weights` | map | Stage weights (defaults: `preprocess_index` -30, `postprocess_query` -30, `pre_index_save` 0). |

Read it back:

```bash
drush cget search_api.index.<id> processor_settings.html_element_filter
```

## Configure with drush (scriptable)

```php
$config = \Drupal::configFactory()->getEditable('search_api.index.my_index');
$ps = $config->get('processor_settings') ?? [];
$ps['html_element_filter'] = [
  'css_selectors' => ".sidebar-filters\r\n.advert",
  'enable_postprocess_query' => TRUE,
  'all_fields' => TRUE,
  'fields' => [],
  'weights' => ['preprocess_index' => -30, 'postprocess_query' => -30],
];
$config->set('processor_settings', $ps)->save();
```

(Equivalently, load the index entity and call `$index->addProcessor(...)` /
`$index->setOption('processor_settings', ...)->save()`.)

## Behaviour notes

- Selectors are parsed with Symfony DomCrawler; an **invalid** selector is flagged on the config
  form (`SyntaxErrorException`) and is silently skipped at runtime, so it can't break indexing.
- Matching is done against each field's HTML; matched nodes are removed via
  `parentNode->removeChild()`, and the cleaned `<body>` inner HTML is returned.
- The value must contain HTML for selectors to match — a plain-text field with no markup is
  unaffected.

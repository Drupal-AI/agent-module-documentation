<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & per-View query options

## Global module setting

Config object: **`views_json_source.settings`** (route `views_json_source.settings` at
`/admin/config/user-interface/views-json-source-settings`, permission "administer site
configuration"; menu link `views_json_source.admin`).

| Key | Default | Meaning |
|---|---|---|
| `cache_ttl` | `86400` | Seconds a fetched JSON response is cached in `cache.default` before re-fetching. |

```bash
drush cget views_json_source.settings cache_ttl
drush cset views_json_source.settings cache_ttl 3600 -y
```

Local files (a `json_file` with no host, i.e. a `/`-relative path under `DRUPAL_ROOT`) are
**not** cached — only remote URLs are.

## Per-View query options (Query settings)

Set on the View at *Advanced → Query settings* (stored under
`display.<id>.display_options.query.options`, query `type: views_json_source_query`).
Defined in `ViewsJsonQuery::defineOptions()`:

| Option | Default | Meaning |
|---|---|---|
| `json_file` | `''` | URL, or `/`-relative local path. Drupal tokens allowed (e.g. `[site:url]`). A `%` in the URL is filled by the URL-parameter contextual filter. |
| `row_apath` | `''` (required) | Apath pointer to the array of records inside the document (see [../plugins/views.md](../plugins/views.md)). |
| `headers` | `''` | Request headers as a JSON string, e.g. `{"Authorization":"Basic …"}`; each value is token-replaced. |
| `request_method` | `get` | `get` or `post`. |
| `request_body` | `''` | POST multipart body as a JSON string (Guzzle multipart format). Only used with `post`. |
| `single_payload` | `''` | Check when the response is a single object, not a list of rows. |
| `show_errors` | `TRUE` | Log JSON parse / HTTP errors (recommended on during development). |

## Minimal View creation from code

```php
use Drupal\views\Entity\View;
View::create([
  'id' => 'my_json_view', 'label' => 'My JSON View', 'base_table' => 'json',
  'display' => [
    'default' => [
      'display_plugin' => 'default', 'id' => 'default', 'display_title' => 'Master',
      'position' => 0,
      'display_options' => [
        'query' => ['type' => 'views_json_source_query', 'options' => [
          'json_file' => 'https://example.com/nodes.json',
          'row_apath' => 'data/nodes',
          'request_method' => 'get',
          'show_errors' => 1,
        ]],
        'fields' => [
          'title' => ['id' => 'title', 'table' => 'json', 'field' => 'value',
                      'plugin_id' => 'views_json_source_field', 'key' => 'title'],
        ],
      ],
    ],
  ],
])->save();
```

Read the source back: `drush cget views.view.my_json_view
display.default.display_options.query.options`.

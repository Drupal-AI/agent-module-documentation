<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the JSON:API data parser

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: jsonapi
  item_selector: data
  jsonapi_host: 'https://source.example.com'
  jsonapi_prefix: '/jsonapi'
  jsonapi_endpoint: '/node/article'
  jsonapi_query_params:
    filter:
      default_langcode: 1
  urls: []
```

Multilingual:

```yaml
  jsonapi_query_params:
    filter:
      default_langcode: 0
  jsonapi_langcodes:
    - ja
    - de
  urls: []
```

Notes (`src/Plugin/migrate_plus/data_parser/Jsonapi.php`): `jsonapi_host`, `jsonapi_prefix`, `jsonapi_endpoint` are required (constructor throws `MigrateException` otherwise). Default `page[limit]` is 50. `page[offset]` is incremented automatically until an empty page. Override parameter names via `jsonapi_query_param_keys` (`page_offset`, `page_limit`, `language`). `empty_langcode` defaults to `und`; `prepend_langcode` defaults TRUE.

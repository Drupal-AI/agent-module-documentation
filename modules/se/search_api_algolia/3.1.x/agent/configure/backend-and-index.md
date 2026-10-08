<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Algolia backend and index

There is no dedicated settings page; you configure a Search API **server** (the backend) and
one or more **indexes**, plus a small module settings object.

## 1. Server with the Algolia backend

- **UI:** `/admin/config/search/search-api` → *Add server* → Backend: **Algolia**.
- **Backend id:** `search_api_algolia`. Backend config keys:

| Key | Meaning |
|---|---|
| `application_id` | Algolia Application ID (from the Algolia dashboard). |
| `api_key` | Algolia **Write** API Key. |
| `disable_truncate` | Do not truncate values before indexing. |

```php
\Drupal\search_api\Entity\Server::create([
  'id' => 'algolia', 'name' => 'Algolia', 'status' => TRUE,
  'backend' => 'search_api_algolia',
  'backend_config' => [
    'application_id' => 'YOUR_APP_ID',
    'api_key' => 'YOUR_WRITE_API_KEY',
    'disable_truncate' => FALSE,
  ],
])->save();
```

The keys are found/configured at `https://algolia.com/account/api-keys`. Store real secrets
via the Key module / environment, not in committed config.

## 2. Per-index options (added by `search_api_algolia_form_search_api_index_edit_form_alter`)

On a Search API index using an Algolia server, these options appear (stored in the index's
`options`):

| Option | Meaning |
|---|---|
| `algolia_index_name` | The Algolia index name to write to. |
| `algolia_index_apply_suffix` | (multilingual) append `_<langcode>` → `PREFIX_en`, `PREFIX_fr`. |
| `algolia_index_batch_deletion` | Delete items in batches (required to use `object_id_field`). |
| `object_id_field` | Field to use as Algolia `objectID` (empty = Search API default). |
| `partially_update_objects` | Update populated fields instead of replacing the whole object. |

Validation: setting `object_id_field` without `algolia_index_batch_deletion` is rejected.

```php
$index = \Drupal\search_api\Entity\Index::load('my_index');
$index->setOption('algolia_index_name', 'prod');
$index->setOption('algolia_index_apply_suffix', 1);
$index->save();
```

## 3. Module settings (`search_api_algolia.settings`)

| Key | Default | Meaning |
|---|---|---|
| `debug` | `false` | Verbose logging around indexing/queries. |
| `wait_for_delete` | `false` | Wait for Algolia delete operations to finish. |

```bash
drush cget search_api_algolia.settings
drush cset search_api_algolia.settings debug true -y
```

## Sorting & autocomplete (conventions)

- **Sorting** uses Algolia **replicas**; create a replica per exposed sort named
  `PREFIX_LANGCODE_fieldname_direction` (direction `asc`/`desc`).
- **Autocomplete** uses Algolia **Query Suggestions**; create a query index `INDEX_NAME_query`
  and use `search_api_autocomplete`.

See the module's `INSTALL.md` for the full index/field/processor walkthrough.

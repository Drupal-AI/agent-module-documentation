<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a search page

## The `search_api_page` config entity

Config entity type id: **`search_api_page`** (`config_prefix: search_api_page`), so each
instance is stored as config object **`search_api_page.search_api_page.<id>`**. Admin UI:
**`/admin/config/search/search-api-pages`** (route `entity.search_api_page.collection`,
the module's `configure` route). Add a page at `.../add`.

Exported fields (`config_export`) with defaults:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `id` | string | — | machine id |
| `label` | string | — | human label |
| `path` | string | — | URL path the page serves, e.g. `search/content` (no leading slash) |
| `clean_url` | bool | `true` | path-based keys (`/path/<keys>`) vs. query string (`?keys=`) |
| `show_all_when_no_keys` | bool | `false` | list all results before any search is run |
| `index` | string | — | machine id of the bound Search API index |
| `limit` | int | `10` | results per page (pager size) |
| `searched_fields` | array | `[]` | subset of the index's full-text field ids to search (empty = all) |
| `style` | string | `view_modes` | `view_modes` (rendered entities) or `search_results` (excerpt snippets) |
| `view_mode_configuration` | array | `[]` | per-datasource/bundle view mode overrides |
| `show_search_form` | bool | `true` | render the search form above results |
| `parse_mode` | string | `direct` | Search API parse mode (`direct`, `terms`, ...) |

`index` is the only binding that matters most: **the index must already exist** (the entity
adds a config dependency on it). Saving or deleting a page rebuilds the router (the path
becomes a live route). The `path` is registered via a dynamic route callback
(`SearchApiPageRoutes::routes`) + an inbound path processor for the clean-URL keys.

## Create one with Drush / PHP (fastest)

```bash
drush php:eval '
  \Drupal\search_api_page\Entity\SearchApiPage::create([
    "id" => "content_search",
    "label" => "Content search",
    "path" => "search/content",
    "index" => "primary",          // machine id of an existing Search API index
    "clean_url" => TRUE,
    "limit" => 10,
    "style" => "view_modes",       // or "search_results" for snippets
    "show_search_form" => TRUE,
    "parse_mode" => "direct",
  ])->save();
'
```

Read it back:

```bash
drush config:get search_api_page.search_api_page.content_search
```

List every page id:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("search_api_page")->loadMultiple() as $p) { print $p->id()." => /".$p->getPath()." [".$p->getIndex()."]\n"; }'
```

Delete:

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("search_api_page")->load("content_search")->delete();'
```

## The search form block

Block plugin id **`search_api_page_form_block`** (admin label "Search Api Page search
block form", category *Forms*). Place it like any block; its one setting,
`search_api_page`, selects which page id submissions redirect to. Stored under
`block.settings.search_api_page_form_block` (`search_api_page: <page id>`).

```bash
drush php:eval '
  \Drupal\block\Entity\Block::create([
    "id" => "content_search_form",
    "plugin" => "search_api_page_form_block",
    "theme" => \Drupal::config("system.theme")->get("default"),
    "region" => "sidebar_first",
    "settings" => ["id" => "search_api_page_form_block", "label" => "Search", "search_api_page" => "content_search"],
  ])->save();
'
```

## Prerequisite: an index to bind

There must be at least one Search API index. If none exists, create a DB-backed server +
index first (no external service needed):

```bash
drush php:eval '
  \Drupal\search_api\Entity\Server::create(["id"=>"db_server","name"=>"DB","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3]])->save();
  \Drupal\search_api\Entity\Index::create(["id"=>"content_index","name"=>"Content","status"=>TRUE,"server"=>"db_server","datasource_settings"=>["entity:node"=>[]]])->save();
'
```

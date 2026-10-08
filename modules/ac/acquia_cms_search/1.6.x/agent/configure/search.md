# Configure search (acquia_cms_search)

There is **no admin settings form** for this module (`configure` is null). It works by shipping a
ready-made Search API stack as installed config and then keeping that stack in sync as content types
and fields are added. You "configure" it by (a) letting a search_api index opt into a server, (b)
opting node types / fields into an index, and (c) optionally switching to Acquia Search Solr.

## What ships as config

`config/install/` (created on enable, cannot be uninstalled cleanly without them):

| Config | Machine name | Notes |
|---|---|---|
| search_api index | `content` | `status: false` on install; datasource `entity:node` with **no bundles selected**; carries `third_party_settings.acquia_cms_common.search_server: database`. Processors: content_access, html_filter, ignorecase, stopwords, tokenizer, transliteration, rendered_item. |
| views | `search` | Page display at path **`search`**; base table `search_api_index_content`; exposed keyword filter (`search_api_fulltext`) in an exposed block; row plugin `search_api` (teaser view mode); cache `search_api_tag`. |
| views | `search_fallback` | Node-based view; its `search_fallback_block` display is embedded by the `view_fallback` area of `search` and shown only when the search server is down (see [views/views.md](../views/views.md)). |
| autocomplete search | `search` | `search_api_autocomplete` config over index `content`, wired to the `search` view's exposed filter. |

`config/optional/` (installed only when their dependencies are met):

| Config | Machine name | Notes |
|---|---|---|
| search_api server | `database` | Backend `search_api_db`, DB `default:default`, `min_chars: 1`, `matching: partial`, autocomplete suffix/words on. Enabled. |
| facet | `search_content_type` | Field `type`; url alias `content_type`; source `search_api:views_page__search__search`; links widget. |
| facet_source | `search_api__views_page__search__search` | `url_processor: facets_pretty_paths`. |
| views | `acquia_search` | Disabled Solr results view (base `search_api_index_acquia_search_index`); part of the Acquia Search path. |
| blocks | `clear_facet_filters`, `exposed_form_search`, `search_category`, `search_content_type` | Placed in the Cohesion/Site Studio `dx8_hidden` region of `cohesion_theme`; see [blocks/blocks.md](../blocks/blocks.md). |

`config/pack_acquia_cms_search/` holds Site Studio (`cohesion`) view templates for the search views;
`hook_update_8001`/`8002` enforce their module dependency and prune invalid ones when
`acquia_cms_site_studio` is present.

## Opting content into the index (third-party settings)

All keys live under the **`acquia_cms_common`** third-party namespace.

| Carrier | Setting | Effect | Schema |
|---|---|---|---|
| search_api **index** | `search_server` | On the next insert of a matching search_api server, the disabled index is attached to that server and enabled, then the setting is removed. | `acquia_cms_search.schema.yml` (`search_api.index.*.third_party.acquia_cms_common`) |
| **node.type** | `search_index` | New node type is added to the named index's `entity:node` datasource `bundles.selected`, its `rendered_item` view mode set to `search_index`, and the `search` view row view mode set to `teaser`. | added at runtime by `hook_config_schema_info_alter` to `node.type.*.third_party.acquia_cms_common` |
| field **storage** | `search_index`, `search_label` | Lets a field opt into indexing and supply a human label (field storages have none). The module sets these on `node.body` automatically. | (uses acquia_cms_common's mapping) |

Set the node-type opt-in from PHP:

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('acquia_cms_common', 'search_index', 'content')->save();
// The insert hook only fires for NEW node types; re-enabling the module also
// walks existing node types (hook_install). To force it now:
\Drupal::classResolver(\Drupal\acquia_cms_search\Facade\SearchFacade::class)->addNodeType($type);
```

Field auto-indexing (handled in `acquia_cms_search_field_config_insert`): `node.body`
(`text_with_summary`) is tagged for the `content` index; taxonomy-term `entity_reference` fields are
added as both an integer id and a `_name` string; and fields of type `datetime`, `string`, `email`,
`telephone`, `address`, `text_with_summary` are indexed with a mapped Search API type. See
[hooks/hooks.md](../hooks/hooks.md) for the exact triggers.

## Switching to Acquia Search (Solr)

The distribution's **Acquia CMS Tour** dashboard (provided by `acquia_cms_tour`) gets two tiles from
this module — plugins `acquia_search` (`AcquiaSearchForm`) and `acquia_connector`
(`AcquiaConnectorForm`). On the Acquia Search tile an admin enters the subscription **identifier**,
**Connector key**, **API host** and **application UUID**; submit writes `acquia_search.settings:api_host`
and the `acquia_connector.*` state values.

`hook_form_acquia_cms_search_form_alter` appends `AcquiaSearchFacade::submitSettingsForm` as a submit
handler (also invoked on `hook_search_api_server_update` for an Acquia server). When the connector is
fully configured, `AcquiaSearchFacade::switchIndexToSolrServer()`:

- points the `content` index at the `acquia_search_server` and re-indexes (only if it was on `database`),
- unlinks/disables the `acquia_search_index` and any views based on it,
- disables the `database` server.

## Config schema

`config/schema/acquia_cms_search.schema.yml` declares only the `search_server` third-party mapping on
`search_api.index.*`. The `search_index` mapping on `node.type.*` is added dynamically by
`hook_config_schema_info_alter`. The module ships **no settings object of its own**.

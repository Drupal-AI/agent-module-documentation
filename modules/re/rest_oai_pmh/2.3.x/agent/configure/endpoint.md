<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring & operating the OAI-PMH endpoint

Grounded in `src/Form/RestOaiPmhSettingsForm.php`, `src/Plugin/rest/resource/OaiPmh.php`,
`rest_oai_pmh.module`, `config/install/*`, and `rest_oai_pmh.routing.yml`.

## Prerequisites

- Modules `views` and `rest` (deps) plus a **metadata mapping source** — `rdf` core module for
  `dublin_core_rdf`, or `metatag`/`schema_metatag` for `dublin_core_metatag`.
- At least one **View with an *Entity Reference* display** — that display type is what the
  settings form lists as a candidate to expose. (Ships `config/optional/views.view.article_mods_mapping.yml`
  as a MODS example.)

## 1. Make the endpoint reachable (REST permission)

Enabling the module installs the REST resource `oai_pmh` (config `rest.resource.oai_pmh`:
methods GET+POST, format `oai_dc`, cookie auth) but it returns **403 until permission is
granted**. OAI harvesters are anonymous, so normally grant the anonymous role:

```bash
drush role:perm:add anonymous 'restful get oai_pmh'
drush role:perm:add anonymous 'restful post oai_pmh'   # only if you need POST harvesting
```

Verify the route/path:

```bash
drush php:eval 'print \Drupal::service("router.route_provider")->getRouteByName("rest.oai_pmh.GET")->getPath()."\n";'
# /oai/request
```

## 2. Settings form — `/admin/config/services/rest/oai-pmh`

Route `rest_oai_pmh.rest_oai_pmh_settings_form`, permission `administer rest resources`.
Writes to the config object **`rest_oai_pmh.settings`**. Fields → config keys:

| Form field | Config key | Notes |
|---|---|---|
| What to expose (checkboxes) | `view_displays` | `{view_id}:{display_id}` of each *Entity Reference* View display to index. Newly-checked displays are indexed immediately via batch. |
| Support Sets | `support_sets` | Bool (default TRUE). If off, all Views are treated as one flat set and `ListSets` returns `noSetHierarchy`. |
| Metadata Mappings | `metadata_map_plugins` | Array of `{label: <prefix>, value: <plugin_id>}` — maps each metadataPrefix (e.g. `oai_dc`, `mods`) to an `OaiMetadataMap` plugin. Empty value = format disabled. |
| MODS View | `mods_view` | `{view_machine_name, view_display_name}` the `mods` plugin pulls from. |
| Repository Name | `repository_name` | Returned by `Identify` (defaults to site name). |
| Repository Admin E-Mail | `repository_email` | Returned by `Identify` (defaults to site mail). |
| Repository Path | `repository_path` | Public endpoint path; default `/oai/request`. Changing it rewrites the REST route (`hook_rest_resource_alter` + router rebuild) and is validated to not collide with an existing path. |
| Resumption token expiry | `expiration` | Seconds a `resumptionToken` stays valid (default 3600). |
| Caching Technique | `cache_technique` | `liberal_cache` or `conservative_cache` (see plugins doc). Default `liberal_cache`. |

Set the same values from code/CI with Drush instead of the UI:

```bash
drush cset rest_oai_pmh.settings view_displays.my_view:entity_reference_1 my_view:entity_reference_1 -y
drush cset rest_oai_pmh.settings metadata_map_plugins.0.label oai_dc -y
drush cset rest_oai_pmh.settings metadata_map_plugins.0.value dublin_core_rdf -y
drush cset rest_oai_pmh.settings repository_name 'My Repository' -y
drush cset rest_oai_pmh.settings support_sets 1 -y
```

> Note the legacy shape: `config/install/rest_oai_pmh.settings.yml` ships only
> `rest_oai_pmh.entity_type: node`; the real operational keys above are written by the form.

## 3. Build / rebuild the index

Records are **not** live — they are materialized into `rest_oai_pmh_record` /
`rest_oai_pmh_set` / `rest_oai_pmh_member` by walking the selected Views. Trigger a full
rebuild (truncates the tables, re-queues every View) from the **Rebuild** form
(`/admin/config/services/rest/oai-pmh/queue`, route `rest_oai_pmh.queue`) or programmatically:

```bash
# full synchronous rebuild (queue all Views, then drain the queue)
drush php:eval 'rest_oai_pmh_rebuild_entries();'
```

Cron drains the `rest_oai_pmh_views_cache_cron` queue on each run. As a safety net, the first
harvest request auto-rebuilds if `rest_oai_pmh_record` is empty. There are **no Drush commands**
of the module's own — rebuild is via the form, cron, or the helper functions above.

## 4. Harvest / test the verbs

`verb` is required; accepted: `Identify`, `ListMetadataFormats`, `ListSets`,
`ListIdentifiers`, `ListRecords`, `GetRecord`. Common params: `metadataPrefix` (required for
record/identifier listing and `GetRecord`), `set`, `from`, `until` (datestamps filter on the
record `changed` time), `resumptionToken`, and `identifier` (`oai:{host}:{entity_type}-{id}`).

```bash
curl 'https://SITE/oai/request?verb=Identify'
curl 'https://SITE/oai/request?verb=ListMetadataFormats'
curl 'https://SITE/oai/request?verb=ListSets'
curl 'https://SITE/oai/request?verb=ListRecords&metadataPrefix=oai_dc'
curl 'https://SITE/oai/request?verb=ListRecords&metadataPrefix=oai_dc&set=my_view:entity_reference_1'
curl 'https://SITE/oai/request?verb=GetRecord&metadataPrefix=oai_dc&identifier=oai:SITE:node-1'
```

Responses are XML (`oai_dc` encoder). Bad/missing `verb` → `badVerb`; missing/invalid
`metadataPrefix` → `badArgument` / `cannotDisseminateFormat`; unknown id → `idDoesNotExist`;
expired/invalid token → `badResumptionToken`; `set` when sets are unsupported → `noSetHierarchy`.
Responses are deliberately **uncacheable** (`max-age=0`, page-cache kill switch) because access
is evaluated per request.

## Access model (important)

Indexing stores whatever the selected Views return, but every response re-checks
`entity->access('view')` (in `loadEntity()`) **and** per-field `fieldItemList->access()` (in the
map plugins) as the requesting user. So an anonymous harvester only ever sees content anonymous
can view; unpublished/permission-gated entities present in an indexed View are filtered out at
harvest time, not leaked.

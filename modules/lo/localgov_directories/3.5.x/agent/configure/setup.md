<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up a directory

## Install

```bash
composer require drupal/localgov_directories
# Core module + a search backend + at least one entry type:
drush en localgov_directories localgov_directories_db localgov_directories_page -y
drush cr
```

`localgov_directories` alone gives you channels and facets but **no search backend and no entry
types** — a channel page will be empty. Pick one backend:

- `localgov_directories_db` — ships the Search API **database** server and index config. Easiest.
- Solr (or another backend) — **disable `localgov_directories_db` first**, then point the
  `localgov_directories_index_default` index at your own server.

## 1. Create facet types and values

Facet *types* are config (`localgov_directories_facets_type`); facet *values* are content
(`localgov_directories_facets`) and are deliberately excluded from config export so editors can
manage them in production.

- Types: `/admin/config/…` → *Directory Facets types*
  (`entity.localgov_directories_facets_type.collection`, permission
  `administer directory facets types`).
- Values: `/admin/content/directories/facets` (add form
  `/admin/content/directories/facets/add/{type}`).

```bash
# A facet type, then two values.
drush php:eval '
\Drupal::entityTypeManager()->getStorage("localgov_directories_facets_type")
  ->create(["id" => "size", "label" => "Size"])->save();
foreach (["Large", "Small"] as $i => $label) {
  \Drupal::entityTypeManager()->getStorage("localgov_directories_facets")
    ->create(["bundle" => "size", "title" => $label, "weight" => $i])->save();
}'
```

Adding a facet type automatically makes it available on channels and adds its values to the facet
block — `hook_facets_facet_insert()` and `hook_field_config_insert()` do the wiring.

## 2. Create a channel

A channel is a `localgov_directory` node:

| Field | Purpose |
|---|---|
| `localgov_directory_channel_types` | Which entry bundles may be posted into this channel |
| `localgov_directory_facets_enable` | Which facet types are active on this channel |

```bash
drush php:eval '
\Drupal\node\Entity\Node::create([
  "type" => "localgov_directory",
  "title" => "Community venues",
  "localgov_directory_channel_types" => ["localgov_directories_venue"],
])->save();'
```

Visiting the channel node renders the `localgov_directory_channel` view (display `node_embed`),
plus the map display when location is enabled.

## 3. Create entries

Any node bundle with the `localgov_directory_channels` field is an entry. Submodules ship ready
bundles; to convert an existing content type, add that field to it and add the bundle to a
channel's allowed types:

```bash
# Give an existing bundle the channel reference + facet select fields.
drush php:eval '
\Drupal\field\Entity\FieldConfig::create([
  "field_name" => "localgov_directory_channels",
  "entity_type" => "node",
  "bundle" => "my_bundle",
  "label" => "Directory channels",
])->save();'
drush cr
```

Entries pick facet values in `localgov_directory_facets_select`; the module maintains the indexed
`localgov_directory_facets_filter` field from that selection.

## 4. Index and verify

```bash
drush search-api:status
drush search-api:index localgov_directories_index_default
drush search-api:list        # confirm the server the index is attached to
```

Then load the channel node — entries should appear with facet blocks in the sidebar.

## 5. Blocks

`config/optional/` ships block placements (LocalGov Base and the Scarfolk demo theme):

| Block | Purpose |
|---|---|
| `localgov_directories_channel_search_block` | Keyword search within the current channel (`ChannelSearchBlock`, requires a `node` context) |
| `localgov_directories_facets` | The facet filter block |
| `localgov_directories_facets_proximity_search` | Proximity ("near me") search filters |

On a custom theme these are not placed automatically — add them at `/admin/structure/block` and
restrict visibility to the `localgov_directory` bundle.

## 6. Optional integrations

- **Location / proximity search** — enable `localgov_directories_location` (pulls
  `localgov_geo_address`, `leaflet_views`, `search_api_location`). Adds `localgov_location` and
  `localgov_proximity_search_cfg`, and the proximity display of the channel view.
- **Services navigation** — if `localgov_services_navigation` is installed,
  `hook_modules_installed()` installs the optional `localgov_services_parent` field so directories
  can sit inside the service tree.
- **Pathauto** — `pathauto.pattern.localgov_directory_channel` ships in `config/optional`;
  `hook_pathauto_pattern_alter()` adds the optional service parent into entry paths.
- **Autocomplete** — `search_api_autocomplete.search.localgov_directory_channel`.
- **Open Referral** — `localgov_directories_or` / `_venue_or` (experimental).

## Troubleshooting

| Symptom | Cause |
|---|---|
| Channel page is empty | Index not built (`drush search-api:index`) or no backend module enabled |
| Facets block shows nothing | Facet type not enabled on that channel, or no entries carry values |
| Facets appear but filter nothing | Entries were indexed before facet values were set — reindex |
| Proximity search missing | `localgov_directories_location` not enabled |
| Entry type not selectable on a channel | Bundle lacks `localgov_directory_channels` field |

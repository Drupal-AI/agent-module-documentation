<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Facets Pretty Paths

The module has **no settings form** (`configure: null`). Two config touch-points:

## 1. Switch a facet source to pretty paths

Pretty paths is a Facets **URL processor**. Each facet source picks one URL processor;
the default is `query_string`. To use pretty paths, set the source's `url_processor` to
**`facets_pretty_paths`**.

- Config entity: `facets_facet_source` (config name `facets.facet_source.<id>`).
- Exported property: `url_processor`.
- UI: **Admin → Config → Search → Facets → Facet sources → Edit** (`/admin/config/search/facets`) → "URL Processor" select → *Pretty paths* → Save.

Drush / PHP (set it directly on the config entity):

```php
$fs = \Drupal::entityTypeManager()
  ->getStorage('facets_facet_source')
  ->load('search_api__views_page__search__page_1');   // your source id
$fs->setUrlProcessorName('facets_pretty_paths');       // or ->set('url_processor', 'facets_pretty_paths')
$fs->save();
```

Or purely with config (`drush cset`):

```bash
drush cset facets.facet_source.<source_id> url_processor facets_pretty_paths -y
drush cr
```

Read back which processor a source uses:

```bash
drush cget facets.facet_source.<source_id> url_processor
# → 'facets_pretty_paths'  (or the default 'query_string')
```

A `RouteSubscriber` adds a catch-all `.../{facets_query}` route for each source that uses
this processor, so run `drush cr` after switching so the new route is registered.

## 2. Choose the coder for a facet

Once a source uses pretty paths, each facet's edit form gains a **"Pretty paths coder"**
radio set (only shown when the source's processor is `facets_pretty_paths`). The choice is
stored as a **third-party setting** on the facet, not a top-level field:

- Config path: `facets.facet.<facet_id>.third_party.facets_pretty_paths.coder`
- Default when unset: `default_coder`
- Schema: `facets.facet.*.third_party.facets_pretty_paths` → `coder: string`

Set it programmatically:

```php
$facet = \Drupal::entityTypeManager()->getStorage('facets_facet')->load('color');
$facet->setThirdPartySetting('facets_pretty_paths', 'coder', 'taxonomy_term_coder');
$facet->save();
$coder = $facet->getThirdPartySetting('facets_pretty_paths', 'coder', 'default_coder'); // read
```

Available coder ids and what a segment looks like → see [../plugins/coder.md](../plugins/coder.md).

## Views exposed-filter facets

For facets rendered as **Views exposed filters** (facets_exposed_filters submodule), the
coder is chosen on the filter's config form instead and stored at
`expose.facets_pretty_paths_coder` on the views filter (a `hook_config_schema_info_alter`
adds that key). `0`/unset = "None" (fall back to the default views query string).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories: Open Referral (localgov_directories_or) — agent index

**Experimental** glue submodule of [localgov_directories](../../../../3.5.x/agent/start.md) that maps
directory facets into Open Referral property mappings. No UI, no permissions, no schema, no Drush.

Key facts:
- Package is `LocalGov Drupal (Experimental)`; depends on `localgov_directories` and
  `localgov_openreferral:localgov_openreferral`.
- One service class, `src/FacetMapping.php`, instantiated through `class_resolver`.
  `synchroniseFacetMappings()` reconciles the site's facet types/values with Open Referral
  property mappings.
- Trigger points — all keyed on the **channel** bundle `localgov_directory`:
  - `hook_node_insert()` → synchronise
  - `hook_node_update()` → reset the node storage cache for that node, then synchronise
  - `hook_node_delete()` → synchronise
  Facet *value* changes do not trigger it directly; a channel save does.
- Because synchronisation runs on every channel save, keep an eye on it if a site has many
  channels and does bulk node operations — it is not queued.

Companion: `localgov_directories_venue_or` makes venues Open Referral *services* and backfills an
organisation per venue →
[../localgov_directories_venue_or/3.5.x/agent/start.md](../../../localgov_directories_venue_or/3.5.x/agent/start.md).

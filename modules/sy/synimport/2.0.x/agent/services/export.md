<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynImport — export flow (entities → YAML)

Namespace `Drupal\synimport\Service\Export`. Runs under a trusted operator's Drush session.

## Orchestration — `Export` (`synimport.export`)
`Export::export($dir, $status)` runs taxonomy, node (`node`), product (`commerce_product`) and block (`block`) exports in turn. The per-type methods (`exportTaxonomy/exportNode/exportProducts/exportBlocks`) each delegate to a thin wrapper service (`synimport.export.{taxonomy,node,product,block}`), which all call `CreateYml::createYmls($dir, $bundle, $status)`.

## Main worker — `CreateYml` (extends `CreateYmlBase`)
`createYmls($export_dir, $bundle, $status)`:
1. `checkBundle()` — accepts either an entity-type machine name (exports all its bundles) or a single bundle name; sets `exportingEntityType` + `exportingBundles`.
2. `getEntitiesData()` — builds the query via `CreateYmlBase::initQuery()` (`accessCheck(FALSE)`; adds `status = <status>` unless status is `"0"`; adds `type IN <bundles>` for non-taxonomy) and `loadMultiple()`s the results. On error or empty result it logs and `exit`s.
3. For each entity, `getYml()` → `getEntityYml()` produces the field map, adds `type` (or `vid` for taxonomy) and `uid: 1`, and `createYml()` writes `<export_dir>/<entity_type>/<id>-<entity_type>.yml`.
4. `provideAdditionalExport()` — referenced `commerce_product`, `node`, `taxonomy_term`, `block`, `file` entities discovered during export are exported afterwards into their own type folders.

### Field mapping — `getEntityYml()` + `CreateYmlBase`
- `fieldDefinitions()` iterates `entity_field.manager` field definitions, skipping `bannedFields` (id/uuid/uid/vid/tid/nid/type/path/langcode/created/changed/weight/metatag/stores/… and any name containing `revision`).
- `fieldSettings()` maps each Drupal field type to an export `type`:
  - `entity_reference`/`entity_reference_revisions` → `taxonomy` (taxonomy_term, except `parent` → `related`), `media`, `variations` (commerce_product_variation), `attribute` (commerce_product_attribute_value), `paragraph`, `related` (node/commerce_product), else `equal_text`.
  - `file` → `attach`; `image` → `image`; `commerce_price` → `price`; `text_with_summary` → `formatted_text`; `color_field_type` → `color`; everything else → `equal_text`.
- `addTypeFeatures()` then post-processes per type: taxonomy fields export term **names**; `related` fields export relative paths `"/<type>/<id>-<type>"`; `variations` recurse; `attribute` renames the field to its attribute name; `price` writes `{number, currency_code}`; `formatted_text` writes `{format: wysiwyg, value}`; `color` reads `field_hex`.
- **Files/images** (`attach`, `image`): each referenced file is `copy()`d from `"/var/www/html/" . str_replace('public://','sites/default/files/', $uri)` into `<export_dir>/files/<target_id>-<field>.<ext>`, and the YAML records `content` as `"/files/…"` paths. NOTE the hardcoded `/var/www/html/` docroot prefix — export file copying assumes that path.

## Output structure
```
<export_dir>/
  taxonomy_term/<id>-taxonomy_term.yml
  node/<id>-node.yml
  commerce_product/<id>-commerce_product.yml
  block/<id>-block.yml
  files/<fid>-<field>.<ext>
```
This is the same layout the import side consumes (per-type folders + `files/`; note import's full-run expects `/nodes` and `/products` folder names — see [import.md](import.md)).

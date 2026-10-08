<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynImport — import flow (YAML → entities)

Namespace `Drupal\synimport\Service\Import`. All classes decode YAML with `Drupal\Component\Serialization\Yaml` and run under a trusted operator's Drush session.

## Orchestration — `Import` (`synimport.import`)
`Import::import($dir)` runs, in order, over these subdirectories (each skipped if missing/empty): `/contacts`, `/menu`, `/taxonomy`, `/nodes`, `/products`, `/block`, `/synlanding`. It delegates to the per-type services; each per-type command calls the same service method directly.

- **`importContacts($dir)`** — for each YAML file matching `{body:{format,value}, path}` (validated by `isContactsDocument()`), resolves the node behind the `/contacts` alias (falls back to `/kontakty`) via `path_alias.manager`, then sets its `body` and path `alias` and saves. Only updates an existing node.
- **`setSynlandingFormBg($dir)`** — for each YAML with `{form_bg_path, config_id, …}`: imports the image(s), then writes `config.factory->getEditable($data['config_id'])->set('form_bg', [$fid])`. The config object name comes from the YAML (`config_id`), and adds a `file.usage` record.
- Menu/taxonomy/node/product/block each `scandir()` their folder, `Yaml::decode()` each file, check it decodes to a string-keyed array (`isEntityArray()`), then hand it to `CreateEntity` (menu uses its own `Menu` service).

## Entity building — `CreateEntity` (`synimport.import.create_entity`)
`updateCreateEntity($entity_array, $directory, $file_path)` resolves storage, dedupes against an in-memory `$map` of already-created files, otherwise calls `create()`, then `setRelated()`.

- **Storage resolution `getStorage()`**: uses `entity_type` key if present; else matches `type` (bundle) against `entity_type.bundle.info`; else `vid` (creating the vocabulary if absent); else `attribute`. Errors ("Non-supported entity type", "Empty entity type") are logged, not fatal.
- **`create()`**: seeds `['uid' => 1]`, merges the YAML via `arrayAssembly()`, unsets the entity's `id`/`revision` keys for content entities, then `$storage->create($result)->save()`. NOTE: any YAML key becomes an entity field value, so `uid`, `status`, etc. from the file override the defaults (expected for a trusted CLI import).
- **`afterSave()`** (nodes only): if `path` set → sets the alias with `pathauto` SKIP; if `is_front == true` → sets `system.site:page.front` to `/node/<id>`.
- **`setRelated()`**: fields typed `related` reference other entities by relative path `"/<entity_type>/<id>-<entity_type>"` (`.yml` appended); the referenced file is read from `coreDir . $file_path . '.yml'` and created "only_as_related" if not already present, then the ids are written back onto the parent field.

### Typed field handling — `arrayAssembly()` `type` switch
A field value shaped `{type: <t>, content: <v>}` is transformed; anything else is copied verbatim.

| `type` | Behavior |
|---|---|
| `image` | `Files::importImages()` → file entities, `[target_id]` list |
| `attach` | `Files::importAttach()` → file entities with `description`/`display` |
| `media` | `Files::importMedia()` → creates `file` + `media` (bundle `image`, uid 1) entities, returns media ids |
| `taxonomy` | resolves term id(s) by **name** via `loadByProperties(['name'=>…])` (`getTidByName`); does not create missing terms |
| `paragraph` | recursively `createParagraph()` per item → `{target_id, target_revision_id}` |
| `variations` | creates each variation entity (`commerce_product_variation`) → id list |
| `attribute` | looks up existing `commerce_product_attribute_value` (by `field_hex` for `color`, else `name`) or creates one; stores under `attribute_<key>` |
| other/unknown | uses `content` as a plain value |

## File handling — `Files` (`synimport.import.files`)
- `importFiles()` (images/attach) and `importMedia()`: destination is always `pathinfo($name, PATHINFO_BASENAME)` under `public://import/` (images/attach) or `public://import/media/` (media) — the on-disk write path is the basename only, not a path from the YAML.
- Source: values beginning with `http` are fetched remotely via `@file_get_contents()` (`loadFileContents()`, which records byte counts / response status to the logger); otherwise the file is read from `$this->dir . $name` (the import dir set by `CreateEntity`).
- Saved with `FileSystemInterface::saveData()` — `FileExists::Rename` for files, `FileExists::Replace` for media — then a `file` entity is created (status 1).

## Redis integration — `Redis` (`synimport.import.redis`)
`synimport:redis_import <app_id> <source>` → `Redis::import()`. Used only for the Synapse "visitka-telegram"/brief landing pages. `getRedisData()` fetches JSON from a fixed host per source type — `https://app.biz-panel.com/telegram/redis-data/<app_id>/<token>` (`telegram`) or `https://biz-panel.com/breaf/redis-data/<app_id>/<token>` (`breaf`) — over HTTPS via `file_get_contents`. The `<token>` is computed in the constructor from an internal fixed string plus the current ISO week number (`substr(hash('sha256', …), 0, 10)`); it is **not** read from config, environment, a Key entity, or a settings variable. Given a `nid` in the payload it rebuilds/updates that node's `field_paragraph` tree (about, work_scope, gallery, image_blocks, text_image_plate, text_slider, body, button …); otherwise it creates a new entity from the payload `type`.

## Supported entity types
Nodes, commerce products (+ variations + attribute values), taxonomy terms (+ vocabularies auto-created), menus (`menu` + `menu_link_content`), custom blocks, files, media (image bundle), and paragraphs — plus arbitrary entity types when the YAML carries an explicit `entity_type` key.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `browser_development_storage` config entity

## Definition (`src/Entity/BrowserDevelopmentStorage.php`)

`@ConfigEntityType` id `browser_development_storage`, `config_prefix: browser_development_storage`, `admin_permission = "administer site configuration"`. Extends `ConfigEntityBase` and implements `BrowserDevelopmentStorageInterface`.

- Stored/exported properties (`config_export`): `id`, `label`, `json_obj`.
- `entity_keys`: `id`, `label`, `uuid` (note `json_obj` also appears in the keys array but as a malformed `"json_obj = json_obj"` string — it is a config property, not a real entity key).
- `label` holds the creation timestamp (`Y_m_d__H_i_s`); `id` is `<date>__<random 5 chars>`; `json_obj` holds the `serialize()`d SCSS payload.
- `jsonObj()` returns the raw serialized `json_obj` string.

Schema `config/schema/browser_development_storage.schema.yml` types `browser_development.browser_development_storage.*` as a `config_entity` with `id` (string), `label` (label), `uuid` (string), `json_obj` (string).

## Routes / handlers

`route_provider.html = BrowserDevelopmentStorageHtmlRouteProvider` (a no-op subclass of `AdminHtmlRouteProvider`). Links:

- collection `/admin/browser-development/storage`
- add `/admin/browser-development/storage/add`
- canonical `/admin/browser-development/storage/{browser_development_storage}`
- edit `.../{...}/edit`
- delete `.../{...}/delete`

All generated entity routes inherit `_admin_permission: administer site configuration`. The menu link `entity.browser_development_storage.collection` (`browser_development.links.menu.yml`) points *Structure → Browser development* at `browser_development.home` (not the collection route).

## Forms / list builder

- `BrowserDevelopmentStorageListBuilder` — columns *Date created* (`label`, `__` → spaces) and *Json Object* (raw `jsonObj()`).
- `BrowserDevelopmentStorageForm` (add/edit) — `label` textfield + `machine_name` id (uniqueness via `BrowserDevelopmentStorage::load`). Does **not** expose `json_obj` (that is written only by the API's `Storage::setStorage`).
- `BrowserDevelopmentStorageDeleteForm` — standard `EntityConfirmFormBase` confirm/delete.

## `Processing\Storage` (how snippets are written/read)

- `setStorage($inputArray)` → `storage()` creates a `browser_development_storage` entity with a date-based id/label and `json_obj => serialize($inputArray)`, then `save()`. Called by the API on the `compiled` command.
- `getStorage()` → `loadMultiple()`, then loads `array_key_last(...)` (the most recently created) and returns `unserialize($entity->jsonObj())`; returns `unserialize('{}')` when empty. Called by the API `open` command.
- `returnAllVersions()` → `loadMultiple()`.

Because each save creates a new dated entity, snippets accumulate as separate config entities (effectively a version history); the editor's `open` only ever restores the latest.

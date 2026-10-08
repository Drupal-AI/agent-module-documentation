<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `fallback_entity` config entity

File: `src/Entity/FallbackEntity.php` — class `Drupal\fallback_media\Entity\FallbackEntity extends
ConfigEntityBase implements FallbackEntityInterface`.

## Definition (`@ConfigEntityType`)

- `id = "fallback_entity"`, `config_prefix = "fallback_entity"`.
- `admin_permission = "administer site configuration"` (core permission; the module defines none of its own).
- `entity_keys`: `id`, `label`, `uuid`.
- `config_export`: `id`, `label`, `fallback`, `uuid` — these are what persist to
  `fallback_media.fallback_entity.<id>.yml`.
- Handlers: `view_builder` = core `EntityViewBuilder`; `list_builder` = `FallbackEntityListBuilder`;
  forms `add`/`edit` = `Form\FallbackEntityForm`, `delete` = `Form\FallbackEntityDeleteForm`;
  `route_provider.html` = `FallbackEntityHtmlRouteProvider`.

## Stored fields

- `id` (string) — machine name.
- `label` (label) — human name.
- `fallback` (int) — the **media entity id** this fallback points to. Accessors `getFallback()` /
  `setFallback(int $fallback)` on `FallbackEntityInterface`.
- `uuid` (string).

Schema: `config/schema/fallback_entity.schema.yml` (`type: config_entity`, mapping `id`/`label`/`fallback:int`/`uuid`).

## Routes & permission

`FallbackEntityHtmlRouteProvider` (`src/FallbackEntityHtmlRouteProvider.php`) is an empty subclass of core
`AdminHtmlRouteProvider`, so the standard admin entity routes are generated from the entity `links`:

| Route id | Path | Handler |
|---|---|---|
| `entity.fallback_entity.collection` | `/admin/structure/fallback_entity` | `FallbackEntityListBuilder` |
| `entity.fallback_entity.add_form` | `/admin/structure/fallback_entity/add` | `FallbackEntityForm` |
| `entity.fallback_entity.canonical` | `/admin/structure/fallback_entity/{fallback_entity}` | — |
| `entity.fallback_entity.edit_form` | `/admin/structure/fallback_entity/{fallback_entity}/edit` | `FallbackEntityForm` |
| `entity.fallback_entity.delete_form` | `/admin/structure/fallback_entity/{fallback_entity}/delete` | `FallbackEntityDeleteForm` |

All are admin routes requiring `administer site configuration` (from the entity `admin_permission`). Add/edit are
Form API entity forms and delete extends `EntityConfirmFormBase`, so all mutations are POST with core CSRF and a
confirm step; there is no state-changing GET route.

Menu/action links: `fallback_media.links.menu.yml` places the collection under Structure (*Fallback media*,
weight 99); `fallback_media.links.action.yml` adds *Add Fallback media* on the collection.

## Forms

- `FallbackEntityForm::form()` (`src/Form/FallbackEntityForm.php`): `label` (textfield, required), `fallback`
  (`entity_autocomplete`, `#target_type = media`, required — default loaded via
  `entityTypeManager->getStorage('media')->load($fallback_entity->getFallback())`), `id` (`machine_name`, exists
  callback `FallbackEntity::load`, disabled once created). `save()` writes the entity and redirects to the
  collection with a status message.
- `FallbackEntityDeleteForm` — standard confirm-and-delete, redirects to the collection.

## List builder

`FallbackEntityListBuilder::buildRow()` loads each definition's target media
(`getStorage('media')->load($entity->getFallback())`) and shows its label, or `"Not selected"` when the media
cannot be loaded. Columns: label, machine name, fallback media label.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `cml` entity — exchange record

Content entity that logs one CommerceML/1C exchange. Defined in
`src/Entity/CmlEntity.php` (`@ContentEntityType id = "cml"`), base table `cml`, no bundles.

## Handlers & links

- `list_builder` `CmlEntityListBuilder`, `views_data` `CmlEntityViewsData`,
  `view_builder` core `EntityViewBuilder`.
- Forms: default/add/edit `CmlEntityForm`, delete `CmlEntityDeleteForm`.
- `access` = `CmlEntityAccessControlHandler`; `route_provider.html` = `CmlEntityHtmlRouteProvider`.
- `admin_permission = "administer cml entity entities"`; `field_ui_base_route = "cml.settings"`.
- Links: canonical `/admin/structure/cml/{cml}`, add `/admin/structure/cml/add`, edit `…/edit`,
  delete `…/delete`, collection `/admin/structure/cml`.
- Entity keys: id, label=`name`, uuid, uid=`user_id`, langcode, status.

## Base fields (`baseFieldDefinitions`)

- `user_id` — entity_reference→user, author; defaults to current user in `preCreate()`.
- `name` — string(50), the exchange label.
- `type` — list_string, allowed `catalog`, `sale`.
- `state` — list_string, allowed `zip`, `new`, `progress`, `success`, `busy`, `failure`;
  default `new`. Drives the queue selection in `CmlService`.
- `login` — string(50), "1C Login" of the exchange.
- `ip` — string(50), the 1C client IP.
- `status` — boolean published flag, default TRUE.
- `full` — boolean "Full Exchange", default FALSE (the Scheme page only runs for full exchanges).
- `created` / `changed` — timestamps (EntityChangedTrait).

`field_file` is **not** a base field — it is a configured file field installed via
`config/install/field.storage.cml.field_file.yml` + `field.field.cml.cml.field_file.yml` (multi-
value file reference holding the received XML payloads). Form/view displays are installed too, and
`config/optional/views.view.cml.yml` provides a Views listing.

## Interface (`CmlEntityInterface`)

Getters/setters for name, state, type, created time, owner, published, and `setFull(bool)`.
`CmlEntity` implements typed accessors (`getStringFieldValue()` throws on non-string). Notable:
`getCreatedTime()` throws `UnexpectedValueException` if the stored value is not a timestamp.

## Access control (`CmlEntityAccessControlHandler::checkAccess`)

- `view` published → `view published cml entity entities`; unpublished →
  `view unpublished cml entity entities`.
- `update` → `edit cml entity entities`; `delete` → `delete cml entity entities`.
- create → `add cml entity entities`.
- Unknown operations return `AccessResult::neutral()`.

All 7 permissions are in `cmlapi.permissions.yml`; `administer cml entity entities` is
`restrict access: true`.

## Menu / tasks (`cmlapi.links.*.yml`)

Collection under *Content* (`entity.cml.collection`) and a *CommerceML* item under
*Structure* → `cml.settings`. Local tasks on the canonical route: View, Edit, Delete, plus
Catalog, Products, Variations, Scheme (the four diagnostic routes below).

## Insert hook

`hook_cml_insert` (`cmlapi.module` → `CmlInsert::hook()`) calls
`cmlapi.counter`→`exchangeCounterInStatusNew()`, which — only if the `syncloud` module and
`syncloud.mqtt` service exist and a `syncloud.uuid` state is set — publishes a JSON queue counter
(host, count of `new` exchanges, last file) to MQTT topic `$cmlapi/counter/{uuid}`. No-op
otherwise.

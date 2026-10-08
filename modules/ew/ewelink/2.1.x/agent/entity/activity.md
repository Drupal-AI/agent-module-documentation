<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eWeLink — `ewelink_activity` entity (device-action log)

Content entity that records each device operation. Defined by `Drupal\ewelink\Entity\ewelinkActivity` (annotation `@ContentEntityType id = "ewelink_activity"`).

## Entity definition
- `base_table`: `ewelink_activity`.
- `admin_permission`: `administer ewelink activity entities` (note: this exact string is NOT declared in `ewelink.permissions.yml`; the declared admin-style perm there is `administer activity entities`).
- Implements `EntityOwnerInterface` (uses `EntityOwnerTrait`, `EntityChangedTrait`).
- Handlers: `EntityViewBuilder`; list builder `Drupal\ewelink\Entity\Controller\ewelinkActivityListBuilder`; `views_data` = `EntityViewsData`; add/edit form `Drupal\ewelink\Form\ewelinkActivityForm` (**class not shipped**), delete form `ContentEntityDeleteForm`; access handler `Drupal\ewelink\ewelinkActivityAccessControlHandler`; route provider `AdminHtmlRouteProvider`.
- Links: canonical/add/edit/delete/collection under `/admin/content/ewelink_activity/...`.
- `entity_keys`: id, label=`name`, uuid, uid=`user_id` (plus a non-standard `action` key with no matching field).

## Base fields (`baseFieldDefinitions()`)
- `user_id` — entity_reference → `user` (author/owner).
- `name` — string(255), required (the entity label).
- `event_type` — list_string, required; allowed values: `device_on`, `device_off`, `scene_triggered`, `sync_data`, `custom_event`.
- `related_entity` — entity_reference → `node` (optional).
- `description` — string_long.
- `status` — boolean, default TRUE (labelled "Published").
- `created` — created timestamp; `changed` — changed timestamp.

## Access control
`ewelinkActivityAccessControlHandler::checkAccess()` maps operations to permissions and defaults to `AccessResult::neutral()` (no access) when the permission is absent:
- view → `view activity entities`
- update → `edit activity entities`
- delete → `delete activity entities`
- create → `add activity entities` (also `checkCreateAccess()`)

Permissions declared in `ewelink.permissions.yml`: `access ewelink open-the-door` (restrict access), `administer activity entities` (restrict access), `view activity entities`, `add activity entities`, `edit activity entities`, `delete activity entities`.

Note: there is also an empty stub file `src/ActivityAccessControlHandler.php` and an empty `src/Controller/ewelinkActivityListBuilder.php`; the live classes are `src/ewelinkActivityAccessControlHandler.php` and `src/Controller/ActivityListBuilder.php` (namespaced `Drupal\ewelink\Entity\Controller\ewelinkActivityListBuilder`).

## List builder
`ewelinkActivityListBuilder` (`src/Controller/ActivityListBuilder.php`) renders columns: ID, Name (link), Event Type, User (owner link), Related Entity (or "N/A"), Status (Published/Unpublished), Created (formatted). Empty text: "No activities found."

## Shipped View & menu
- `config/install/views.view.ewelink_activity.yml` — View `ewelink_activity` on base table `ewelink_activity` (depends on modules `ewelink`, `user`, `views` and config `user.role.ewelink_user`).
- Menu link `entity.activity.collection` → route `entity.activity.collection`, under **Content** (`system.admin_content`). (The entity's own collection route is `entity.ewelink_activity.collection`; the menu link references `entity.activity.collection`.)

## Creating a record
`ewelink_activity_record($data)` in `ewelink.module` builds an `ewelinkActivity` with `name = $data['label']`, `event_type = $data['event_type']`, owner = current user, and a `description` composed from the device id, outlet, on/off state and the acting user's account name; `status = TRUE`; then `save()`. It is called from `OpenTheDoor::promptCallback()` after a button press (see [`../routes/pages.md`](../routes/pages.md)). Note the caller passes `$d` without an `event_type` key, so that field is empty in practice.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event (event) — agent index

Defines a first-class **`event` content entity** (fieldable, revisionable, translatable,
publishable) plus an **`event_type` config bundle**, for managing events as their own entity
type instead of nodes. Part of the Conference Organizing Distribution (COD) ecosystem.

- **Version documented:** 2.0.0-rc3 (pre-release). `core_version_requirement: ^10.3 || ^11 || ^12`.
- **Enabled dependency (`event.info.yml`):** `datetime_range` (core) only.
- **Composer-level requires** (not enabled Drupal deps): `drupal/diff`, `drupal/field_permissions`,
  `drupal/entity_embed`, `drupal/entity`, `drupal/entity_browser`, `cweagans/composer-patches`.
  The `composer-patches` entry applies a core patch (issue 2685749) adding a Machine Name widget,
  which the `machine_name` base field's form widget relies on.
- **No submodules.** (v1's `event_group` / `gevent` were split into separate projects.)

## What it provides

- **Entities:** `event` (content, class `Drupal\event\Entity\Event`) and `event_type`
  (config bundle, `Drupal\event\Entity\EventType`).
- **Base fields on `event`:** `name` (string, max 50), `machine_name` (string, unique, regex
  `^[a-z0-9_]+$`), `event_date` (daterange, DATETIME with timezone storage), `user_id` (author),
  `status`, `created`, `changed`, plus revision metadata. A `description` (text_with_summary)
  field is attached per bundle at bundle-create time.
- **Handlers:** storage `EventStorage`, access `EventAccessControlHandler`, list builders,
  translation handler, `EventViewsData`, and route provider `EventHtmlRouteProvider`.
- **Controller:** `EventController` (revision view / revision overview / titles).
- **Forms:** `EventForm`, `EventDeleteForm`, `EventTypeForm`, `EventTypeDeleteForm`,
  `EventSettingsForm` (placeholder), and revision revert/delete forms.
- **Permissions:** 9 event permissions (`event.permissions.yml`).
- **Plugin:** menu-link deriver `Plugin/Derivative/MenuLinks` (only adds toolbar links when
  `admin_toolbar` is installed).
- **Config:** schema `event.type.*`; a `field.storage.event.description` field storage
  (config/install) and an `events_admin` view (config/optional).
- **Theme:** `event` template (`event.html.twig`) + `event_content_add_list`.

## Solution docs

- [Entities & fields](entities/event.md) — the `event` entity, `event_type` bundle, base fields,
  the auto-attached description field, access control, API methods.
- [Routes, links & permissions](routes/routes-and-permissions.md) — link templates, the custom
  route provider, revision routes, permissions, and the events view.
- [Services, hooks & install](api/services-and-hooks.md) — storage, controller, forms, hooks,
  theming, and the `hook_update_N` history.

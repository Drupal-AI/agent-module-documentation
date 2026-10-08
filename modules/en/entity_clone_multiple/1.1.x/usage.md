<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Clone Multiple

Extends entity cloning so an editor can produce several copies of an entity at once, governed by per-entity-type "clone settings" configuration entities.

- Defines an `entity_clone_entity_setting` config entity.
- Provides admin CRUD for those settings.
- Adds a permission-callback-driven set of clone permissions.
- Aimed at time-bounded / batch duplication workflows.

---

# Installing & configuring

- Enable the module (`drush en entity_clone_multiple`).
- Manage clone settings at `/admin/config/content/entity-clone`.
- Add settings at `/admin/config/content/entity-clone/add`.
- General settings at `/admin/config/content/entity-clone/settings`.
- Config-entity CRUD is gated by `administer entity clone settings` (restricted).
- Per-type clone permissions are generated via `EntityCloneMultiplePermissions::entityClonePermissions`.

---

# Usage & behaviour

- The list/add/edit routes require `administer entity clone settings`.
- The delete form uses `_entity_access: entity_clone_entity_setting.delete`.
- The general settings form requires `administer site configuration`.
- Clone settings are stored as configuration entities (exportable).
- A dynamic permission is provided per entity type for cloning.
- Cloning produces multiple copies rather than a single duplicate.
- Copies can be scoped to a period of time per the module's purpose.
- Action/menu/task links are registered for the settings UI.
- No anonymous-facing routes are exposed.
- The restricted permission flag marks admin access as security-relevant.
- Works alongside the broader Entity Clone ecosystem.
- Config schema is provided for the settings entity.
- Uninstalling removes the clone settings config entities.
- Intended for editorial/admin roles, not anonymous users.
- Suitable for campaigns/events needing many short-lived copies.
- All mutation routes are permission-gated.

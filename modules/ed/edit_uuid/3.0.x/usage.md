<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Edit UUID exposes an entity's UUID on its edit form so a permitted user can view or set it — the tool for making UUIDs match across environments when content is deployed or synchronised rather than migrated.

---

Drupal assigns every entity a UUID at creation and treats it as the stable identity used by JSON:API, content deployment tools, default content, and configuration dependencies. That works until the same logical content exists in two places with different UUIDs — content recreated by hand on production, an entity restored from a partial backup, a default-content export whose target already exists — at which point the tools that match on UUID see two different things. This module lets that be corrected. An `edit_uuid_config` configuration entity (managed at `/admin/config/development/edit-uuid-config`) declares, per entity type and bundle, whether the `uuid` field should appear on that bundle's entity form and whether it is editable or view-only (`config_type`). A `hook_form_alter` then turns core's normally-hidden `uuid` element into a visible text field on matching forms, with a validate callback that generates a UUID when the field is left blank, lower-cases the value, checks it with `Uuid::isValid()`, and rejects a duplicate that already exists for that entity type. Three permissions separate administering the module, showing the UUID on a form, and editing it. A companion `edit_uuid` field formatter can print the UUID on an entity's view display (via *Manage display*), shown only to users with the show permission. Requirements are PHP 8.1+ and core `^10 || ^11`; there are no other dependencies.

---

- Align a UUID between staging and production.
- Fix content that was recreated with a new UUID.
- Match an entity to a default-content export.
- Restore identity after a partial backup restore.
- Keep a JSON:API consumer's references valid.
- Set a UUID during a content deployment.
- Show UUIDs on entity forms for debugging.
- Print the UUID on an entity's view display.
- Choose which entity types and bundles expose the field.
- Reconcile two environments' content.
- Repair a broken config-entity dependency.
- Match entities imported from another site.
- Give a migration a stable identifier.
- Diagnose a duplicated entity.
- Recreate an entity with its original identity.
- Make a bundle's UUID view-only with the show-only config option.
- Support a phased content migration.
- Correct a UUID mismatch between systems.
- Populate a custom UUID before a first sync.
- Let a specific role see UUIDs on forms.

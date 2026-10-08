<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Builder Notes (builder_notes) — agent index

**Injects a 'Builder Notes' textarea into config-entity edit forms and stores the text as a third-party setting on the entity.**

- **Version:** 2.1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** field_ui (core)
- **Provides:** no routes, permissions, services, entities, plugins, or Drush commands. Config schema only.
- **Mechanism:** `builder_notes_form_alter()` (in `builder_notes.module`) adds a notes `details`/`textarea` (in the `additional_settings` group) to eight config forms: entity form-display and view-display edit, field config and field storage config, node type, user role, image style, responsive image style. The `#entity_builders` callback `builder_notes_display_entity_builder()` saves the value via `setThirdPartySetting('builder_notes', 'notes', …)`.
- **Storage:** the note is a third-party setting on the config entity itself, so it exports/imports with that config. Read it back with `getThirdPartySetting('builder_notes', 'notes')`. Schema: `config/schema/builder_notes.schema.yml`.
- **Access:** editing a note requires the same permission as the host admin form (Field UI plus the relevant `administer …` permission). No surface of its own.

## Solution docs
- [config/builder-notes-field.md](config/builder-notes-field.md) — form-alter allow-list, entity-builder save path, config schema, how to read notes and how to extend the module to more config entities.

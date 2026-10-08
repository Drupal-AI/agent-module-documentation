<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Notes (entity_notes) — agent index

Attaches free-text **notes** to any content entity type. Defines a `entity_note` content entity and,
for each entity type you opt in, adds a `{entity}/notes` tab that lists that entity's notes (via Views)
and an inline add-note form. Package `Entity Notes`. Depends on core **`views`**. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.x (installed 2.0.2).

## What it actually is

- One content entity type **`entity_note`** (`src/Entity/EntityNote.php`, `@ContentEntityType`):
  base tables `entity_note` / `entity_note_field_data`, publishable, translatable, revisionable-ish
  fields, `admin_permission = "administer entity note entities"`, `field_ui_base_route =
  entity_note.settings`. Fields: required `note` (text_long), `entity_id` (int), `entity_type_id`
  (string), `user_id` (author), `status`, `created`, `changed`.
- A settings form picking **which entity types get notes**, stored in config `entity_notes.settings`
  (key `entity_types`).
- A dynamic route + local-task **tab per opted-in entity type**, built at runtime from that config.
- Six granular **permissions**; a custom entity access handler; a shipped **View** (`entity_notes`).
- No services, no Drush, no hooks (only an `.install` update), no external HTTP, no plugin types it
  defines (it uses a local-task deriver).

## Solution docs

- **The `entity_note` entity — fields, storage, links, access handler, permissions** →
  [entity/entity-note.md](entity/entity-note.md)
- **The per-entity notes tab — dynamic routes, local-task deriver, add-note form, the View** →
  [ui/per-entity-notes.md](ui/per-entity-notes.md)
- **Settings form, config object + schema, admin route** →
  [config/settings.md](config/settings.md)

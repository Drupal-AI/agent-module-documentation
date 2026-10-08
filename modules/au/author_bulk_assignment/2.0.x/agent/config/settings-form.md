<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form — enabling entity types

**Route:** `author_bulk_assignment.settings` → `/admin/config/content/author-bulk-assignment`
(menu link under *Configuration › Content authoring*; `_admin_route: TRUE`).
**Permission:** `administer author bulk assignment settings`.
**Class:** `Drupal\author_bulk_assignment\Form\SettingsForm` (`FormBase`).

## What it does

`buildForm()` renders a single `checkboxes` element ("Entity types") whose options are every
entity type whose definition has a `uid` **or** `owner` key (`isApplicableEntity()` —
`$entity_type->hasKey('uid') || $entity_type->hasKey('owner')`). Currently-selected types come
from config `author_bulk_assignment.settings:types`.

`submitForm()`:

- For each **newly** selected applicable type, creates a core **`Action`** config entity:
  - id: `<entity_type_id>_author_bulk_assignment_action`
  - plugin: `entity:author_bulk_assignment_action:<entity_type_id>`
  - label: `Assign bulk <singular label> to author`
  - type: `<entity_type_id>`
  - Failures are caught (`EntityStorageException`) and reported via messenger.
- Writes the full selected list to `author_bulk_assignment.settings:types`.
- For every applicable type **not** selected, queues its action id and deletes those `Action`
  entities (`action` storage query `id IN (...)` → `loadMultiple` → `delete()`).

Creating the Action config entity is what makes the VBO appear in the "Action" select of the
custom bulk form on listings for that entity type. Removing it withdraws the operation.

## Notes for agents

- The form does not itself add the bulk field to any view — it only manages the Action config
  entities. Core's node admin view (`/admin/content`) already exposes a node bulk form, which
  `hook_views_data_alter()` upgrades to the author-assignment variant; for other entity types the
  listing view must expose a bulk form field for that base table.
- `author_bulk_assignment.settings` is the module's `configure` route.

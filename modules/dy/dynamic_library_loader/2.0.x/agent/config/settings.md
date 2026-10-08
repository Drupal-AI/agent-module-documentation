<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & data model

## Install / enable
`drush en dynamic_library_loader -y`. No dependencies. On install,
`config/install/dynamic_library_loader.settings.yml` is imported. (Note: the shipped
install file contains legacy example JSON of `library: [refs]` shape, not the current
`entries`/`rows` schema; real data is created through the admin form.) If upgrading
from a pre-2.x install, run `drush updb` to execute
`dynamic_library_loader_update_1003()`, which reads the old
`dynamic_library_loader_entry` / `dynamic_library_loader_row` DB tables, writes them
into config as `entries`, and drops the tables.

## Config object: `dynamic_library_loader.settings`
Schema in `config/schema/dynamic_library_loader.schema.yml` (`type: config_object`).
Single key `entries` — a sequence of entry mappings:

- `id` (string) — unique entry ID (generated with `uniqid()` on add).
- `name` (string) — human label for the entry.
- `enabled` (boolean) — if false, none of the entry's rows attach.
- `rows` (sequence) — each row is a mapping:
  - `context_type` (string) — one of `content_type`, `taxonomy_term`,
    `paragraph_type`, `paragraph_id`, `view`, `block_type`, `node_id`.
  - `context` (string) — the machine name / ID the type matches against
    (a bundle machine name, a view id or `view_id:display_id`, or a
    comma-separated list of numeric IDs for `node_id` / `paragraph_id`).
  - `theme` (string) — the extension (theme or module) that defines the library.
  - `library` (string) — the library name; attached as `"{theme}/{library}"`.

## Routes (`dynamic_library_loader.routing.yml`)
All require `_permission: 'administer site configuration'`.
- `dynamic_library_loader.list_entries` — `/admin/config/development/dynamic-library-loader`
  → `Form\DynamicLibraryLoaderListForm`.
- `dynamic_library_loader.edit_entry` —
  `/admin/config/development/dynamic-library-loader/{entry_id}/edit`
  → `Form\DynamicLibraryLoaderEntryForm`.
- `dynamic_library_loader.delete_entry` —
  `/admin/config/development/dynamic-library-loader/delete/{entry_id}`
  → `Controller\DynamicLibraryLoaderController::delete()` (redirects back to the list).

Menu link `dynamic_library_loader.list_entries` (`.links.menu.yml`) sits under
`system.admin_config_development` (Configuration > Development).

## Forms
- **List form** (`DynamicLibraryLoaderListForm`): lists entries sorted by name with
  Enabled/Disabled status and Edit/Delete operations; the **Add Entry** button
  (`addEntry`) creates a new entry with a `uniqid()` id and redirects to its edit form.
- **Entry form** (`DynamicLibraryLoaderEntryForm`): requires an `{entry_id}` (throws
  `InvalidArgumentException` if missing). Fields: Entry Name, Enabled, and an
  AJAX-managed `rows` table (Add Row / Remove per row). The `context_type` column is a
  select of the seven context types; `context`/`theme`/`library` are text fields
  (machine names). Submit handlers: `saveAndContinue` (save + rebuild),
  `saveAndRedirect` (save + back to list), `deleteEntry`. `saveEntry()` drops any row
  missing one of the four fields before writing config. `submitForm()` is a no-op
  (real work is in the named handlers).

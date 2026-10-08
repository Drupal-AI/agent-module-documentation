<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Migration imports, exports, and clones **MenuLinkContent** menu hierarchies between Drupal sites (or between menus on one site) through a plugin-based system of export destinations, import sources, and serialization formats.

---

The module treats a menu's manually-created `menu_link_content` links as a tree it can serialize and move around. Reusable **Menu Export** (`mm_export_type`) and **Menu Import** (`mm_import_type`) config entities each pick a plugin — an **Export Destination** (`codebase`, `download`, `another_menu`) or **Import Source** (`codebase`, `file_upload`) — a **Format** (`json`, `yaml`, `raw`), and a set of menus. Exports write the tree to a file in the codebase, stream a download, or clone links into another menu; imports read that file back and rebuild the links. All of this is driven from an admin UI at *Configuration → Development → Menu Migration*, or from seven Drush commands. Beyond the configured entities, **Quick Action** Drush commands (`mmqe`/`mmqi`/`mmqc`) export/import/clone menus straight by menu ID without creating a config entity, honoring a global format + directory set on the Quick Action Settings form. Only `MenuLinkContent` links are handled — Views, taxonomy-menu, and other dynamic links are ignored. Destinations, sources, and formats are all extensible via attribute-based plugins (`#[MenuMigrationDestination]`, `#[MenuMigrationSource]`, `#[MenuMigrationFormat]`), and a `MenuImportEvent` lets other modules rewrite each item as it is imported.

---

- Export the main navigation menu to a JSON file committed in the codebase and import it on another environment.
- Move a hand-built footer menu from a staging site to production without re-creating links by hand.
- Clone all links from `main` into a new `main_backup` menu before restructuring navigation.
- Duplicate a menu into a freshly created target menu with `drush mmqc main new_menu --create-target`.
- Provide editors a downloadable YAML snapshot of a menu they can archive or share.
- Quickly export several menus at once: `drush mmqe main,footer,account`.
- Re-import a menu from an uploaded file through the admin UI after an accidental deletion.
- Seed a new multisite instance's menus from checked-in export files during deployment.
- Keep menu structures under version control by exporting to the `codebase` destination path.
- Migrate menus as part of a larger site rebuild where menu_link_content links must be preserved.
- Standardize navigation across many sites by importing one canonical menu export file.
- Override the export/import format per run with `--format=yaml` or `--format=json` on the quick commands.
- Batch-export via a configured Menu Export entity that Drush can trigger by ID (`drush mme my_export`).
- List all Drush-capable exports/imports with `drush mmel` / `drush mmil` for CI scripting.
- Rebuild a menu on import (existing links for that menu are cleared first, then regenerated from the source).
- Add a custom export destination (e.g. push to an API) by writing a `MenuMigrationDestination` plugin.
- Add a custom import source (e.g. pull from remote storage) by writing a `MenuMigrationSource` plugin.
- Add a custom serialization format (e.g. XML) by writing a `MenuMigrationFormat` plugin.
- Rewrite menu-item link URIs during import via a `MenuImportEvent` subscriber (e.g. domain swap).
- Restrict who can create/run exports and imports using the module's five permissions.
- Give a role permission to run existing exports but not edit them (`perform export on menu migrations`).
- Configure a shared quick-export directory and default format once on the Quick Action Settings page.
- Preserve menu link hierarchy (parents/children) and per-item translations across the migration.
- Reorder Menu Export / Menu Import entities by drag-and-drop to control their listing weight.
- Automate nightly menu snapshots by scheduling `drush mmqe` in cron.

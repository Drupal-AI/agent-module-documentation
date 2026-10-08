Migrate Default Content imports content into a site from YAML files stored in a `default_content` directory of the project, by auto-generating Migrate API migrations from those files. It is a code-first way to ship seed/fixture/default content with a module or install profile.

---

The module scans a source directory (default `../default_content`, i.e. a `default_content` folder beside the Drupal root) for files named `ENTITY_TYPE.BUNDLE.yml` (e.g. `node.article.yml`, `user.user.yml`, `taxonomy_term.tags.yml`). For each file it generates a Migrate migration on the fly via `hook_migration_plugins_alter()`, using the `yaml` source plugin (from `migrate_source_yaml`). Each YAML file is a list of entities; the first key of each record is the migration's identifier (used for entity-reference lookups). It supports entity-reference and reference-revision fields (looked up by identifier across other files), file migrations (files placed in a `default_content/files` directory copied to `public://`), menu links, multi-component fields (formatted text via `bodyValue`/`bodyFormat`/`bodySummary` camelCase or nested `body: {value, format, summary}`), translations (`ENTITY_TYPE.BUNDLE.LANGCODE.yml` with a `translation_origin` key), and automatic password hashing for password-type fields. All generated migrations are tagged `migrate_default_content` and grouped by entity type, so you run them with standard `drush migrate:import` commands. Settings (`source_dir`, `migration_override_dir`, `migration_export_dir`) live in `migrate_default_content.settings` and are editable at `/admin/config/system/migrate-default-content/settings`. The optional **Migrate Default Content Export** submodule adds a Drush command to generate these YAML files from existing site content. Content is authored by developers as files in the codebase — it is a deployment/build tool, not a runtime user-facing feature.

---

- Ship default/seed content (pages, articles, terms, menus) inside a custom module or install profile.
- Provide demo or fixture content for a distribution so a fresh install is not empty.
- Populate a site with test content from version-controlled YAML instead of a database dump.
- Import a taxonomy vocabulary's terms from a `taxonomy_term.tags.yml` file.
- Create default users/roles from `user.user.yml` with automatically hashed passwords.
- Seed a main menu from `menu_link_content.menu_link_content.yml` with internal and external links.
- Import nodes that reference authors by name/UUID, resolving the reference to a migrated user.
- Attach images to nodes by dropping files in `default_content/files` and referencing the filename.
- Import formatted body text with an explicit text format using `bodyValue`/`bodyFormat`/`bodySummary`.
- Import content in nested-field form (`body: {value, format, summary}`).
- Import translated content via `node.article.es.yml` with a `translation_origin` mapping.
- Import paragraphs and reference them from a host entity via entity-reference-revision fields.
- Keep content migrations idempotent and re-runnable through the Migrate API (`drush migrate:import`).
- Run only one entity type's migrations by using the per-entity-type migration group.
- Roll back imported default content with `drush migrate:rollback`.
- Point the module at a custom content directory by changing `source_dir` in config.
- Override a generated migration by placing a partial definition in the override directory.
- Export existing site content back to YAML fixtures using the export submodule's Drush command.
- Regenerate fixtures after editing content in the UI, then commit the YAML to the repo.
- Provide custom file migrations (with UUID/source URL) via a `file.file.yml` file.
- Add a custom source format (beyond YAML) by implementing a `Source` plugin.
- Bootstrap content for automated/functional tests in a repeatable way.

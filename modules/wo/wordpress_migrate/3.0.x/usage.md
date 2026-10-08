WordPress Migrate generates a set of Migrate configuration entities from a WordPress WXR (XML) export file, so posts, pages, authors, categories, tags, comments, and attachments can be imported into Drupal and then run/rolled back with Migrate Tools.

---

Given a WXR export file and a few options, the module's generator (`WordPressMigrationGenerator`, service `wordpress_migration_generator_factory`) creates a `migration_group` plus `migration` config entities — `wordpress_authors`, `wordpress_categories`, `wordpress_tags`, `wordpress_content_post`/`_page`, `wordpress_comment`, and `wordpress_attachments` — all sourced from the same XML via migrate_plus's `url`/`xml` source. You drive it three ways: the **UI wizard** (submodule `wordpress_migrate_ui`, a Ctools multi-step form at `/admin/structure/migrate/wordpress_migrate`, reached from a button on the Migrate Tools group list), the **Drush command** `wordpress_migrate:generate <file_uri>` with matching options, or **programmatically** by passing a config array to `createGenerator()->createMigrations()`. Options let you set the migration group id and prefix, base URL, a default author (or import WP users, created active), the target node bundles and text formats for posts/pages, tag/category vocabularies, and an image field for attachments/thumbnails. Once generated, you execute the migrations with Migrate Tools (`drush migrate:import <id>`). A structured logging layer (`MigrateLogger`, `ThresholdLogger`, config keys `wp_migrate_logging_level` / `wp_migrate_drush_logging_level` in `wordpress_migrate.settings`) gates verbosity, and a pre-flight `MigrationConfigValidator` blocks generation on invalid config. This release ships one process plugin, `wordpress_migrate_log_term` (`src/Plugin/migrate/process/LogTerm.php`); the additional row-diagnostic plugins described in `docs/processing-plugins.md` are documented-but-not-all-implemented (the doc itself flags "Not everything is yet implemented"). Depends on migrate_plus and pathauto; migrate_tools is required to run the generated migrations. Version 3.0 is an alpha.

---

- Import an entire WordPress blog (posts, pages, authors, categories, tags, comments) from a WXR file.
- Generate ready-to-run Migrate config entities instead of hand-writing migration YAML.
- Set up the import through a guided UI wizard (Add import from WordPress).
- Set up the import from the command line with `drush wordpress_migrate:generate`.
- Configure the import programmatically via the generator service and a config array.
- Map WordPress posts to a chosen Drupal node bundle (e.g. `article`) and text format.
- Map WordPress pages to a different bundle (e.g. `page`) and text format.
- Import WordPress authors as Drupal users (created active) or assign all content to one default author.
- Import WordPress categories into a chosen taxonomy vocabulary.
- Import WordPress tags into a chosen taxonomy vocabulary.
- Import comments attached to posts.
- Import attached images / featured images (thumbnails) into a configured image field.
- Rewrite attachment source domains for staging/mirror hosts (attachment replacement domain option).
- Namespace multiple imports with a migration group id and prefix so several blogs coexist.
- Generate permalinks to imported nodes by supplying the original WordPress base URL.
- Run, check status of, roll back, and re-run each generated migration with Migrate Tools.
- Control migration log verbosity (errors-only in production, debug when troubleshooting) via config.
- Filter migration diagnostics on the dedicated `wordpress_migrate` watchdog channel.
- Validate configuration before generation with the built-in pre-flight validator.
- Add the `wordpress_migrate_log_term` process plugin to a taxonomy pipeline to debug term rows.
- Uninstall the module and delete its data once the migration is complete (it need not stay enabled).
- Review imported users and content for security after import (WP content may contain unsanitized markup).

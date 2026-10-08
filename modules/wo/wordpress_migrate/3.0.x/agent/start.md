# WordPress Migrate — agent index

Generates Migrate config entities from a WordPress WXR (XML) export, then you run them with Migrate
Tools. Depends on `migrate_plus` + `pathauto` (`migrate_tools` needed to execute). No config UI in this
module (`configure` null — the wizard lives in the `wordpress_migrate_ui` submodule). Version 3.0.x is
alpha. PHP >= 8.2.

- **Generate migrations: the config array / options, the generated migrations, the generator service** →
  [api/generator.md](api/generator.md)
- **Drush `wordpress_migrate:generate` command and options** → [drush/commands.md](drush/commands.md)
- **Logging system, thresholds, validator, and the `wordpress_migrate_log_term` process plugin** →
  [configure/logging.md](configure/logging.md)

Submodule:
- `wordpress_migrate_ui` (the wizard UI) → [../../modules/wordpress_migrate_ui/3.0.x/agent/start.md](../../modules/wordpress_migrate_ui/3.0.x/agent/start.md)

Key facts:
- Generator: `WordPressMigrationGenerator` via factory service `wordpress_migration_generator_factory`.
- Creates a `migration_group` + `wordpress_authors/categories/tags/content_post/content_page/comment/attachments`.
- Sourced from XML through migrate_plus (`url` source, `xml` data parser).
- Config object `wordpress_migrate.settings` (logging levels + `defaults` for the wizard/CLI defaults).
- Imported WordPress content may contain unsanitized markup/JS — an operator-review responsibility
  (README "Security Note"); text format per bundle is admin-chosen.

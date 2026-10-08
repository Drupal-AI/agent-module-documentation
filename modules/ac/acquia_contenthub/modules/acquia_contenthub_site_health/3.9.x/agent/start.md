# acquia_contenthub_site_health — agent start

**Experimental** submodule of **acquia_contenthub**. Audits for known incompatibilities between
Drupal and Content Hub. In this release it ships exactly **one Drush command** that repairs
configuration entities whose `uuid` is `NULL` (which break syndication) by assigning them freshly
generated UUIDs. Depends on `acquia_contenthub`. No routes, permissions, config, or plugin types.

- **The Drush repair command (publisher-only), aliases, exact behavior** → [drush/commands.md](drush/commands.md)

Key facts:
- Drush service `acquia_contenthub_site_health.commands` = `AcquiaContentHubConfigNullUuidsFix`.
- Command `acquia:contenthub-fix-config-entities-with-null-uuids` (alias `ach-fix-null-uuids`).
- Refuses to run unless `acquia_contenthub_publisher` is enabled (it throws — "should only be run
  on a publisher site").
- `.module` provides `hook_help` only.

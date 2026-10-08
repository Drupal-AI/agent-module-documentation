# Migrate URL2Link — agent index

Glue module for the migrate framework: converts the **Drupal 7 contrib URL field** to the core **Link**
field during a D7→D8+ upgrade. No UI, no config, no permissions, no Drush. Depends on `link`,
`migrate`, `migrate_plus`. Enable it before running the standard Migrate Drupal upgrade; conversion is
automatic.

- **The `UrlField` migrate-field plugin and the migration-state file** →
  [plugins/url-field.md](plugins/url-field.md)

Key facts:
- Plugin `UrlField` (`id = field_url`, `core = {7}`): type map `url → link`, `source_module = url`,
  `destination_module = link`.
- Formatter map: `url_default`, `url_plain` → `link`. Widget map: `url_external` → `link_default`.
- State file marks D7 module `url` as `finished → link` (upgrade audit treats it as handled).

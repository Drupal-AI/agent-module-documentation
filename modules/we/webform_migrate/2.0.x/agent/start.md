# Webform Migrate — agent index

Migrate API source plugins + migration definitions that move **Drupal 6/7 webforms and
submissions** into the Drupal 9+ Webform module. No admin UI, no `configure` route, no
permissions, no config schema, no Drush of its own. Depends on `webform` + `webform_node`.
You run it through the normal Migrate tooling (migrate_drupal upgrade, or
migrate_plus/migrate_tools against a configured legacy source database).

- **The four source plugins + four migration definitions, field mappings, destinations,
  and how to run/reuse them** → [plugins/migrate-sources.md](plugins/migrate-sources.md)
- **The two element-markup alter hooks for customizing the generated Webform YAML** →
  [hooks/element-alter.md](hooks/element-alter.md)

Key facts:
- Source plugin ids (= migration ids): `d6_webform`, `d7_webform`, `d6_webform_submission`,
  `d7_webform_submission`. Each source extends `DrupalSqlBase` (`source_module: webform`).
- Destinations: `entity:webform` (forms), `entity:webform_submission` (submissions;
  depends on the webform migration).
- Upgrade-path registration: `migrations/state/webform_migrate.migrate_drupal.yml`.

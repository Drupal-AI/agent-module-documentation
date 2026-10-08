# The UrlField migrate-field plugin

`src/Plugin/migrate/field/d7/UrlField.php` — a `MigrateField` plugin extending
`migrate_drupal`'s `FieldPluginBase`. It teaches the D7→D8+ migration how to convert the Drupal 7
contrib **URL** field into the core **Link** field.

## Plugin definition (attributes)

```php
@MigrateField(
  id = "field_url",
  core = {7},
  type_map = { "url" = "link" },
  source_module = "url",
  destination_module = "link",
)
```

- `type_map` — D7 field type `url` becomes D8+ `link`.
- `source_module` / `destination_module` — declares provenance so migrate wires the plugin only for D7
  `url` fields and requires `link` on the destination.

## Maps

| Method | Mapping |
|---|---|
| `getFieldFormatterMap()` | `url_default → link`, `url_plain → link` |
| `getFieldWidgetMap()` | `url_external → link_default` |

Everything else (value processing, cardinality, instances) is inherited from `FieldPluginBase`.

## Migration-state file

`migrations/state/migrate_url2link.migrate_drupal.yml`:

```yaml
finished:
  7:
    url: link
```

This tells Migrate Drupal that the D7 `url` module is fully handled (mapped to `link`), so the upgrade
readiness/audit report lists it as upgraded instead of "will not be upgraded".

## Usage

No commands are added. Enable `migrate_url2link` before running the normal Drupal-to-Drupal migration
(Migrate Drupal UI, or a `migrate_plus` config + `drush migrate:import`); the plugin is discovered
automatically and D7 URL fields convert to core Link fields.

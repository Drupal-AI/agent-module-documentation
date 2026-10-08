# Migrate Source YAML — the `yaml` source plugin

Class: `\Drupal\migrate_source_yaml\Plugin\migrate\source\Yaml`, annotated
`@MigrateSource(id = "yaml")`, extends core `SourcePluginBase`. This is the module's only code.

## Source settings (under `source:` in a migration)

| Key | Required | Meaning |
|---|---|---|
| `plugin` | yes | Must be `yaml`. |
| `file` | **yes** | Path to the YAML file. Passed straight to `file_get_contents()`, so an absolute path or a resolvable relative/stream path. Missing → `MigrateException("You must declare the \"file\" ...")`. |
| `ids` | **yes** | Unique-key definition: map of source-key field → `{ type: ... }`. Returned by `getIds()`; used by migrate for map/tracking/rollback. Missing → `MigrateException("You must declare \"ids\" ...")`. |
| `fields` | no | Map of field machine name → human description. Returned by `fields()`; purely documentational (shows in the migrate UI). Defaults to `[]`. |

## Required YAML file shape
The whole file is `\Symfony\Component\Yaml\Yaml::parse(file_get_contents($file))` and wrapped in
an `\ArrayIterator`, so the **top level must be a sequence (list)**, each element a mapping of
field name → value:

```yaml
# articles.yml
- id: 1
  title: 'First article'
  body: 'Hello world'
- id: 2
  title: 'Second article'
  body: 'More text'
```

Each list item becomes one migrate source row; keys (`id`, `title`, `body`) are the source field
names you map in `process`. Nested arrays are allowed per row (feed them to sub-process plugins).
A parse error is logged to the `Migrate source Yaml` channel and results in **zero rows** (no
fatal).

## Full migration example (`migrate_plus.migration.*` config entity)
```yaml
id: article_yaml_import
label: 'Import articles from YAML'
source:
  plugin: yaml
  file: /var/www/html/articles.yml
  ids:
    id:
      type: integer
  fields:
    id:
      title: 'Row id'
    title:
      title: 'Article title'
process:
  title: title
  body/value: body
destination:
  plugin: 'entity:node'
  default_bundle: article
migration_dependencies: {  }
```
Run with `drush migrate:import article_yaml_import` (and `drush migrate:rollback` /
`migrate:status` from migrate_tools). The plugin also works in a module's
`migrations/<id>.yml` — the source section is identical.

## Notes / gotchas
- Parsing happens **once at construct time**, entirely in memory — not suited to very large files.
- `ids` must match real keys present in every row so migrate can build its map table.
- There is no `keys`/`header`/`path` option like CSV/JSON sources — just `file`, `ids`, `fields`.
- Nothing to enable beyond the module; no service or plugin type to implement.

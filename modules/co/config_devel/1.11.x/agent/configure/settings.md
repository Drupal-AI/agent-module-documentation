# Config Devel settings — auto-import / auto-export

Config object: **`config_devel.settings`** (config UI at
`/admin/config/development/config_devel`, route `config_devel.settings`, permission
`import configuration`). Baseline value: both lists empty.

```yaml
auto_import: []   # sequence of { filename: <path relative to Drupal root>, hash: <sha256> }
auto_export: []   # sequence of config object names (strings)
```

## auto_import

Each entry is a mapping with `filename` (a path **relative to the Drupal root**, e.g.
`modules/custom/mymod/config/install/node.type.article.yml`) and a `hash`. At the start of
every request, `ConfigDevelAutoImportSubscriber` re-reads each file; when its hash differs
from the stored one, the file is imported into active storage (same effect as core's *Single
import*), and the new hash is written back. Set `hash` to `''` to force an import on the next
request. The settings form stores whatever you type with an empty hash.

**Rejected filenames:** the form refuses `system.site`, `core.extension`, and
`simpletest.settings` (validated on the file's basename) — these are not compatible.

## auto_export

A plain sequence of config object **names** (not file paths), e.g. `system.site`. When one of
these objects is saved through the admin UI, `ConfigDevelAutoExportSubscriber` writes its
current value back out. (The target file(s) come from the export wiring; the UI form takes a
newline-separated list of names.)

## Editing the config directly

The settings form splits its textareas on newlines. To script it, write the structured value:

```php
\Drupal::configFactory()->getEditable('config_devel.settings')
  ->set('auto_import', [['filename' => 'modules/custom/mymod/config/install/foo.bar.yml', 'hash' => '']])
  ->set('auto_export', ['system.site'])
  ->save();
```

Read it back:

```bash
drush cget config_devel.settings auto_export
drush cget config_devel.settings auto_import
```

## Config schema

`config/schema/config_devel.schema.yml` defines `config_devel.settings` (the two sequences
above) and a throwaway `config_devel.test` object (single `label` string) used by tests.

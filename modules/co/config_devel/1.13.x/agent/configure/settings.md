# Config Devel settings — auto-import / auto-export

Config object: **`config_devel.settings`** (config UI at
`/admin/config/development/config_devel`, route `config_devel.settings`, permission
`import configuration`). Baseline value: both lists empty.

```yaml
auto_import: []   # sequence of { filename: <path relative to Drupal root>, hash: <sha256> }
auto_export: []   # sequence of file-path strings (same path form as auto_import)
```

## auto_import

Each entry is a mapping with `filename` (a path **relative to the Drupal root**, e.g.
`modules/custom/mymod/config/install/node.type.article.yml`) and a `hash`. At the start of
every request, `ConfigDevelAutoImportSubscriber::autoImportConfig()` re-reads each file; when
its hash differs from the stored one, the file is imported into active storage (same effect as
core's *Single import*), and the new hash is written back. The settings form stores whatever
you type with an empty hash.

Note the subscriber's `importOne()` only computes the stored hash when a non-empty
`original_hash` is passed in, so an entry saved with an empty hash is re-imported on every
request until a hash gets stored — in practice the file is applied each request, which is the
intended "pick up my edits" dev behavior.

**Rejected filenames:** the form refuses `system.site`, `core.extension`, and
`simpletest.settings` (validated on the file's basename) — these are not compatible.

## auto_export

A plain sequence of **file-path strings** (not bare config object names), in the same path
form as `auto_import` — the form's own help text says "a path relative to the Drupal root and
a filename in the same form as a config YML file", e.g.
`modules/custom/mymod/config/install/system.site.yml`. When any config object is saved or
renamed, `ConfigDevelAutoExportSubscriber` filters this list to the entries whose basename
(minus `.yml`) equals the saved object's name and writes the object's current value out to
each of those files. Listing the same object's name under several file paths exports it to all
of them.

## Editing the config directly

The settings form splits its textareas on newlines. To script it, write the structured value:

```php
\Drupal::configFactory()->getEditable('config_devel.settings')
  ->set('auto_import', [['filename' => 'modules/custom/mymod/config/install/foo.bar.yml', 'hash' => '']])
  ->set('auto_export', ['modules/custom/mymod/config/install/system.site.yml'])
  ->save();
```

Read it back:

```bash
drush cget config_devel.settings auto_export
drush cget config_devel.settings auto_import
```

## Config schema

`config/schema/config_devel.schema.yml` defines `config_devel.settings` (`auto_import` as a
sequence of `{filename, hash}` mappings, `auto_export` as a sequence of strings) and a
throwaway `config_devel.test` object (single `label`) used by tests.

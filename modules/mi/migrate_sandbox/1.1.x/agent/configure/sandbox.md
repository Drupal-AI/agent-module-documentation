<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Migrate Sandbox form

There is no traditional "settings" page — the single route **is** the tool.

- Route: `migrate_sandbox.settings_form` → `/admin/config/development/migrate-sandbox`
  (menu link under `system.admin_config_development`, weight 10).
- Form: `Drupal\migrate_sandbox\Form\MigrateSandboxForm` (extends `ConfigFormBase`,
  id `migrate_sandbox_settings`).
- Access: permission `access migrate_sandbox` (see permissions/permissions.md).
- Attaches library `migrate_sandbox/migrate_sandbox`. Fields marked
  `data-yaml-editor="true"` become nicer editors if the `yaml_editor` module is enabled.

## The form fields

You edit three YAML blobs plus a destination choice:

| Field (textarea) | Meaning |
| --- | --- |
| `data_rows` | ONE source row (a YAML mapping of source properties). Only one row is allowed. |
| `constants` | Optional `constants` for the embedded source. |
| `process` | The `process:` pipeline mapping (destination property → plugin config / plugin chain). |
| `destination` (radios) | `config` → destination `migrate_sandbox_config`; `entity` → destination `migrate_sandbox_entity:<entity_type>`. |
| `entity_type` / `entity_bundle` | Only used when `destination = entity`. |

Submit button is labelled **"Process Row"** and runs via AJAX (`::ajaxSubmit`), rendering the
result into the "Results" fieldset as YAML or `print_r` array.

## What happens when you click "Process Row" (`ajaxSubmit`)

1. `validateForm()` first `Yaml::decode()`s `data_rows`, `constants`, and `process`; a parse
   error is shown inline as a "(Yaml Validation)" form error.
2. On success `ajaxSubmit()` assembles a full migration definition and saves it to config
   object **`migrate_sandbox.latest`** (`setData([...])->save()`):
   - source = `embedded_data` plugin, with your one decoded row + an injected id
     `migrate_sandbox_dummy_source_id => '123'`, your `constants`, and
     `ids: {migrate_sandbox_dummy_source_id: {type: integer}}`.
   - process = your decoded `process`.
   - destination = `migrate_sandbox_config` (config path) or
     `migrate_sandbox_entity:<entity_type>` with `default_bundle` (entity path).
3. `runMigration()` builds `SandboxMigration::create($container, [], 'migrate_sandbox', $definition)`,
   forces `STATUS_IDLE`, wraps it in a core `MigrateExecutable` with a `MigrateSandboxMessage`,
   clears the prior tempstore result, and calls `$executable->import()`.
4. The result is read back from `tempstore.private` collection `migrate_sandbox`, key
   `migrate_sandbox.latest`, and rendered (HTML-escaped) in the Results fieldset.
5. Any uncaught `\Throwable` is caught in `runMigration()` and printed as an on-screen error
   message with a formatted backtrace (via `Error::decodeException` / `Error::formatBacktrace`).

Nothing is written to migrate map/message DB tables (see "runtime mechanism" below).

## Prepopulating the sandbox

Three ways to fill the fields (all AJAX, no page reload):

- **Starter config** (`::usePrepopulatedSource`, select `prepopulated`): choose one of the
  bundled examples defined in `migrate_sandbox.settings` `sources:` (one per process plugin —
  ~50 examples covering core Migrate and Migrate Plus plugins), or the empty option
  `migrate_sandbox.latest` to reload your last input. "Start from Scratch" clears the fields.
- **From a real migration** (`::updatePopulateFromMigration`, "Populate" button): enter a
  `populate_migration` (migration machine name) and optionally colon-separated
  `populate_source_ids`. It clears the migration plugin-definition cache, instantiates the
  named migration, creates its **source** plugin, and pulls a single row's source data (and,
  if "Update Process Pipeline" is checked, copies that migration's `process:` into the form).
  "Fetch next row" advances the source iterator; optional `Constraints` YAML
  (`property: value`, AND-ed, optionally negated) filters which row is returned.
- **`migrate_sandbox.latest`**: the last-run input is always reloadable as starter config.

## Config objects and schema

Defined in `config/schema/migrate_sandbox.schema.yml`:

- `migrate_sandbox.settings` (`config_object`): `id`, `label`, `sources` (sequence of
  `migrate_sandbox_source`: `name` + `source.{plugin,data_rows,constants}` + `process`),
  and a `destination` mapping (`plugin`, `config_name`). Shipped defaults in
  `config/install/migrate_sandbox.settings.yml` provide the ~50 starter examples; default
  `destination` = `{plugin: migrate_sandbox_config, config_name: migrate_sandbox.processed}`.
- `migrate_sandbox.latest` (`config_object`): `id`, `label`, `source` (ignored/free-form),
  `process` (ignored/free-form), `destination` (`plugin`, `config_name`, `default_bundle`).
  This object is overwritten on every "Process Row".

Read/prime the starter list or the last input via drush, e.g.:

```bash
drush config:get migrate_sandbox.settings
drush config:get migrate_sandbox.latest
```

## Runtime mechanism (internal migrate plugins)

These are registered by the module but exist only to serve the sandbox migration; you would
not use them in a normal migration:

- `SandboxMigration` (`src/SandboxMigration.php`) subclasses core `Migration` and overrides
  `getIdMap()` to use the id_map plugin `migrate_sandbox`.
- id_map `migrate_sandbox` (`MigrateSandboxMap`, `@PluginID("migrate_sandbox")`) extends core
  `NullIdMap`, so no `migrate_map`/`migrate_message` rows are ever written. Its `saveMessage()`
  and the `MigrateSandboxMessage` message object push migrate messages to `\Drupal::messenger()`
  (prefixed `(Migrate Message)` / `(Migrate Log)`) so plugin output/errors appear on screen.
- destination `migrate_sandbox_config` (`MigrateSandboxConfig` extends core `Config`): stashes
  the built (unsaved) `Config` under tempstore key `migrate_sandbox.latest` with keys prefixed
  `results.`, instead of saving config.
- destination `migrate_sandbox_entity:<entity_type>` (deriver `MigrateSandboxEntity`, class
  `MigrateSandboxEntityContentBase`): creates a content entity from the row, validates it,
  stashes it in tempstore for display, then **deletes** it — `updateEntity()` is intentionally
  a no-op so nothing persists.

## The "Sandbox Escape Warning" feature

`js/migrate-sandbox.js` polls the `process` textarea once a second; if the pipeline text
mentions any of these side-effecting plugins it un-hides an on-screen warning above the
submit button (list in `drupalSettings.migrate_sandbox_warnings`):
`download`, `file_blob`, `file_copy`, `migration_lookup`, `entity_generate`, `callback`,
`service`, `dom_migration_lookup`. These plugins can have effects outside the sandbox
(files written, entities generated/looked-up-with-stub, callables/service methods invoked);
the warning is informational — the plugins still run.

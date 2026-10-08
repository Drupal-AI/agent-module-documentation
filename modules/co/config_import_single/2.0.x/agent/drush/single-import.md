# Drush: import a single config file

## Command

```
config_import_single:single-import <file>
```

- **Alias:** `cis`
- **Argument:** `<file>` — path to a single exported config YAML file (relative to the current
  working directory or absolute).
- Defined in `src/Commands/ConfigImportSingleCommands.php::singleImport()`, wired via
  `drush.services.yml`, tagged `drush.command`, `@validate-module-enabled config_import_single`.

```bash
# Import one file:
drush cis config/sync/views.view.frontpage.yml
drush config_import_single:single-import /path/to/user.role.editor.yml
```

## Critical: filename determines the config object name

The command derives the target config object name from the **filename without its extension**
(`Path::getFilenameWithoutExtension($file)`), *not* from anything inside the file. So the file
**must be named `<config.object.name>.yml`**:

- `user.role.editor.yml`  → imports config object `user.role.editor`
- `system.site.yml`       → imports config object `system.site`
- `views.view.foo.yml`    → imports config object `views.view.foo`

The YAML body is used verbatim as that object's data.

## How it works

1. Parses the YAML (`Symfony\Component\Yaml\Parser`).
2. Wraps active `config.storage` in a `StorageReplaceDataWrapper`, replacing only that one object.
3. Builds a `StorageComparer` (source = wrapper, target = active storage) and runs core's
   `ConfigImporter` as a batch (`drush_backend_batch_process()`).

Because it is the real ConfigImporter, the single object is fully **validated** (schema,
dependencies, `config.importer` events) and can be a create, an update, or a delete+recreate. On
success it prints `Successfully imported <name>`.

## Errors

- No argument → throws `No file specified.`
- File not on disk → throws `File not found.`
- Validation/import failure → throws `Failed importing file`
- If an import is already running, it prints `Import already running.`

No admin UI, no config, no permissions — the whole module is this command.

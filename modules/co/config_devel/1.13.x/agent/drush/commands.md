# Config Devel Drush commands

Three commands (defined in `src/Commands/ConfigDevelCommands.php`, registered via
`drush.services.yml`; a legacy `drush/config_devel.drush.inc` also exists). Aliases in
parentheses.

| Command | Aliases | Argument | Purpose |
|---|---|---|---|
| `config:devel-export` | `cde`, `cd-em`, `config-devel-export` | `<extension>` | Write a module/theme/profile's owned config objects out to its `config/install` (+ `config/optional`) dir. |
| `config:devel-import` | `cdi`, `cd-im`, `config-devel-import` | `<extension>` | Read a module/theme/profile's `config/install` (+ `config/optional`) YAML back into active storage. |
| `config:devel-import-one` | `cdi1`, `cd-i1`, `config-devel-import-one` | `<path>` | Import a single YAML file (or stdin) into active storage. |

## The `config_devel:` info.yml section (drives export/import)

`cde`/`cdi` operate on the list of config objects the extension declares in its `.info.yml`:

```yaml
# mymodule.info.yml
config_devel:
  install:
    - node.type.article
    - core.entity_form_display.node.article.default
    - field.field.node.article.body
  optional:
    - field.field.node.article.tags
```

`install` objects export to `config/install/`, `optional` objects to `config/optional/`.
**Any key is supported** beneath `config_devel:` — a key other than `install`/`optional`
(e.g. `mykey`) maps to `config/<key>/`, so third-party directory names work. A legacy flat
format (config names listed directly under `config_devel:` with no sub-keys) is still accepted
and treated as `install`.

```bash
drush config:devel-export mymodule   # writes config/install/*.yml into the module
drush config:devel-import mymodule    # imports those files back into active storage
```

The extension must be **enabled** (module/theme) or be the active install profile, or the
command throws (`profile` is checked before `module` because profiles register as modules).
Missing config objects are skipped with a warning; export creates the target directory if
needed (throws if it can't be created).

## Import a single object

`config:devel-import-one` derives the config object name from the file's **basename**, so a
file named `system.site.yml` imports into `system.site`:

```bash
drush config:devel-import-one path/to/system.site.yml   # from a file
drush config:devel-import-one system.site < system.site.yml   # from stdin (name w/o .yml)
```

If the argument is not an existing file and does **not** end in `.yml`, YAML is read from
stdin and the argument is used as the object name. If it ends in `.yml` and is relative, it is
resolved against `$_SERVER['PWD']`. On a successful import it prints
`Imported config from file <path>.` (nothing is printed if the content was unchanged); a
missing file throws `File '<path>' not found.`

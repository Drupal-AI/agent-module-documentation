# Config Devel Drush commands

Three commands (defined in `src/Commands/ConfigDevelCommands.php`, registered via
`drush.services.yml`). Aliases in parentheses.

| Command | Aliases | Argument | Purpose |
|---|---|---|---|
| `config:devel-export` | `cde`, `cd-em` | `<extension>` | Write a module/theme/profile's owned config objects out to its `config/install` (+ `config/optional`) dir. |
| `config:devel-import` | `cdi`, `cd-im` | `<extension>` | Read a module/theme/profile's `config/install` (+ `config/optional`) YAML back into active storage. |
| `config:devel-import-one` | `cdi1`, `cd-i1` | `<path>` | Import a single YAML file (or stdin) into active storage. |

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
A legacy flat format (config names listed directly under `config_devel:` with no
`install`/`optional` keys) is still accepted and treated as `install`.

```bash
drush config:devel-export mymodule   # writes config/install/*.yml into the module
drush config:devel-import mymodule    # imports those files back into active storage
```

The extension must be **enabled** (module/theme) or be the active install profile, or the
command throws. Missing config objects are skipped with a warning; export creates the target
directory if needed.

## Import a single object

`config:devel-import-one` derives the config object name from the file's **basename**, so a
file named `system.site.yml` imports into `system.site`:

```bash
drush config:devel-import-one path/to/system.site.yml   # from a file
drush config:devel-import-one system.site < system.site.yml   # from stdin (name w/o .yml)
```

If the path is relative and ends in `.yml`, it is resolved against `$PWD`. A non-`.yml`
argument reads YAML from stdin and uses the argument as the object name. On success it prints
`Imported config from file <path>.`

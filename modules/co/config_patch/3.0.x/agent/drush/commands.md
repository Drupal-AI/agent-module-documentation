# Drush — Config Patch

Defined in `src/Commands/ConfigPatchCommands.php` (service `config_patch.command`).

## `config:patch PLUGIN_ID` (alias `cpatch`)

Generate a patch from active → sync config using the named output plugin, which must
implement `CliOutputPluginInterface` (otherwise prints "This plugin does not support cli
output"). The bundled `text` plugin works.

Options:
- `--filename=PATH` — write the output to a file instead of stdout.
- `--collections=a,b` — comma-separated config collections to include (others dropped).

```bash
drush config:patch text                     # print unified diff to stdout
drush config:patch text --filename=cfg.patch
drush cpatch text | patch -p1               # apply another site's config to your repo
```

## `config:patch:list`

List config objects that differ between active and sync, as a table of `config name` /
`change type`. Throws "No changes found." when there is no drift.

Options:
- `--compact` — compact table style, no headers.

```bash
drush config:patch:list
drush config:patch:list --compact
```

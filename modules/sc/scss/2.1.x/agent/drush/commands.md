# Drush — compile from the CLI

Registered via `drush.services.yml` (service `scss.commands`, tag `drush.command`) in
`Drupal\scss\Commands\ScssCommands`.

| Command | Aliases | Behavior |
|---------|---------|----------|
| `scss:compile` | `scss`, `scss-c` | Gets `scss.compiler`, sets `->force = TRUE`, runs `compileScss()`, prints `SCSS compiling finished.` |

```bash
drush scss:compile     # or: drush scss   /   drush scss-c
```

Because it sets `force = TRUE`, it rebuilds regardless of `compileNeeded()`, but it still respects
`checkConfiguration()` (library present, source dir exists, CSS dir writable, `.scss` files found)
and writes `<name>.css` / `<name>.css.map` into the configured `css_directory`. It does **not**
require `active` to be on — this is the recommended way to compile during deployment while leaving
the request-time monitor off in production.

## Legacy Drush integration (`scss.drush.inc`)

The module also ships a Drupal-7/Drush-8 style `scss.drush.inc` declaring a `scss` command via
`scss_drush_command()` whose callback `drush_scss()` does `new ScssCompiler()` (no constructor
args) — this cannot run on modern Drupal (the service constructor requires three arguments), so
the effective command is `scss:compile` from `ScssCommands`. Confirm with `drush list | grep scss`.

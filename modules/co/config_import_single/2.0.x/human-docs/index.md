# Config import single — manual setup guide

**Config import single** (`config_import_single`) adds one Drush command that
imports a **single** configuration YAML file into your site's active
configuration — without running a full config sync of the whole sync directory.
It's the tool you reach for when you only want to bring in one changed
`*.yml` file (a view, a block, a field, a settings object) and don't want
`drush config:import` to block on unrelated differences elsewhere in your config.

The module is a thin Drush wrapper — a port of the old Drupal Console
`config:import:single` command — exposing exactly one command:
`config_import_single:single-import`, aliased **`cis`**. You give it the path to a
single exported config file and it imports just that one object. Crucially, it
still runs Drupal core's real **ConfigImporter**, so the change is fully validated
(schema, dependencies, import‑event subscribers) exactly like a normal config
import — only scoped to the one object. That means it can create, update, or
delete‑and‑recreate a single config item safely.

The module has no admin UI, no configuration, and no permissions of its own. It
requires **Drush 11.3 or newer**.

This guide is written for a **human** working at the command line. If you want
terse, token‑cheap references for an AI coding agent — including the exact error
messages and internals — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module is entirely a Drush command. It adds no admin pages, no
settings, and no permissions.

## How to use it

The command takes a single argument: the path to a config file.

```bash
# Import one file (path relative to the current directory or absolute):
drush cis config/sync/views.view.frontpage.yml
drush config_import_single:single-import /path/to/user.role.editor.yml
```

**The filename determines the target config object.** The command derives the name
of the config object from the **filename without its extension** — *not* from
anything inside the file. So the file must be named `<config.object.name>.yml`:

| File | Imports into config object |
|------|-----------------------------|
| `user.role.editor.yml` | `user.role.editor` |
| `system.site.yml` | `system.site` |
| `views.view.foo.yml` | `views.view.foo` |

The YAML body is used as that object's data. On success it prints
`Successfully imported <name>`.

### Typical uses

- Pull one changed view or block from another environment and apply just it.
- Re‑import a single accidentally‑changed config object back to its exported
  version.
- Create a new config entity from a hand‑written YAML fixture.
- Deploy one config change in a hotfix, or script a targeted config update in
  CI/CD, without exporting or importing everything.

### If something goes wrong

The command stops with a clear message if you give it no file (`No file
specified.`), point it at a file that isn't there (`File not found.`), or if the
import fails validation (`Failed importing file`). If an import is already running
it reports `Import already running.` Because it uses the same validated
ConfigImporter as `drush config:import`, a change that would break config
dependencies is rejected rather than applied.

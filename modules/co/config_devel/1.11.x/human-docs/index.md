# Configuration development — manual setup guide

**Configuration development** (`config_devel`) is a developer tool that automates
moving Drupal configuration between YAML files and the active configuration store,
and exports a module's own configuration back into its `config/install` directory
— a Features-style workflow for Drupal 8 and later.

It gives you three related tools:

- **Auto-import** — list config *files* (paths relative to the Drupal root) and, at
  the start of every request, Config Devel checks each file's hash and re-imports
  any that changed, exactly as if you had pasted it into core's *Single import*
  form. Great for iterating on a YAML file locally without clicking through the UI
  each time.
- **Auto-export** — list config *object names* and, whenever one of those objects
  is saved through the admin UI, its current value is written back out to disk, so
  your UI edits land straight in version control.
- **Module export/import via Drush** — a module lists the config objects it owns in
  a `config_devel:` section of its `.info.yml`; then `drush config:devel-export`
  writes those objects into the module's `config/install` (and `config/optional`)
  directory, and `drush config:devel-import` reads them back into active storage.

> **Development only.** This is explicitly a developer/local tool. Do **not**
> deploy or enable it on production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The auto-import / auto-export settings form is at **Configuration → Development →
Configuration development** (`/admin/config/development/config_devel`). It's gated
by core's **Import configuration** permission — the module defines no permission of
its own.

## How to use it

### Auto-import a file on every request

1. Open the settings form and, in the **Auto import** box, add the path(s) to the
   config YAML files you're editing — **relative to the Drupal root**, for example
   `modules/custom/mymod/config/install/node.type.article.yml`. One per line.
2. Save. From then on, at the start of each request, any listed file whose contents
   changed is imported into active storage automatically.

A few things to know: certain objects can't be auto-imported and the form rejects
them — `system.site`, `core.extension`, and `simpletest.settings`.

### Auto-export an object when you save it

1. In the **Auto export** box, list the config object *names* (not file paths) you
   want to keep on disk — for example `system.site`. One per line.
2. Save. Now, whenever one of those objects is saved through the admin UI, its
   current value is written back out to the target file(s).

### Export/import a module's config with Drush

Declare the config a module owns in its `.info.yml`:

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

Then round-trip it:

```bash
# Write the module's owned objects out to config/install (and config/optional)
drush config:devel-export mymodule    # alias: cde

# Read those YAML files back into active storage
drush config:devel-import mymodule    # alias: cdi
```

`install` objects go to `config/install/`, `optional` ones to `config/optional/`.
The module must be enabled (or be the active install profile), missing objects are
skipped with a warning, and the target directory is created if needed. A legacy
flat format (config names listed directly under `config_devel:`) is still accepted
and treated as `install`.

### Import a single file

```bash
# From a file — the object name comes from the file's basename
drush config:devel-import-one path/to/system.site.yml   # alias: cdi1

# From stdin — give the object name as the argument
drush config:devel-import-one system.site < system.site.yml
```

See the [`agent/`](../agent/start.md) docs for the exact `config_devel.settings`
data shape, the `ConfigImporterExporter` service, and the event subscribers.

# Configuration Partial Export — manual setup guide

**Configuration Partial Export** (`config_partial_export`) is a developer tool for
exporting only the *selected* configuration objects you care about — instead of
the whole site's configuration. Drupal's normal `drush config:export` (`cex`)
writes out everything; that's often more than you want when you've changed a
single view, added one field, or tweaked a role, and you'd rather move just those
few objects into version control, a distribution, or another environment.

This module gives you two ways to grab a subset:

- **A "Partial Export" UI tab** under the standard configuration synchronization
  screen. It lists the configuration objects that differ from the last import
  snapshot, lets you tick the ones you want (and optionally include the site UUID
  via a `system.site` checkbox), and downloads them as a gzipped tarball. It even
  remembers your selection between visits.

- **A Drush command**, `config-partial-export` (alias `cpex`), which writes named
  active configuration objects straight into your config sync directory as `.yml`
  files. It accepts a comma-separated list and supports shell-style `*`
  wildcards, so you can export an entire module's configuration in one call — for
  example every webform, or every view.

It's aimed squarely at development and deployment workflows: keeping a feature
branch's config change small, handing a teammate just your objects without
shipping unrelated edits, or keeping a custom module's `config/install` folder up
to date with hand-picked objects.

The module has **no settings, no configure route, and no configuration schema** of
its own — it defines only the export tab, the download controller, and the Drush
command. Access to the UI uses core's own **Export configuration** permission (the
module adds none of its own).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the exact Drush
syntax, wildcards, and the `--changelist` option — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Configuration Partial Export has **no settings page**. It adds a **Multiple
items** / **Partial Export** tab under **Configuration → Development →
Configuration synchronization → Export**
(`/admin/config/development/configuration/single/config-partial-export`). Access
to it is gated by core's **Export configuration** permission.

## How to use it

**From the UI (download a tarball):**

1. Go to **Configuration → Development → Configuration synchronization**, open the
   **Export** tab, and choose the **Partial Export** (Multiple items) sub-tab.
2. The form lists configuration objects that differ from the last import
   snapshot. Tick the ones you want. If nothing has changed since the last
   import, the table is empty.
3. *(Optional)* Tick **Add system.site info** to include `system.site` (the site
   UUID) in the export.
4. Click **Export**. You'll get a download named something like
   `config_partial-<hostname>-<date>.tar.gz`. To apply it elsewhere, unpack its
   `.yml` files into a module's `config/install` folder or into your sync
   directory and import.

**From the command line (write to the sync directory):**

```bash
# Export one view straight into the config sync directory:
drush config-partial-export views.view.frontpage      # alias: drush cpex

# Export everything for a module using a wildcard (quote it so the shell
# doesn't expand it):
drush cpex "webform.webform.*"

# Export several specific objects at once:
drush cpex "system.site,user.role.editor"

# Inspect what active config differs from the sync directory, WITHOUT exporting:
drush cpex --changelist
```

The command reads the objects from active configuration and writes each as a
`<name>.yml` file into your site's config sync directory. The `--changelist`
option is inspection-only — it prints the create/update/delete differences and
writes nothing (and only reports anything once the sync directory has been
populated, e.g. after a `drush cex`).

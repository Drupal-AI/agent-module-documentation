# Drush Clear Plugins Cache — manual setup guide

**Drush Clear Plugins Cache** (`drush_clear_plugins_cache`) is a small developer
convenience that adds a Drush command for clearing the cached definitions of a
plugin manager — either one specific manager or all of them — without doing a
full `drush cr`. If you are building or editing plugins (fields, blocks, migrate
sources, and so on), Drupal caches their definitions, and freshly added or
changed plugins sometimes are not picked up until that cache is cleared. This
command clears exactly the plugin-manager caches, which is faster and more
targeted than rebuilding every cache bin.

The right way to invalidate plugin definitions in Drupal is to call
`clearCachedDefinitions()` on the appropriate plugin manager rather than deleting
cache entries directly, and that is precisely what this command does for you from
the CLI.

It is a development-only tool — it depends on the **Devel** module, which signals
its intended audience — and it has no web routes, permissions, or configuration.
Disable it (and Devel) on production as a matter of hygiene. It supports Drupal
8.7.7 and up, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Devel dependency).

There is **no configuration page** for this module — it is a Drush command
provider, described under "How to use it" below.

## How to use it

Run the command from the Drupal root. It takes an optional argument naming the
plugin-manager service to clear; the default is `all`, and the command alias is
`pmcc`:

```bash
# Clear one plugin manager's cached definitions:
drush drush_clear_plugins_cache:clear-cache plugin.manager.block

# Clear every plugin manager's cache:
drush drush_clear_plugins_cache:clear-cache all

# Same as "all" — the argument defaults to it:
drush drush_clear_plugins_cache:clear-cache
```

Use it right after adding or editing a plugin annotation/class, when the new
definition has not been picked up yet — it saves clearing your render and page
caches unnecessarily. The exact command name and aliases for your version are
declared in the module's `drush.services.yml`.

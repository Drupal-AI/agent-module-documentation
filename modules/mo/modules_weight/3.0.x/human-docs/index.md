# Modules Weight — manual setup guide

**Modules Weight** (`modules_weight`) gives you a UI — and matching Drush commands —
for changing the **weight** of installed modules. A module's weight decides the order
in which its hook implementations run: a lower weight runs earlier, a higher weight
runs later. Normally you would only change this with a raw SQL update or a one‑off
`module_set_weight()` call; this module turns it into a safe admin screen and a
couple of commands.

Why does that matter? When two modules both alter the same form, both react to the
same entity save, or both provide a theme suggestion, the one that runs *later* wins.
If the wrong module is winning a hook, adjusting weights fixes the order without
patching either module. It is a developer/site‑builder tool for resolving those "why
does this module's change get overridden?" situations.

The reorder screen lists each installed, compatible module with an editable weight.
By default only contrib modules are shown; a small settings page has a single option
to also include Drupal Core modules in the list. Weights are stored in the standard
`core.extension` configuration, so they export and deploy like any other config.

There is no separate "configuration" page in this guide — the reorder UI and its one
setting are covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The reorder form is at **Configuration → System → Modules Weight**
(`/admin/config/system/modules-weight`), and its settings page is at
`/admin/config/system/modules-weight/configuration`. Both require the **Administer
modules weight** permission.

## How to use it

### Reorder modules in the UI

1. Go to **Configuration → System → Modules Weight**
   (`/admin/config/system/modules-weight`).
2. Each module is listed with an editable weight. Lower numbers run earlier; higher
   numbers run later. Set the weights you need.
3. Save. The new weights are written to `core.extension` and take effect immediately.

### Show Core modules (optional)

By default only contrib modules appear in the list. To also reorder Drupal Core
modules, open the settings page at
`/admin/config/system/modules-weight/configuration` and turn on **Show system
modules**. Reordering Core modules is an advanced action — leave this off unless you
specifically need it.

### From the command line

The module ships three Drush commands:

- `drush mw-list` (alias `mw-l`) — print the table of modules and their weights.
- `drush mw-reorder <module> <weight>` (alias `mw-r`) — read or set a module's
  weight. Add `--minus` for a negative weight (to run very early), and `--force` to
  touch a Core module.
- `drush mw-show-system-modules <on|off>` (alias `mw-ssm`) — read or toggle the
  show‑Core‑modules option.

For example, to make `mymodule` run later than usual:

```bash
drush mw-reorder mymodule 5
```

### Permission

Both admin pages require the **Administer modules weight** permission. Grant it only
to trusted administrators, since changing module order affects site behavior
globally.

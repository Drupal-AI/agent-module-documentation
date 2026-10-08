# Config Modify — manual setup guide

**Config Modify** (`config_modify`) is a developer/deployment tool that lets one
module make declarative changes to configuration that **another** module (or core)
owns — automatically, at install time. Normally, if your feature module needs to
tweak a config object it doesn't own (add a field to someone else's search index,
change a default in another module's config, delete a key), you'd have to write a
custom update hook or re-export and "own" that whole config object. Config Modify
replaces that with a simple, dependency‑aware YAML file you ship in a
`config/modify/` folder.

The way it works: when Drupal would install a module's *optional* config, Config
Modify also scans every enabled module's `config/modify/*.yml` files and applies
any that are applicable and haven't run before. Each file lists its
**dependencies** (modules or config that must exist first) and its **items** (the
actual changes, written in the `update_helper` "Config Update Definition"
add/change/delete format). Applied files are recorded so a modification runs at
most once, and modifications are skipped during a config import (because the source
environment already made the change) — so it plays nicely with config sync.

This is a code‑ and CLI‑driven tool: there is **no admin form, no permissions, and
no web‑facing routes**. It provides two Drush commands — one to scaffold a
`config/modify` file by diffing your on‑disk and active config, and one to run
before database updates so new modification files don't fire unexpectedly. It
depends on core's **Config** module and the contrib **Update Helper** module, and
requires **PHP 8.1+**.

> **Compatibility note:** Config Modify works by swapping out core's config
> installer service. It cannot coexist with another module that also replaces that
> service — if one does, Config Modify throws an error rather than silently
> misbehaving.

This guide is written for a **human** (here, a developer). If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Update Helper) and enable the module.
2. [Configuration](configuration/index.md) — the `config/modify` file format, when
   modifications run, and the two Drush commands.

## Where it lives in the admin menu

Nowhere — there is no admin UI. You "configure" Config Modify entirely by shipping
YAML files inside your own modules and running Drush.

## How to use it

Add a `config/modify/<your_module>.<name>.yml` file to your module describing the
changes you want to make to existing config, then install (or reinstall) a module
that provides optional config to trigger it — or scaffold the file with `drush
config-modify:create`. The full file format and command reference is in
[Configuration](configuration/index.md).

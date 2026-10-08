# Configuration Synchronizer — manual setup guide

**Configuration Synchronizer** (`config_sync`) helps you pull **configuration changes
that ship inside updated modules, themes, and install profiles** into a running site.
Normally Drupal imports an extension's default configuration only once, when you first
install it — after that, if a new release changes or adds config (a new field, an
improved View, a corrected setting), Drupal never re-imports it. Configuration
Synchronizer closes that gap.

It works by taking a **snapshot** of the configuration each extension provides at the
moment it's installed. Later, after you `composer update`, it compares that snapshot
against what the updated extension now ships and builds a per-extension list of
available config updates. You review those on a **Distribution Updates** page and apply
the ones you want.

Crucially, you choose *how* updates are applied. **Merge** mode (the default) does a
three-way merge that brings in the extension's changes while keeping your own local
edits. **Partial reset** overwrites only the items that have updates. **Full reset**
returns all extension-provided config to what the modules currently ship. That makes it
a natural fit for maintaining or consuming a Drupal distribution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its several
   supporting modules with Composer, then enable it.
2. [Configuration](configuration/index.md) — the Distribution Updates page, the three
   update modes, and the Drush commands.

## Where it lives in the admin menu

Configuration Synchronizer does not add a settings form of its own. The interface you
use is the **Distribution Updates** page at **Configuration → Development →
Distribution Updates** (`/admin/config/development/distro`), which comes from its
Config Distro dependency and is where available config updates are listed and applied.

## How to use it

1. Install and enable the module (a snapshot of every installed extension's provided
   config is taken automatically at that point).
2. Update a module, theme, or profile as usual with Composer.
3. Visit **Configuration → Development → Distribution Updates** (or run
   `drush config-sync-list-updates`) to see which extensions have config changes waiting.
4. Pick an **update mode** (Merge, Partial reset, or Full reset), select the extensions
   to apply, and submit.

See [Configuration](configuration/index.md) for what each mode does and the exact
commands.

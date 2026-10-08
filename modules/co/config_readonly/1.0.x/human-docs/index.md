# Configuration Read-only — manual setup guide

**Configuration Read-only** (`config_readonly`) write-protects your site's active
configuration so that config can only be changed by importing a validated config set —
typically on production, where you want config edits through the admin UI to be impossible.
It enforces a "config in code" workflow: the way to change configuration on a locked site
is `drush config:import`, not clicking around in the admin screens.

There is no admin page and no settings entity for this module — the lock is switched on
entirely from `settings.php` with a single line, `$settings['config_readonly'] = TRUE;`.
Once on, two guards kick in. The storage guard makes any attempt to write, delete or rename
active config throw an exception. The form guard disables the Save button on every
configuration form — including the modules, permissions and single-config-import screens —
and shows a warning banner explaining why. Two escape hatches are built in so the site
stays operable: `drush config:import` still works (the config importer bypasses the lock),
and `update.php` still runs.

You can let specific config names through with a **whitelist** — glob-style patterns
(where `*` is the only wildcard) either listed in `settings.php` or supplied by a custom
module — so, for example, maintenance mode can still be toggled on an otherwise-frozen
site. The module has no dependencies beyond Drupal core (`^9.5 || ^10 || ^11`), no
permissions and no Drush commands of its own.

This guide is written for a **human** editing files and clicking through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — turn the lock on in `settings.php`, whitelist
   config that must stay editable, and check whether the lock is active.

## Where it lives in the admin menu

Configuration Read-only has **no admin page**. The only place it surfaces in the UI is the
site **Status report** at `/admin/reports/status`, which shows a *Config Read-only mode*
line telling you whether the lock is active ("Config is readonly") or the module is enabled
but switched off ("Config is writable"). Everything else is controlled from `settings.php` —
see [Configuration](configuration/index.md).

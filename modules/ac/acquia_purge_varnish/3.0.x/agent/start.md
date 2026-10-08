<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Purge Varnish (acquia_purge_varnish) — agent index

Varnish purging for Acquia Cloud, with per-environment controls: admin form + Drush commands.
Configure at `acquia_purge_varnish.form`. Version **3.0.0**. Core `^10 || ^11`, **PHP `^8.1`**.

Permission: `administer acquia purge varnish` — **`restrict access: true`**. Correct: a purge has
production consequences, it is not a settings change.

Classes: `AcquiaPurgeVarnishApiClient`, `Form/AcquiaPurgeVarnishForm`,
`Controller/AcquiaPurgeVarnishController`, `Commands/AcquiaPurgeVarnishCommands` (Drush).
Config: `acquia_purge_varnish.settings`.

Submodule: `acquia_purge_varnish_test`.

Positioning: the narrow alternative to the full **Purge** module stack when the only target is
Acquia's Varnish. The per-environment control is the part to emphasise — a purge aimed at the
wrong environment is either useless or, against production at peak, disruptive.
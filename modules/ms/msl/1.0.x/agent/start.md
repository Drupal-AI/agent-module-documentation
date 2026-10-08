<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multisite Easy Commands (msl) — agent index

**Drush helper for multisite: pick the target site from a list (or a remembered URI) instead of always passing `--uri`.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Depends:** none (Drush)
- **Configure:** `/admin/config/msl-configuration` (route `msl.admin_settings_form`), permission `administer site configuration`.

**Surface:** Drush commands in `MultiSiteEasyCommands.php` + one settings form. Reads sites from `sites.php` and config; runs the chosen command via `passthru()` with an appended `--uri=`. State key `persist_url` remembers a selection.

**Security:** CLI-only, no web execution path. `passthru()` interpolates the assembled Drush command including site URIs from `sites.php`/config — trusted, developer-set values run locally (same trust boundary as a Drush alias). Not reachable by web requests.

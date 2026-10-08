<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crazy Egg — agent index

Injects the Crazy Egg tracking snippet (heatmaps, scrollmaps, recordings, A/B tests) into pages.
Pure third-party-snippet integration: one config object, one settings form, no plugins/Drush/entities.
Settings form: `/admin/config/system/crazyegg` (route `crazyegg.config`, permission `administer crazy egg`).

- **All settings keys, the account-id → script-URL mapping, and the injection conditions** →
  [configure/settings.md](configure/settings.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `crazyegg.settings`: `crazyegg_enabled` (int), `crazyegg_account_id` (numeric),
  `crazyegg_js_scope` (`header`|`footer`), `crazyegg_paths` (path patterns; empty = all),
  `crazyegg_roles_excluded` (role ids).
- Script attaches only when: enabled, an account id is set, path matches `crazyegg_paths`, and the
  current user is not in an excluded role (`hook_page_attachments`).
- Account id `1234567` → padded `01234567` → URL `https://script.crazyegg.com/pages/scripts/0123/4567.js`.
- No external calls server-side; the snippet runs in the visitor's browser.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove system.schema key/value (rmkv) — agent index

Provides two **Drush commands** that delete orphaned entries from Drupal's `system.schema`
key/value collection — the store that records each installed extension's last-run schema version.
When a module/theme/profile is deleted from disk *without* being uninstalled first, its
`system.schema` record is left behind and Drupal reports: "Module X has an entry in the
system.schema key/value storage, but is missing from your site." rmkv removes that stray record.
Version **2.2.0**. Core `>=10`, PHP `>=8.1`. No web routes, permissions, or config of its own — a
CLI recovery tool. The browser-form equivalent ships as the bundled submodule **rmkv_form**.

- **The `rmkv:check` and `rmkv` Drush commands** → [drush/commands.md](drush/commands.md)

Key facts:
- Drush service `rmkv.commands` → `Drupal\rmkv\Commands\RemoveKeyValueCommands` (registered in `drush.services.yml`).
- Operates on the key/value store `system.schema` (obtained from the `keyvalue` factory).
- `rmkv:check <machine_name>` — reports whether the entry is safe to remove (read-only).
- `rmkv <machine_name>` — deletes the entry, only if it exists AND is not an installed profile/module/theme.
- Guards injected: `extension.list.profile`, `module_handler`, `theme_handler`.
- Submodule: `rmkv_form` (form UI). This module itself has no `configure` route.

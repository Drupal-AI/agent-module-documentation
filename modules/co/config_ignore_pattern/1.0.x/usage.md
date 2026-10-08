<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config ignore pattern keeps configuration objects matching a set of regular-expression patterns out of configuration export/import, so environment-specific or generated config is not overwritten or removed during deployment.
---
The module registers a `ConfigEventSubscriber` on the core config `STORAGE_TRANSFORM_EXPORT` and `STORAGE_TRANSFORM_IMPORT` events. On export it deletes ignored config from the outgoing storage so it never lands in `config/sync`; on import it writes the current active value back into the incoming storage so the import treats it as unchanged (preventing deletion or overwrite during `drush config:import`). Patterns are matched against each active config name and its declared config dependencies, and any config already present in the sync/file storage is skipped so existing tracked config keeps syncing normally. An optional debug flag surfaces messages naming which items were ignored and why.

Operationally the patterns come from `$settings['config_ignore_patterns']` in `settings.php` (an array of PCRE regexes), with `$settings['config_ignore_pattern_debug']` toggling debug output — both are trusted, code-level settings. The module has no routes, permissions, services beyond the subscriber, or UI, so there is no runtime access surface; the only care needed is authoring correct regex patterns (a too-broad pattern could silently drop config from exports).
---
- Add `$settings['config_ignore_patterns']` with PCRE regexes in settings.php.
- Ignore environment-specific config (e.g. API endpoints) from sync.
- Keep generated or per-site config out of `config/sync`.
- Prevent config:import from deleting locally-created config.
- Match config by name using regular expressions.
- Ignore a config item's dependencies along with the item.
- Continue syncing config that already exists in file storage.
- Enable `$settings['config_ignore_pattern_debug']` to see what was ignored.
- Review `state` keys `config_ignored_export` / `config_ignored_import`.
- Exclude devel/test module config from production exports.
- Avoid overwriting site-specific settings during deployment.
- Author narrow patterns to avoid dropping wanted config.
- Anchor regexes (`^...$`) to match exact config names.
- Ignore a whole config prefix (e.g. all webforms) with one pattern.
- Let previously-exported config keep syncing normally.
- Verify ignored items via the debug messages before deploying.
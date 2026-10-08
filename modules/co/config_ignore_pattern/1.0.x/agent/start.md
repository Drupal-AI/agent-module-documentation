<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config ignore pattern (config_ignore_pattern) — agent index
**Excludes config matching `$settings['config_ignore_patterns']` regexes from export/import, preserving active values.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Service:** `ConfigEventSubscriber` on `STORAGE_TRANSFORM_EXPORT` / `STORAGE_TRANSFORM_IMPORT`
- **Settings:** `$settings['config_ignore_patterns']` (array of PCRE regexes), `$settings['config_ignore_pattern_debug']` (bool)
- **Behavior:** export deletes ignored config from outgoing storage; import writes active value back so it appears unchanged; items already in file storage are skipped; config dependencies also matched
- **Security:** No routes/permissions/UI. Patterns are code-level trusted settings; the only risk is an over-broad regex dropping wanted config from exports.

See [configure/patterns.md](configure/patterns.md)
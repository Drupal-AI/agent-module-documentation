<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Purifier — agent index

One text-format filter (`htmlpurifier`) that runs the `ezyang/htmlpurifier` library to strip XSS and
emit standards-compliant HTML. Depends on core `filter`. No permissions, no plugins to implement, no
services, no Drush. Provides config schema.

- **Enable it on a format, write the YAML config, the cache path setting, and filter-order rules** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Filter id `htmlpurifier`, `TYPE_TRANSFORM_IRREVERSIBLE`; enable at
  `admin/config/content/formats` per text format. `configure` (module-level) is null.
- Per-format setting `filters.htmlpurifier.settings.htmlpurifier_configuration` = a YAML string of
  HTML Purifier directives (schema `filter_settings.htmlpurifier`). Empty = library defaults.
- Applied as `$config->set("$namespace.$key", $value)` for each YAML namespace; the `Cache` namespace
  is force-removed so formats can't alter cache internals.
- Global setting `htmlpurifier.settings:cache_serializer_path` (default empty → `[temp]/htmlpurifier`)
  is the absolute, writable path for Purifier's serializer cache.
- Effectiveness depends on config: it must be enabled on the formats that accept untrusted HTML and
  ordered **last** in the format's filter chain (after any filter that can add markup).
- External library dependency: `ezyang/htmlpurifier ^4.10` (installed via Composer).

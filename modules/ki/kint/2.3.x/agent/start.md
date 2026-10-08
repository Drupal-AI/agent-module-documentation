<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kint — agent index

Integrates the Kint PHP dumper: `d()`/`s()` dump helpers in PHP and Twig, Drupal-tuned, output
gated by the `access kint dumps` permission. Config UI: `kint.form`
(`/admin/config/development/kint`). Bundles `kint-php/kint` + `kint-php/kint-twig`.

- **Settings + helper functions (kint.settings, kint.helper.* config)** →
  [configure/settings.md](configure/settings.md)
- **The dump helpers, HelperManager, Twig, Devel dumper** → [api/functions.md](api/functions.md)
- **Permissions & when output shows** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `kint.settings`: `early_enable` (bool — dump before auth), `date_format` (string, nullable),
  `rich_theme` (string, e.g. `original.css`), `use_kint_trace_in_devel` (bool). Defaults:
  early_enable false, date_format `[c]`, rich_theme `original.css`, use_kint_trace_in_devel true.
- Helper config objects `kint.helper.<name>` (prefix `kint.helper.`): `renderer` (FQCN of a Kint
  renderer), `cli_detection` (bool), `mode` (`default`|`exit`|`messenger`). Ships `kint.helper.d`
  (RichRenderer) and `kint.helper.s` (PlainRenderer) → the global `d()` and `s()` functions.
- Permission `access kint dumps` (restricted). Twig dumps also need Twig development mode.
- Devel dumper plugin id `kint` (uses Devel's permissions when active). No Drush.

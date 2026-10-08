<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block List Override — agent index

Filters block **plugin definitions** out of Drupal's block library (theme block-placement
list via `hook_block_alter`, and the Layout Builder chooser via
`hook_plugin_filter_block__layout_builder_alter`). Match block ids by exact name, colon
prefix, or regex; then either *Remove* them or *Allow only* them.

- **Config keys, match/prefix/regex/negate semantics, routes, permission, the LB quirk** →
  [configure/settings.md](configure/settings.md)
- **The `block_list_override.list` service (`blockIsAllowed`)** →
  [api/service.md](api/service.md)

Key facts:
- Config `block_list_override.settings`: `system_match`, `system_prefix`, `system_regex`
  (newline-separated strings), `system_negate` (bool: 0=Remove, 1=Allow only); plus
  `layout_match`, `layout_prefix`, `layout_regex`, `layout_negate` (all default `''`/false).
- **Matching for BOTH lists uses `system_match`/`system_prefix`/`system_regex`.** As of
  1.0.x the Layout Builder hook reads those same system patterns and only `layout_negate` is
  distinct — the `layout_match`/`layout_prefix`/`layout_regex` values are saved but not used
  by the alter hooks.
- Match = exact plugin id; Prefix = `prefix:` at start of id; Regex = `preg_match` pattern.
- Blocks already placed in Layout Builder sections are never removed.
- Settings route `block_list_override.settings` → `/admin/config/block_list_override/settings`;
  preview routes `/admin/config/block_list_override/system-list` and `/layout-list`.
  Permission: `access block list override`. No Drush.

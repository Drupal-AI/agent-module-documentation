<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Override Inspector (COI) — agent index

Flags config-form fields whose value is **overridden** (e.g. by `settings.php`), and can
disable/hide them and show the override. Reads the `#config['key']` hints added by
`config_override_core_fields` (its dependency), splits `config.object:key`, and checks
`Config::hasOverrides()`. All behavior is driven by one config object **`coi.settings`**.
Settings UI at `/admin/config/user-interface/coi` (configure route `coi.settings`, perm
`administer config override inspector`).

- **`coi.settings` keys and how to configure behavior/message/value/styling** →
  [configure/settings.md](configure/settings.md)
- **How the form alter detects & handles overrides (hasOverrides, disable/noaccess, tokens,
  theme)** → [api/mechanism.md](api/mechanism.md)

Key facts:
- `override_behavior`: `disable` (default) | `noaccess` | `''` (indicator only).
- An override is what `settings.php` `$config[...][...] = …` (or any config override) sets;
  COI shows/blocks the field only when `hasOverrides()` is TRUE for that key.
- Provides tokens `coi:active-value` (pre-override value) and `coi:overridden-value`, and the
  `coi_container` theme. Depends on `config_override_core_fields`; suggests `token`.

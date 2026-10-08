<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Formatters — agent index

Create reusable Field Formatters from the admin UI using PHP / Twig / HTML+Token snippets (or a preset),
each stored as a `formatter` config entity and surfaced in Field UI *Manage display*. Depends on core
`field` + `field_ui`. Managed at `admin/structure/formatters` (`configure` route
`entity.formatter.collection`). Defines two plugin types.

- **Create/manage a formatter, the config-entity shape, engines, per-instance settings** →
  [configure/formatters.md](configure/formatters.md)
- **The two plugin types (`custom_formatters_formatter_type`, `custom_formatters_formatter_extras`) and how to add an engine** →
  [plugins/formatter-types.md](plugins/formatter-types.md)
- **Permissions (single `administer custom formatters`) and access handlers** →
  [permissions/permissions.md](permissions/permissions.md)
- **Hooks / the `$settings` + `_raw` contract passed to engines** →
  [api/hooks.md](api/hooks.md)

Key facts:
- Config entity `formatter` (prefix `custom_formatters.formatter.`): `id`, `label`, `type` (engine),
  `description`, `field_types`, `data` (code/config blob). `bundle_of = formatter_setting`.
- Engines (`Plugin/CustomFormatters/FormatterType`): `php` (**`eval()`**), `twig` (Twig `createTemplate`),
  `html_token` (`HTMLToken`), `formatter_preset` (wraps a core formatter).
- Field UI bridge: `Plugin/Field/FieldFormatter/CustomFormatters` + `Plugin/Derivative/CustomFormatters`
  (one derivative per config entity).
- Per-instance settings: `FormatterSetting` content entity bundled by the formatter → `$settings` /
  `$raw_settings` (`_raw`).
- **Security:** the PHP/Twig engines run arbitrary code; all gated by `administer custom formatters` —
  grant it only to fully trusted administrators.

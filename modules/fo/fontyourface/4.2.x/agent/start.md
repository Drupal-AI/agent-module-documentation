# @font-your-face (fontyourface) — agent start

Web font management for Drupal 11. Core module = the framework (entities, admin UI, render
integration); it ships **no fonts**. Each font source is a **provider submodule** that
implements a small hook API. Requires `taxonomy` + `views`. Configure route: `font.settings`
(`/admin/appearance/font/settings`). One permission: `administer font entities`.

Key data model:
- `font` — content entity (base table `fontyourface_font`), one per imported font-variant,
  keyed by `url` + provider `pid`; carries css_family/style/weight, foundry, designer,
  license, tags and serialized `metadata`.
- `font_display` — config entity binding an enabled font to CSS `selectors`, a `fallback`
  stack and a `theme`; generates a CSS file attached via a built library.
- `fontyourface.settings` — `enabled_fonts` (list of activated font URLs), `load_all_enabled_fonts`, `load_on_themes`.

Capabilities:
- [Configure, import & apply fonts](configure/configure.md) — settings form, enabling fonts, font_display rules, config keys.
- [Provider hook API](hooks/hooks.md) — `hook_fontyourface_api`, `hook_fontyourface_import`, `hook_fontyourface_font_css`; how to build a provider.
- [Entity & helper API](api/api.md) — `Font` entity methods and the `fontyourface_*()` helper functions.

Provider submodules (documented separately under `modules/`): `local_fonts`,
`google_fonts_api`, `typekit_api`, `adobe_edge_fonts`, `fontscom_api`, `fontsquirrel_api`.

No Drush commands. No plugin manager — extension is via the hooks above, not a plugin type.

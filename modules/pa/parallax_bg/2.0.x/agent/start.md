# Parallax Background — agent index

Applies a jQuery vertical parallax effect to any element's background, driven by `parallax_element`
config entities that map a jQuery selector → position + speed. Enabled elements are emitted to
`drupalSettings.parallax_bg` on every page. Core-only deps. Permission: `administer parallax elements`.

- **The `parallax_element` config entity, its fields, admin route, and how settings reach the JS** →
  [configure/element.md](configure/element.md)
- **`hook_parallax_bg_settings_alter()` for programmatically changing parallax settings** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- Config entity `parallax_element` (`config_prefix: parallax_element`); admin permission
  `administer parallax elements`. Collection route `entity.parallax_element.collection`
  → `/admin/structure/parallax_element` (also the `configure` link).
- Entity fields: `label` (a jQuery selector), `description`, `position` (`0`/`50%`/`100%`),
  `speed` (0–3 step 0.1), plus status.
- `parallax_bg_page_attachments()` loads enabled elements → `drupalSettings.parallax_bg` +
  library `parallax_bg/parallax_bg`; cache tag `config:parallax_element_list`.
- Bundled jQuery plugins: `jquery.parallax-1.1.3.js`, localScroll, scrollTo (`parallax_bg/parallax`).

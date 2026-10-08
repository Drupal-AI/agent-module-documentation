# Footermap — agent index

One block plugin that renders a recursive HTML sitemap of your menus, for the footer. Depends on
`menu_ui`. No config page (`configure` null), no permissions, no Drush. Config lives in the block
instance.

- **Block settings (menus, depth, heading, sub-tree root) + where they're stored** →
  [configure/block.md](configure/block.md)
- **Theme hooks, templates, and preprocess (customizing markup)** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Block plugin id `footermap_block` (`src/Plugin/Block/FootermapBlock.php`), category *Sitemap*.
- Access is checked as the **anonymous** user via `AnonymousMenuLinkTreeManipulator` +
  `footermap.anonymous_user` (an `AnonymousUserSession`): the map only ever shows links a logged-
  out visitor could reach. This is deliberate — keeps the block cacheable, avoids leaking
  restricted links; it also means per-user links never appear. Cache context: `languages`.
- Settings schema `block.settings.footermap_block` (`config/schema/footermap_block.schema.yml`).
- Tree built via core `menu.link_tree` with `onlyEnabledLinks()` + `excludeRoot()`.

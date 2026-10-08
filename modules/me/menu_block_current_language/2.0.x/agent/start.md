# Menu Block Current Language — agent index

Drop-in replacement for core's menu block that hides menu links with no translation for the current
content language. One block plugin (`menu_block_current_language`, deriver = one per menu), extends core
`SystemMenuBlock`. No config page (`configure` null), no permissions, no Drush. Depends on `block` +
`locale`. Provides a block config schema.

- **Place & configure the block, the `translation_providers` setting, how filtering works** →
  [configure/block.md](configure/block.md)
- **The `HasTranslationEvent`, `MenuLinkTranslatableInterface`, and per-link-type detection for extending it** →
  [api/events.md](api/events.md)

Key facts:
- Block id `menu_block_current_language` (admin category "Menu block current language"); one derivative per menu.
- Filtering runs as tree manipulator `menu_block_current_language_tree_manipulator::filterLanguages`, marking
  untranslated links `AccessResult::forbidden()`.
- Default providers on: `views`, `menu_link_content`; off: `default` (string translation, experimental).
- Adds `block__system_menu_block` template suggestion so core menu templates still apply.

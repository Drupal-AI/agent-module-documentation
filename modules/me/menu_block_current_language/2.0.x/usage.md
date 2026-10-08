Menu Block Current Language provides a drop-in replacement for core's System menu block that hides any menu link which has no translation for the current interface/content language.

---

The module ships one block plugin, `menu_block_current_language`, that extends core `SystemMenuBlock` (deriver-based, one derivative per menu) and adds a `translation_providers` checkbox setting to the block config form. When the block builds its tree it runs the standard core manipulators (`checkAccess`, `generateIndexAndSort`) and then its own `menu_block_current_language_tree_manipulator::filterLanguages`, which walks the tree and marks any link without a translation for the current content language as `AccessResult::forbidden()`. Translation is detected per link type: `MenuLinkContent` entities are checked with `hasTranslation()`, Views menu links are checked against the view's language config override, string-translated `MenuLinkDefault` titles are looked up in `locale` string storage, and custom links may implement `MenuLinkTranslatableInterface`. Each check is also dispatched as a `HasTranslationEvent` (`menu_block_current_language.has_translation`) so other modules can override the decision. Which core providers participate is controlled by the block's `translation_providers` setting (`menu_link_content` and `views` on by default, experimental `default`/string-translation off). The module has no admin settings page (`configure` is null), no permissions, and no Drush commands; you use it purely by placing its block instead of the core menu block. A `hook_theme_suggestions_block_alter` adds the `block__system_menu_block` template suggestion so existing menu block templates keep working.

---

- Replace a core menu block with one that hides untranslated links on a multilingual site.
- Show a language switcher-friendly main menu where each language only lists its own translated items.
- Hide `menu_link_content` (custom menu) links that lack a translation in the active language.
- Hide Views-provided menu links when the view has no config translation for the current language.
- Hide string-translated (`MenuLinkDefault`) links whose title has no locale translation (experimental provider).
- Keep default (non-translatable) links always visible while filtering the translatable ones.
- Enable or disable filtering per link-type provider from the block configuration form.
- Place multiple filtered menu blocks (main menu, footer, account) each with their own provider settings.
- Preserve expanded/child menu items while still filtering untranslated descendants.
- Use per-block start level and depth (inherited from core menu block) together with language filtering.
- Let a custom menu link plugin declare its own translation state via `MenuLinkTranslatableInterface::hasTranslation()`.
- React to the `HasTranslationEvent` from another module to force a link visible or hidden.
- Override visibility for links pulled from an external source by subscribing to `menu_block_current_language.has_translation`.
- Provide a footer menu that collapses to only the current language's links.
- Avoid showing dead/duplicate menu entries for content that exists only in the default language.
- Reuse existing `block__system_menu_block` Twig templates for the filtered block (automatic template suggestion).
- Migrate an existing site to language-aware menus without writing custom access logic.
- Combine with core Language negotiation so the visible menu tracks the resolved content language.
- Keep admin menus intact while filtering only front-end navigation menus.
- Debug translation coverage by toggling providers and observing which links disappear per language.

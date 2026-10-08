<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Multilingual adds two per-block options to menu blocks that hide menu links which lack a translated label, or which point to untranslated content, in the current interface language.

---

The module hooks into the render of `system_menu_block` and `menu_block` (the contrib Menu block) instances and adds two checkboxes to the block configuration form, stored as **third-party settings** on the block config entity (`block.block.<id>.third_party.menu_multilingual`): `only_translated_labels` ("Hide menu items without translated label") and `only_translated_content` ("Hide menu items without translated content"). When either is on, a pre-render callback on the block (the `menu_multilingual.modifier` service, a `TrustedCallbackInterface`) walks the built menu tree and removes links that fail the check for the current language. For labels it checks whether the `menu_link_content` entity (or a `ViewsMenuLink`'s view config) has a translation in the current language; for content it loads the entity the link routes to and keeps it only if its langcode matches the current language or it has a translation. Special cases: entities with language "Not applicable" (`zxx`) or non-translatable entities are always kept, entities with "Not specified" (`und`) are always filtered as untranslated, and when a menu item is filtered all of its children are removed too. If both options are enabled a link must satisfy both. The module requires `menu_link_content` and `content_translation`, integrates out of the box with the Menu block and Context modules, and provides no admin page, permissions, or Drush commands — everything is configured per menu block. Remember to clear caches after changing menu items or block settings.

---

- Hide menu links whose label has not been translated into the current language.
- Hide menu links that point to a node with no translation in the current language.
- Keep a language switcher's menu clean by dropping untranslated destinations.
- Show a language-specific main menu without maintaining separate menus per language.
- Prevent visitors from clicking a menu item that leads to content they can't read in their language.
- Apply the filter only to a specific menu block instance, leaving others untouched.
- Combine both options so a link needs a translated label AND translated content to appear.
- Use it with the contrib Menu block module's blocks (`menu_block`).
- Use it with core's system menu blocks (`system_menu_block`).
- Automatically hide child menu items when their parent is filtered out.
- Always keep links to "Not applicable" (`zxx`) or non-translatable entities regardless of language.
- Always hide links to "Not specified" (`und`) content as untranslated.
- Filter `ViewsMenuLink` items based on whether the view has a config translation for the language.
- Provide a footer menu that only lists pages available in the visitor's language.
- Reduce broken or fallback-language navigation on a partially translated site.
- Keep a per-region menu (via Context) filtered by language.
- Avoid custom preprocess code for language-aware menus by toggling two checkboxes.
- Ensure a translated site's menus degrade gracefully during an in-progress translation effort.
- Reuse the `menu_multilingual.modifier` service in custom code to filter a menu render array.
- Hide untranslated taxonomy/term or user links referenced from a menu.
- Present editors a single menu structure while visitors see language-appropriate subsets.
- Stop showing menu entries for content whose translation was unpublished/removed.
- Enforce language-consistent navigation across multiple menu blocks on a page.

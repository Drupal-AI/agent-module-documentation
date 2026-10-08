<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# babel_menu_link_content — the menu_link_content translation-type plugin

## Plugin
`Plugin\Babel\TranslationType\MenuLinkContent` (`#[TranslationType(id: 'menu_link_content', label: 'Menu Link
Content')]`), extends `TranslationTypePluginBase`, implements `PluginFormInterface`. Source id encodes
`<menu>:<uuid/field>`; strings come from custom `menu_link_content` entities (title, description, …).

## Configuration
No dedicated route — the plugin contributes a subform to the main Babel settings form
(`/admin/config/regional/babel/settings`). It limits which menus are harvested: schema
`translation_type.menu_link_content` → `menu` sequence, each value constrained `ConfigExists: system.menu.`.
Empty `menu` = all custom menus.

## Harvesting (`BabelMenuLinkContentService`)
`batchAddSources()` iterates custom menu links and records their translatable string properties as Babel
`Source` objects. `EXCLUDED_FIELDS` skips `created`, `changed`, all `content_translation_*` keys,
`default_langcode`, `langcode`, `revision_translation_affected`. System-provided menu links are excluded
(see `update_8002`, which cleaned up previously leaked `system.menu.*` links).

## Save path
`updateTranslation()` writes the translated title/description back to the menu link entity as a
`content_translation` entity translation (author = current user), mirroring the `babel_content_entity`
approach. Nothing menu-related is stored in Babel beyond the index/status/lock rows.

## Install/update
- `hook_install` → `batchAddSources()`.
- `update_8002` removes links from unsupported/system menus from the backend.
- `update_8003` deletes and re-seeds `menu_link_content` sources to clear historical duplicates.

## Operational note
As with `babel_content_entity`, menu link labels become editable by any user holding Babel's
`translate interface` permission, bypassing the menu link's own edit form. Restrict exposed menus accordingly.

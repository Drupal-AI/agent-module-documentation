<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel Custom Menu Links (babel_menu_link_content) — agent index

Babel submodule. Depends on **babel** and core **menu_link_content**. Core `^10.4 || ^11.1 || ^12`.

Exposes custom menu link (`menu_link_content`) titles/descriptions as translatable UI strings in Babel.
Translations are stored as native `content_translation` entity translations. No settings route of its own —
configured via a subform on the main Babel settings page.

## Provides
- **Translation-type plugin `menu_link_content`** — `Plugin\Babel\TranslationType\MenuLinkContent`,
  implements `PluginFormInterface`. Config subform limits exposure to selected menus
  (schema `translation_type.menu_link_content` → `menu` sequence, constrained `ConfigExists: system.menu.`).
- **Service** `BabelMenuLinkContentService` — `batchAddSources()` harvests menu link string properties into
  the Babel index; `EXCLUDED_FIELDS` skips langcode/metadata keys. `BabelMenuLinkContentBatchHelper`.
- **Hook service** `Hook\BabelMenuLinkContentHook`; own `logger.channel.babel`.
- **Install/update hooks** (`babel_menu_link_content.install`): `hook_install` seeds sources;
  `update_8002` removes leaked system-menu links; `update_8003` de-duplicates and re-seeds sources.

## Solution docs
- `agent/plugins/menu-link-content.md` — the plugin, harvesting, menu limiting, save path.

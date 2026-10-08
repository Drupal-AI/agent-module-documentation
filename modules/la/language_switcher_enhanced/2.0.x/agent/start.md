<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Switcher Enhanced (language_switcher_enhanced) — agent index

A drop-in replacement for core's language switcher **block** with configurable label display,
HTML structure, per-language soft-hiding, and untranslated-target handling. Version **2.0.4**,
core `^8 || ^9 || ^10 || ^11`, PHP >= 7.1. Depends only on core `language`. No config route —
everything is set per block on the block form.

## Mechanism
- Provides one block plugin `language_switcher_enhanced_block` ("Enhanced language switcher") in
  `src/Plugin/Block/LanguageSwitcherEnhancedBlock.php`. It **extends core `LanguageBlock`** and
  reuses core's `LanguageManager::getLanguageSwitchLinks()`, so links point at the equivalent path
  for the current route (or `<front>` on the front page). The block uses the same
  `LanguageBlock` deriver, so it is derived per language-negotiation type.
- `build()` gets the links, applies `changeLinksAreTranslated()`, `filterHiddenLanguages()`,
  then `structureLinks()`, and renders `#theme => language_switcher__<structure>`.
- A kernel `VIEW` event subscriber (`src/EventSubscriber/LanguageSwitcherEnhancedKernelViewSubscriber.php`,
  priority 1) removes the core `language_block:*` rows from the Block layout
  (`block.admin_library`) and Context (`context.reaction.blocks.library`) place-block listings so
  admins pick the enhanced block instead. It does not disable the core block, only hides it in
  those two UIs.

## Block settings (stored in block config; schema in config/schema)
- **display**: `translated` (default, translated language name) | `id` (langcode) | `native`
  (native name).
- **structure**: `list` (flat `<ul>`) | `nested` (dropdown, active on top, active NOT repeated in
  menu) | `nested_active` (default; dropdown, active on top and repeated in menu).
- **use_bootstrap** (default on): attaches the bundled `language_switcher_enhanced/bootstrap`
  library (a trimmed Bootstrap CSS/JS slice under `lib/`) so the dropdown works without theme CSS.
  Turn off to style from the theme.
- **hidden_languages**: checkbox list of langcodes hidden from users lacking the
  `see hidden languages switcher` permission. **Soft, presentation-only** — the form itself says it
  "Will not redirect unauthorized users"; it does not restrict access to those translations.
- **not_translated**: `default` (leave core's link) | `homepage` (repoint link to that language's
  front page — a link change, NOT an HTTP redirect) | `disabled` (render as `<nolink>`). Only
  applied on **content-entity canonical routes** (`entity.*.canonical` with a `ContentEntityInterface`
  parameter); on any other route the links are core's unchanged. Note: `defaultConfiguration()`
  seeds this as `FALSE`, which behaves like `default` until the block is saved.

## Permission
- `see hidden languages switcher` (`language_switcher_enhanced.permissions.yml`) — users with it see
  languages listed in **hidden_languages**; everyone else has them filtered out.

## Theming
- `hook_theme` registers `language_switcher` plus a variant per structure key
  (`language_switcher__list`, `__nested`, `__nested_active`). Templates in `templates/`. Dropdown
  templates use Bootstrap markup (`.dropdown`, `.dropdown-menu`, `data-toggle`).

## Where to look
- Block logic / all settings, options, and untranslated handling: `src/Plugin/Block/LanguageSwitcherEnhancedBlock.php`
- Core-block hiding in admin UIs: `src/EventSubscriber/LanguageSwitcherEnhancedKernelViewSubscriber.php`
- Config schema: `config/schema/language_switcher_enhanced.schema.yml`
- Detailed configuration reference: `agent/config/block-settings.md`

## Notes / gotchas
- No standalone settings form or `configure` route — configure by placing the block and editing its
  settings.
- The untranslated-target logic is entity-canonical-only; on views, taxonomy term pages routed
  differently, or custom routes it will not disable/redirect missing-translation links.
- `use_bootstrap` loads a bundled Bootstrap slice that can collide with a theme's own Bootstrap;
  disable it when the theme already provides dropdown behaviour.

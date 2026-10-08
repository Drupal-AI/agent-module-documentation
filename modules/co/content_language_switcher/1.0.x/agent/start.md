<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Language Switcher (content_language_switcher) — agent index
**Adds an inline translation language switcher to content-entity edit forms, improving the content-translation admin UX.**

- **info.yml name:** `Content Language Switcher` · **Exact version:** `1.0.1` · **Package:** Multilingual
- **Core:** `^8.7.7 || ^9 || ^10 || ^11`
- **Depends on:** `content_translation`
- **Purpose:** Not a front-end language switcher block. It replaces the separate "Translate" tab with an inline switcher rendered in the entity edit-form sidebar, so editors move between an item's translations (or start a missing one) without leaving the form.

## Mechanism (source-grounded)
- `hook_entity_type_alter` (`.module`): sets a `content_language_switcher` handler class (`ContentLanguageSwitcherHandler`) on every translatable entity type that lacks one.
- `hook_module_implements_alter`: pushes this module's `entity_type_alter` and `form_alter` to the end of the implementation list so it runs late.
- `hook_form_alter`: for `ContentEntityFormInterface` forms of a translatable, non-new entity on the `edit`/`add`/`default` op, calls `ContentLanguageSwitcherHandler::entityFormAlter()`.
- `entityFormAlter()` (`src/ContentLanguageSwitcherHandler.php`): builds a `content_language_switcher` container whose `#access` is `content_translation` handler `getTranslationAccess($entity, 'update')->isAllowed()`, iterates all enabled languages, and for each records name/langcode/URL plus `is_new` (no translation yet) and `is_outdated` markers. Renders via the `content_language_switcher` theme hook; grouped into the form `meta` region when present.
- `hook_local_tasks_alter`: removes the `*.content_translation_overview` local tasks (the "Translate" tab).
- **Theme:** `content_language_switcher` (`content_language_switcher_theme()`), template `templates/content-language-switcher.html.twig`; variables `current_language` and `languages` (Twig auto-escaped).

## Surface
- No routes, no menu items, no permissions, no config, no config schema, no services, no Drush. Only hooks + one entity handler + one theme/template.
- One functional test: `tests/src/Functional/LoadTest.php` (front page loads with module enabled).

**Security:** UX-only form alter. No routes, permissions, forms, or mutating endpoints of its own; the in-form switcher is gated by core Content Translation's `getTranslationAccess(..., 'update')`, and target links resolve to core content-translation routes that enforce their own access. Labels/URLs render through Twig auto-escaping. No anonymous surface.

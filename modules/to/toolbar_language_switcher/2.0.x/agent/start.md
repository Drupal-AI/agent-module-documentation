<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Language Switcher — agent index

Adds a language switch item to the core admin **toolbar**. Configuration-free. Depends on core
`language` and `toolbar`.

- **How it renders, the permission, the service, and enabling it** →
  [api/toolbar.md](api/toolbar.md)

Key facts:
- Implements `hook_toolbar()`; renders only for users with permission **`use toolbar_language_switcher`**.
- Adds a `toolbar_item` (`admin_toolbar_langswitch`) with a language icon tab + a tray of switch links.
- Links come from `\Drupal::languageManager()->getLanguageSwitchLinks(LanguageInterface::TYPE_INTERFACE, <current URL>)`.
- Service **`tls.render.builder`** (`RenderBuilder`) builds the render arrays (args:
  `@language_manager`, `@current_route_match`, `@renderer`).
- **No settings, no configure route, no config schema, no Drush, no plugins.** The only state is the
  permission grant and how many languages are enabled.

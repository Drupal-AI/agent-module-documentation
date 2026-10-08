<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Administration Toolbar - Content languages (admin_toolbar_content_languages) — agent index

Adds one extra **"Add content" link per enabled language** under each content type in the **Admin Toolbar**,
for content types whose default language is *"Interface text language selected for page"*. Package
`Administration`. Version dir `2.0.x` (release 2.0.1). Core `^10 || ^11`.

Depends on **`admin_toolbar:admin_toolbar`**, **`admin_toolbar:admin_toolbar_tools`**, and core
**`language`** (composer also requires `drupal/admin_toolbar ^2.0 || ^3.0`).

- **The `hook_menu_links_discovered_alter` link generation, eligibility rule and link structure** →
  [config/menu-links.md](config/menu-links.md)

## What it actually is

- **No config, no schema, no permissions, no routes, no plugins, no Drush.** One hook class only:
  `AdminToolbarContentLanguagesHooks` (`src/Hook/`, autowired service).
- `#[Hook('menu_links_discovered_alter')]` `menuLinksDiscoveredAlter(&$links)` — adds definitions keyed
  `node.add.{bundle}.{langprefix}` for every enabled language, parented to the Admin Toolbar Tools link
  `admin_toolbar_tools.extra_links:node.add.{bundle}`, route `node.add` with `node_type = {bundle}` and
  `options.language = {language object}`.
- `#[Hook('help')]` `help()` — help text on `help.page.admin_toolbar_content_languages`.
- Both hooks have `#[LegacyHook]` shims in the `.module` delegating to the service.

## Mechanism (from source)

- Returns early if `languageManager->getNativeLanguages()` has **≤ 1** language.
- Runs only when `node` is enabled; iterates `entity_type.bundle.info`→`getBundleInfo('node')`.
- Per bundle, only adds links when
  `config('language.content_settings.node.{bundle}')->get('default_langcode') === 'current_interface'`
  (the *"Interface text language selected for page"* option).
- Link title is `"{bundle label} ({language native name})"`; per-language `weight` preserves Languages
  ordering. Links are regenerated on menu rebuild (cache clear).
- Titles/labels come from content-type labels and language names and are rendered through the core menu
  system, which escapes link text.

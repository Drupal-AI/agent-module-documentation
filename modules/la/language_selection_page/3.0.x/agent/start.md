<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Selection Page (language_selection_page) — agent index

Adds a **language negotiation method** (`language-selection-page`) that, instead of guessing a
langcode, shows the visitor a splash page to pick one. The negotiation plugin always returns `FALSE`
(never decides), so the real work is done by a response **event subscriber**
(`LanguageSelectionPageSubscriber`, priority `-50` on `KernelEvents::RESPONSE`): on a page where no
higher-priority method resolved a language, it issues a `RedirectResponse` to the module's own page
at `?destination=<the path you were visiting>`. That page (a **dynamic route** named
`language_selection_page`, path taken from config) renders one link per native language, each pointing
at the stored destination in that language, so the click both sets the language and continues to the
originally-requested page. Whether the redirect fires at all is decided by a chain of
**condition plugins** (a real plugin type, `LanguageSelectionPageCondition`) — any one that "blocks"
aborts the redirect (e.g. on `/admin`, on AJAX, on CLI, when languages lack URL prefixes, when the
current path is invalid).

Configuration is **not** a standalone settings form of its own package: you enable the "Selection
Page" method in the core negotiation chain at `/admin/config/regional/language/detection`, and tune
its title / path / mode / blacklist at
`/admin/config/regional/language/detection/language_selection_page`. All settings live in the single
config object `language_selection_page.negotiation`.

- Depends on: `drupal:locale`, `drupal:path_alias`.
- Core: `^10 || ^11`. Package: `Multilingual`. Version **3.0.x** (3.0.0).
- `configure` route = `language.negotiation` (info.yml). No permissions of its own — admin routes use
  core `administer languages`; the public page uses core `access content`.
- Provides **config schema**, a **plugin type** (`LanguageSelectionPageCondition`), a **block**
  (`language-selection-page`), a **language negotiation plugin**, a **theme hook**. No drush.
- Requires all enabled languages to have a **URL prefix** to work (see `hook_requirements`).

## What you'd do → where

- **Turn it on, set the path/title/mode, exclude paths** → [configure/negotiation.md](configure/negotiation.md)
- **Understand the redirect mechanism, the dynamic route, services, block, theme/template** →
  [api/internals.md](api/internals.md)
- **Write a custom condition (change when/where the page appears) or alter the destination** →
  [plugins/condition.md](plugins/condition.md)

## Key facts (real machine names)

- Static routes: `language_selection_page.negotiation_selection_page`
  (`/admin/config/regional/language/detection/language_selection_page`, `_form`
  `NegotiationLanguageSelectionPageForm`, `_permission: administer languages`);
  `language_selection_page.negotiation_language_selection_page_legacy_d7_redirect`
  (`/admin/config/regional/language/configure/selection_page` → redirects to the form).
- Dynamic route (via `route_callbacks` → `LanguageSelectionPageRouteController::routes`):
  name `language_selection_page`, path = config `path` (default `/language_selection_page`),
  `_controller` `LanguageSelectionPageController::main`, `_permission: access content`.
- Services: `plugin.manager.language_selection_page_condition`
  (`LanguageSelectionPageConditionManager`), `language_selection_page.language_selection_page_subscriber`
  (`LanguageSelectionPageSubscriber`), `language_selection_page_controller`
  (`LanguageSelectionPageController`).
- Language negotiation plugin id: `language-selection-page`
  (`LanguageNegotiationLanguageSelectionPage::METHOD_ID`), config_route
  `language_selection_page.negotiation_selection_page`, type `TYPE_INTERFACE`, weight `-4`.
- Block plugin id: `language-selection-page` (`LanguageSelectionPageBlock`).
- Plugin type: `LanguageSelectionPageCondition` — manager service
  `plugin.manager.language_selection_page_condition`, dir `Plugin/LanguageSelectionPageCondition`,
  interface `LanguageSelectionPageConditionInterface`, base `LanguageSelectionPageConditionBase`,
  annotation `Annotation\LanguageSelectionPageCondition`, alter hook
  `language_selection_page_condition_info`. Bundled ids: `title`, `path`, `path_is_valid`,
  `language_prefixes`, `method_is_valid`, `php_sapi`, `xml_http_request`, `type`, `index`,
  `blacklisted_paths`, `ignore_neutral`.
- Theme hook: `language_selection_page_content` (template
  `templates/language-selection-page-content.html.twig`; vars `destination`, `configure_url`,
  `language_links`).
- Config object: `language_selection_page.negotiation` — keys `title`, `path`, `type`,
  `blacklisted_paths`, `ignore_neutral`.
- Hooks implemented: `hook_theme`, `hook_help`, `hook_requirements`, `hook_uninstall`.

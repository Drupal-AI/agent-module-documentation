<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar item, permission & rendering

## Enabling it (there is nothing to configure)

The module has no settings form or config. To make the switcher appear:

1. Enable `language` and `toolbar` (dependencies) and have **more than one language** enabled
   (`/admin/config/regional/language`) — otherwise there is nothing to switch to.
2. Grant the permission **`use toolbar_language_switcher`** to the roles that should see it
   (`/admin/people/permissions`).

```bash
drush role:perm:add editor 'use toolbar_language_switcher'
drush php:eval 'ConfigurableLanguage::createFromLangcode("es")->save();'  # add a language
```

## How it renders

`toolbar_language_switcher_toolbar()` (implements `hook_toolbar()`):

```php
if ($user->hasPermission('use toolbar_language_switcher')) {
  return \Drupal::service('tls.render.builder')->build();
}
return [];
```

`RenderBuilder::build()` (service `tls.render.builder`, args `@language_manager`,
`@current_route_match`, `@renderer`):

- Gets switch links: `languageManager->getLanguageSwitchLinks(LanguageInterface::TYPE_INTERFACE,
  Url::fromRouteMatch($current_route_match))` — the same interface-language switch links the core
  Language Switcher block uses, for the current page.
- Builds `$items['admin_toolbar_langswitch']` as a `#type => toolbar_item` with:
  - a **tab** (`html_tag`) carrying the language icon classes (`toolbar-icon toolbar-icon-language`)
    and attaching the `toolbar_language_switcher/toolbar` library;
  - a **tray** themed as `links` (`#theme => links`, class `toolbar-menu`) listing the switch links,
    when there is more than one language.

Because it delegates to core switch links, it automatically respects language negotiation and the
configured language URL scheme (path prefix / domain).

## Notes

- No plugin types, hooks API, or Drush commands are provided.
- Icons live in `misc/icons/*/language-24px.svg`; styling in `css/tls.icons.theme.css`.

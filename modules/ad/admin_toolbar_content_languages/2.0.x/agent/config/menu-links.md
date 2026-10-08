<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The per-language "Add content" menu links

## Install & enable

```bash
composer require drupal/admin_toolbar_content_languages
drush en admin_toolbar_content_languages -y
drush cr
```

Requires **`admin_toolbar`**, **`admin_toolbar_tools`** and core **`language`** (all pulled in as
dependencies). There is **nothing to configure** in this module — no settings form, no config object, no
permissions. All behavior comes from one hook.

## Prerequisite you set elsewhere

The links only appear for a content type when its **default language** is set to *"Interface text language
selected for page"*:

- UI: *Structure → Content types → {type} → Edit → Language settings* → **Default language** =
  *"Interface text language selected for page"*.
- Config: `language.content_settings.node.{type}:default_langcode = current_interface`.

You also need **more than one enabled language** (*Configuration → Regional and language → Languages*).

## How the links are generated

Class `Drupal\admin_toolbar_content_languages\Hook\AdminToolbarContentLanguagesHooks` (autowired service,
injected `module_handler`, `language_manager`, `entity_type.bundle.info`, `config.factory`,
`string_translation`).

`#[Hook('menu_links_discovered_alter')] menuLinksDiscoveredAlter(&$links)`:

1. `languages = languageManager->getNativeLanguages()`. If `count($languages) <= 1`, **return** (nothing to do).
2. If `node` module is not enabled, do nothing.
3. For each node bundle from `entityTypeBundleInfo->getBundleInfo('node')`:
   - Read `configFactory->get('language.content_settings.node.{bundle}')->get('default_langcode')`.
   - Only if it equals `'current_interface'`, loop the enabled languages (with an incrementing `$weight`
     starting at 0) and add a link definition:

   ```php
   $links['node.add.' . $bundle . '.' . $prefix] = [
     'title' => $info['label'] . ' (' . $language->getName() . ')',
     'route_name' => 'node.add',
     'menu_name' => 'admin',
     'parent' => 'admin_toolbar_tools.extra_links:node.add.' . $bundle,
     'route_parameters' => ['node_type' => $bundle],
     'options' => ['language' => $language],
     'weight' => $weight,
   ];
   ```

Result: under *Content → Add content → {Type}* in the Admin Toolbar, one child link per language, e.g.
*"Article (French)"* pointing at `node.add` (`/fr/node/add/article`) because `options.language` sets the URL
language prefix.

## Notes

- The parent key `admin_toolbar_tools.extra_links:node.add.{bundle}` is provided by **Admin Toolbar Tools**;
  if that structure changes or the bundle has no such parent, the child links have nowhere to attach.
- Links are (re)built during menu discovery — run `drush cr` after enabling the module, adding a language,
  adding a content type, or changing a type's default-language option.
- `title` uses the language's **native** name (`$language->getName()` on the native-languages list) and the
  bundle label; the core menu link renderer escapes this text.
- No access logic is added here: each link targets the normal `node.add` route, whose own
  `_entity_create_access:node` requirement still governs who may follow it.
- `help()` (`#[Hook('help')]`) only returns About text on `help.page.admin_toolbar_content_languages`.

## Verifying

```bash
# Make a type follow the interface language, then rebuild menus:
drush cset language.content_settings.node.article default_langcode current_interface -y
drush cr
```

Open any admin page as a user with *access toolbar* and expand *Content → Add content → Article*; the
per-language children should be listed (only when ≥ 2 languages are enabled).

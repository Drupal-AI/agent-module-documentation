# Configure Language Switcher Menu

Route `language_switcher_menu.configure` → path `/admin/config/regional/language_switcher_menu`
(`SettingsForm`, `ConfigFormBase`), permission `configure language_switcher_menu`.

## Config object: `language_switcher_menu.settings`

| Key | Type | Meaning |
|---|---|---|
| `type` | string | Language type id used to build the switch links. Options come from `LanguageManager::getLanguageTypes()` — typically `language_interface` (and `language_content`, `language_url` when those are configurable). Required. |
| `parent` | string | `"<menu_name>:<parent_plugin_id>"`. Links are added below that parent; use `"<menu_name>:"` to add at the root of a menu. **Empty string = *Disabled*** (module produces no links). The module's own links are filtered out of the parent options. |
| `weight` | integer | Menu weight of the *first* language link; each additional link gets +1. |

Set it with Drush instead of the UI:

```bash
ddev drush cset language_switcher_menu.settings type language_interface -y
ddev drush cset language_switcher_menu.settings parent 'main:' -y     # root of the "main" menu
ddev drush cset language_switcher_menu.settings weight 0 -y
ddev drush cr    # rebuild so the deriver picks up the change
```

The settings form calls `MenuLinkManager::rebuild()` when any of `type`/`parent`/`weight` changes; if
you write config directly, run `drush cr` (or `drush php:eval "\Drupal::service('plugin.manager.menu.link')->rebuild();"`).

## Link generation (deriver)

`Plugin/Derivative/LanguageSwitcherLink::getDerivativeDefinitions()` returns **no links** unless:
- `\Drupal::languageManager()->isMultilingual()` is TRUE, **and**
- both `type` and `parent` are non-empty.

When it runs it creates one menu link per language from `LanguageManager::getLanguages()`, with
`route_name` `<current>`, the configured `menu_name`/`parent`/`weight`, and `metadata`
(`language`, `langcode`, `lang_type`). Plugin ids look like
`language_switcher_menu.language_switcher_link:<langcode>`.

## Visibility / access workaround (important)

Due to core issue [#3008889](https://www.drupal.org/project/drupal/issues/3008889) these links would
always be hidden. The module ships `LanguageLinkAccessMenuTreeManipulator` (see
`language_switcher_menu.services.yml`) which **overrides the core `menu.default_tree_manipulators`
service**. For its own links it returns
`AccessResult::allowedIfHasPermission($account, 'view language_switcher_menu links')` AND-ed with a
check that the target URL validates. So to actually see the links, roles need the
**`view language_switcher_menu links`** permission. Because it overrides a core service, it may be
incompatible with other modules that also override `menu.default_tree_manipulators`. This permission and
override are a temporary workaround the maintainer intends to remove once the core issue is fixed.

## Disable without uninstalling

Set `parent` to the empty *Disabled* option (`''`); the deriver then returns no links. Re-select a
parent to restore them.

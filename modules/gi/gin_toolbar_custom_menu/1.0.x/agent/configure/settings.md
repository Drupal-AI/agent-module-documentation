<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Toolbar Custom Menu settings

Route `gin_toolbar_custom_menu.settings` → `/admin/config/system/gin-toolbar-custom-menu`
(permission `configure gin toolbar custom menu`). Config object:
**`gin_toolbar_custom_menu.settings`** (schema is `config_object`, `FullyValidatable`).

## Config shape

```yaml
keep_admin_menu: 0        # 1 = also keep the original administration menu alongside the custom one
settings:                 # a sequence of rules
  - menu: main            # the menu whose tree replaces the toolbar's admin menu
    role:                 # roles this rule applies to
      - content_editor
    excluded_role: []     # roles that opt out even if they match `role`
    icons: {}             # per-menu-link toolbar icon overrides (link id => icon name)
    admin_menu: use_global # administration menu visibility for this rule: use_global | hidden | show
    actions: []
```

`menu` is a menu machine name (e.g. `main`, `admin`, `footer`, or a custom menu you created at
`/admin/structure/menu`). Each rule maps that menu to one or more roles.

## How a rule is applied

At render (`_gin_toolbar_custom_menu_get_setting()` + `hook_preprocess_navigation` /
`hook_toolbar_alter`): the current user's roles are matched against each rule's `role`; a matched
rule is dropped if the user also has one of its `excluded_role`s. For the surviving rule, the
Gin toolbar's `admin` menu items are replaced by the chosen `menu`'s tree (with toolbar icon
classes applied). IMPORTANT: assigned roles must ALSO have the core `access toolbar` ("Use
toolbar") permission or the toolbar won't show for them.

## Set it with drush

```php
$c = \Drupal::configFactory()->getEditable('gin_toolbar_custom_menu.settings');
$c->set('keep_admin_menu', 1)
  ->set('settings', [[
    'menu' => 'main',
    'role' => ['content_editor'],
    'excluded_role' => [],
    'icons' => [],
    'admin_menu' => 'use_global',
    'actions' => [],
  ]])
  ->save();
```

Read it back: `drush cget gin_toolbar_custom_menu.settings`. There is no `config/install`
default, so the object does not exist until the form is saved (or you write it).

## admin_menu visibility constants

`GinToolbarCustomMenuInterface::ADMIN_MENU_HIDDEN` (hide for this menu) and `ADMIN_MENU_SHOW`
(show for this menu); the default `use_global` defers to the global `keep_admin_menu`.

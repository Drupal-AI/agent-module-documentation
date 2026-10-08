<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form behavior & validation (menu_vs_url_alias.module)

All logic lives in procedural hooks in `menu_vs_url_alias.module`. No classes, services, or routes.

## `menu_vs_url_alias_form_alter(&$form, $form_state, $form_id)`
Two unrelated branches:
1. **Menu-link forms** — when `strpos($form_id, '_menu_link_content_form') !== FALSE` (matches e.g. `menu_link_content_menu_link_content_form`): sets `$form['description']['#access'] = FALSE` and `$form['weight']['#access'] = FALSE`, hiding those fields on every menu-link add/edit form. This applies globally, independent of `enabled_content_types`.
2. **Content-type edit form** — when `$form_id == 'node_type_edit_form'`: injects the `menu_vs_url_alias` `details` group + enable checkbox (see `agent/config/settings.md`), sets the checkbox default from config, and appends `_menu_vs_url_alias_submit` to `$form['actions']['submit']['#submit']`.

## `menu_vs_url_alias_form_node_form_alter(&$form, $form_state, $form_id)`
Runs on every node add/edit form. It reads the node's `bundle()` and checks membership in `enabled_content_types` via `array_search(...) !== FALSE`. When the bundle is governed:
- Adds body class `menu-url-alias-enabled` and pushes `_menu_vs_url_alias_validate` onto `$form['#validate']`.
- Detects new vs. existing node by `getEntity()->id() !== NULL`.
- **New node only:** `$form['menu']['enabled']['#default_value'] = 1` (menu on by default).
- Hides the path widget when the menu is enabled: `$form['path']['widget'][0]['#states']['invisible']` keyed on `:input[name="menu[enabled]"]` checked.
- Pathauto default set to `0` (off) and given `#states`: checked/invisible when menu enabled, unchecked/visible when menu disabled.
- Alias field: `#states` makes it `required` when `menu[enabled]` is unchecked.

These `#states` are client-side UI only; the authoritative gate is the validate handler below.

## `_menu_vs_url_alias_submit($form, $form_state)`
Content-type form submit handler. Adds/removes the current content type (`$form['type']['#default_value']`) in `menu_vs_url_alias.settings:enabled_content_types` and saves. Reached only through `node_type_edit_form`, which core gates behind `administer content types`.

## `_menu_vs_url_alias_validate(&$form, $form_state)`
The server-side rule. Reads `$form_state->getValues()`; only acts when both `menu` and `path` values are present. If `strlen(menu['title']) == 0 && strlen(path[0]['alias']) == 0`:
- If `path[0]['pathauto'] == 0` → `setErrorByName('path', 'You must give this page a custom URL path or assign it to a menu.')`.
- Else (Pathauto on) → `setErrorByName('menu', 'You must assign this page to a menu.')`.

Net effect: a governed-type node must have a menu title, OR a non-empty custom alias, OR Pathauto enabled — otherwise the save is blocked.

## Notes for integrators
- The feature keys off the content-type **machine name**; renaming a bundle without updating `enabled_content_types` silently disables it.
- No custom permission is defined — governed-form UI appears to any user who can already reach the node form; the validation simply constrains what they can save.
- No user/remote data is rendered as markup by this module (all output is static translated strings via `t()`); it defines no report, query, or endpoint.

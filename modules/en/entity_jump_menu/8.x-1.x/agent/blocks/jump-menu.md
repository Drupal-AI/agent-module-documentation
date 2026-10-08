<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity jump menu: form, block, toolbar

The module has three source files of substance. All three expose the same form.

## The form — `EntityJumpMenuForm`

`src/Form/EntityJumpMenuForm.php`, extends `FormBase`, id `entity_jump_menu_form`.
DI (`create()`): `theme.manager`, `module_handler`, `entity_type.manager`.

- `getEntityTypes()`: hardcoded option list — `node` => "node", `user` => "user", and
  `taxonomy_term` => "term" **only if** `moduleHandler->moduleExists('taxonomy')`. This is the only source
  of the select options; no entity query is run to build them.
- `getCurrentRequestsEntity()`: loops those types, reads `getRouteMatch()->getParameter($entity_type)`; if
  an upcast `EntityInterface` is on the current route, returns `[typeId, id]` to pre-fill the form.
  Fallback `['node', NULL]`.
- `buildForm()`: builds `entity_type` (`#type select`, options from `getEntityTypes()`, `#required`),
  `entity_id` (`#type textfield`, `#required`, `#size 6`, `#maxlength 10`, `#error_no_message TRUE`),
  and a `Go` submit. Wraps in `<div class="container-inline">`; adds classes `entity-jump-menu-form` and
  the active theme name; attaches library `entity_jump_menu/entity_jump_menu.form`.
- `validateForm()`: loads `manager->getStorage($entity_type)->load($entity_id)`; if nothing loads, shows a
  messenger error `There are no entities matching "%entity_type:%entity_id".` (placeholders auto-escape) and
  sets an (empty-message) error on `entity_id`.
- `submitForm()`: loads the entity again and `$form_state->setRedirectUrl($entity->toUrl())` — redirect
  target is the entity's own canonical URL, not a request-supplied URL. Destination page enforces its own
  entity access.

## The block — `EntityJumpMenuBlock`

`src/Plugin/Block/EntityJumpMenuBlock.php`, `@Block(id = "entity_jump_menu", admin_label = "Entity jump
menu", category = "Forms")`, extends `BlockBase`. `build()` returns
`formBuilder()->getForm('Drupal\entity_jump_menu\Form\EntityJumpMenuForm')`. `getCacheMaxAge()` returns 0
(never cached, because it holds a form). No `blockAccess()` override — placement/visibility is standard
block config. Place at `/admin/structure/block`.

## The toolbar — `entity_jump_menu_toolbar()`

`entity_jump_menu.module`, implements `hook_toolbar()`. Returns `[]` unless the current user has
permission `access entity jump menu toolbar`; otherwise adds a `toolbar_item` (`entity-jump-menu-toolbar-tab`)
whose `tab.form` is the same form, attaching library `entity_jump_menu/entity_jump_menu.toolbar`.

## Permission

`entity_jump_menu.permissions.yml`: `access entity jump menu toolbar` — title "Use the entity jump menu in
the toolbar." Grant at `/admin/people/permissions`. It gates **only** the toolbar tab, not the block.

## Libraries (`entity_jump_menu.libraries.yml`)

- `entity_jump_menu.form`: `js/entity_jump_menu.form.js`, `css/entity_jump_menu.form.css`; depends
  `core/jquery`, `core/drupal`.
- `entity_jump_menu.toolbar`: `css/entity_jump_menu.toolbar.css`.

## Install / operate

Enable the module (`drush en entity_jump_menu`). Grant `access entity jump menu toolbar` to the desired
roles for the toolbar tab, and/or place the "Entity jump menu" block. No settings form and no config
objects ship (`provides_config_schema` = false; there is no `config/` directory or `*.routing.yml`).

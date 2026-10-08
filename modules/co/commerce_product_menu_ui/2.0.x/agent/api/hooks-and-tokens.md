# Hooks, helper functions, entity builders & tokens (API)

Everything lives in two procedural files: `commerce_product_menu_ui.module` and
`commerce_product_menu_ui.tokens.inc`. There are no services, controllers or classes.

## Hooks implemented

| Hook | Function | What it does |
|---|---|---|
| `hook_entity_type_build` | `commerce_product_menu_ui_entity_type_build` (`.module:17`) | Adds core menu_ui's `MenuSettings` validation constraint to the `commerce_product` entity type. |
| `hook_form_BASE_FORM_ID_alter` (`commerce_product_form`) | `commerce_product_menu_ui_form_commerce_product_form_alter` (`.module:150`) | Adds the per-product **Menu settings** `details` section; attaches submit handler + entity builder. |
| `hook_form_FORM_ID_alter` (`commerce_product_type_form`) | `commerce_product_menu_ui_form_commerce_product_type_form_alter` (`.module:300`) | Adds the per-bundle **Available menus / Default parent** controls; attaches validate + two builders. |
| `hook_token_info` | `commerce_product_menu_ui_token_info` (`.tokens.inc:14`) | Declares `[commerce_product:menu-link]` (type `menu-link`). |
| `hook_tokens` | `commerce_product_menu_ui_tokens` (`.tokens.inc:27`) | Resolves the menu-link token and chained `menu-link:*` / `menu:*` tokens. |

## Helper functions (callable from PHP)

### `commerce_product_menu_ui_save(ProductInterface $commerce_product, array $values)` — `.module:32`

Creates or updates the product's `menu_link_content` link entity. When `$values['entity_id']` is set it
loads and (for translatable links) translates the existing entity; otherwise it creates a new one:

```php
$entity = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
  'link' => ['uri' => 'entity:commerce_product/' . $commerce_product->id()],
  'langcode' => $commerce_product->language()->getId(),
]);
$entity->enabled->value = 1;
```

then sets `title`, `description`, `menu_name`, `parent`, `weight` and `->save()`. `$values` keys:
`entity_id`, `title`, `description`, `menu_name`, `parent`, `weight`.

### `commerce_product_menu_ui_get_menu_link_defaults(ProductInterface $commerce_product)` — `.module:72`

Returns the default values array for the form: `entity_id`, `id` (plugin id), `title`,
`title_max_length`, `description`, `menu_name`, `parent`, `weight`. It reads the bundle's third-party
`menu_ui` `parent`/`available_menus` settings and runs an `entityQuery('menu_link_content')` (with
`accessCheck(TRUE)`) to find an existing link for the product. Note the query filters on
`link.uri = commerce_product/<id>` first, then on the canonical `entity:commerce_product/<id>` across
all allowed menus — the URI actually written by the save path is the `entity:`-prefixed form.

## Form-cycle callbacks

- `commerce_product_menu_ui_form_commerce_product_form_submit` (`.module:267`) — on a product save:
  if the menu section is disabled it deletes the existing link (when `entity_id` present); if enabled
  with a non-empty title it decomposes `menu_parent` (`"menu_name:parent"`) and calls
  `commerce_product_menu_ui_save()`.
- `commerce_product_menu_ui_commerce_product_builder` (`.module:256`) — entity builder that copies the
  submitted `menu` values onto `$entity->menu` for the submit handler.
- `commerce_product_menu_ui_form_commerce_product_type_form_validate` (`.module:360`) — ensures the
  chosen default parent is within one of the selected available menus.
- `commerce_product_menu_ui_form_commerce_product_type_form_builder` (`.module:380`) — writes the
  `menu_ui` third-party settings (see [../configure/menu-settings.md](../configure/menu-settings.md)).
- `commerce_product_menu_ui_link_submit_build_tokens` (`.module:388`) — entity builder that, after
  validation, constructs/saves the `menu_link_content` entity early and stashes it on
  `$entity->menu_link` so tokens can reference it (guards `!$entity instanceof ProductInterface`; a
  product-type may reach it — issue #2998482 — and is skipped).

## Tokens (`commerce_product_menu_ui.tokens.inc`)

- `[commerce_product:menu-link]` — the menu link title for the product. Resolved from the calculated
  `menu_link` field when present, otherwise via `plugin.manager.menu.link`
  (`loadLinksByRoute`) + `_commerce_product_menu_ui_token_link_best_match()` (`.tokens.inc:160`), which
  prefers the link whose plugin id matches the product's default menu setting.
- Chained relationships: `[commerce_product:menu-link:*]` delegates to core's `menu-link` tokens, and
  the file also resolves `menu-link:menu`, `menu-link:edit-url`, and `menu:*` tokens (`name`,
  `machine-name`, `description`, `menu-link-count`, `edit-url`).
- Suggested pathauto pattern (from the project page):
  `[commerce_product:menu-link:parent:url:path]/[commerce_product:title]`.

## What it does NOT provide

No routes, no `*.services.yml`, no controllers, no permissions, no drush commands, no plugin types, no
JS/CSS of its own (it attaches core `menu_ui/drupal.menu_ui` and `menu_ui/drupal.menu_ui.admin`). To
manipulate a product's menu link programmatically, work directly with the core `menu_link_content`
entity API or call `commerce_product_menu_ui_save()`.

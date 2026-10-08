<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Menu UI (commerce_product_menu_ui) — agent index

Ports core's **`menu_ui`** "Provide a menu link" behaviour from nodes to **Commerce products**. It is
pure procedural glue — no routes, no services, no controllers, no permissions of its own, no plugins.
Everything is done from `commerce_product_menu_ui.module` via form-alter hooks that clone the core
node pattern: it adds a **Menu settings** `details` section to the product edit form
(`commerce_product_form`) and a per-bundle **Available menus / Default parent** section to the product
**type** form (`commerce_product_type_form`). On save it creates/updates/deletes a core
`menu_link_content` entity whose link URI is `entity:commerce_product/<id>`. Per-bundle choices are
stored as `menu_ui` **third-party settings** on the `commerce_product_type` config entity (schema
`commerce_product.commerce_product_type.*.third_party.menu_ui`), exactly like core stores them on
`node_type`.

Access is the same as core node menu_ui: both Menu settings sections are gated by the core
`administer menu` permission (`commerce_product_menu_ui.module:184` and `:304`) — the very permission
core's `menu_link_content` access-control handler requires to create/update/delete a menu link — so a
product editor without `administer menu` never sees the section and, because Drupal ignores input for
`#access => FALSE` elements, cannot forge one. It also registers core menu_ui's `MenuSettings`
validation constraint on `commerce_product` and provides `[commerce_product:menu-link:*]` token support.

- Depends on: `commerce:commerce`, `commerce:commerce_product`, `drupal:menu_ui`. No composer.json (no
  external libraries).
- Core: `^9.3 || ^10 || ^11`. Package: `Commerce`.
- No dedicated settings page / `configure` route. **All configuration is per product type** on the
  product-type form (third-party settings). Provides config schema, **no permissions of its own**
  (reuses core `administer menu`), no drush, no plugin types.
- Version `2.0.3` (installed/enabled at time of writing).

## What you'd do → where

- **Choose which menus a product bundle may use / set its default parent, and the config keys behind
  it** → [configure/menu-settings.md](configure/menu-settings.md)
- **Understand the access model (who can add a product to a menu)** →
  [configure/menu-settings.md](configure/menu-settings.md)
- **Create/update/delete a product's menu link from code, or use the `[commerce_product:menu-link]`
  tokens; the hooks, helper functions and entity builders** →
  [api/hooks-and-tokens.md](api/hooks-and-tokens.md)

## Key facts (real machine names)

- **No** `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.links.*.yml`, `*.libraries.yml`,
  `composer.json`, or `src/`. All logic is in `commerce_product_menu_ui.module` and
  `commerce_product_menu_ui.tokens.inc`.
- Hooks implemented: `hook_entity_type_build` (adds the `MenuSettings` constraint to
  `commerce_product`), `hook_form_commerce_product_form_alter`,
  `hook_form_commerce_product_type_form_alter`, `hook_token_info`, `hook_tokens`.
- Helper functions: `commerce_product_menu_ui_save($product, $values)` (create/update the link
  entity), `commerce_product_menu_ui_get_menu_link_defaults($product)` (load existing link + defaults).
- Submit/validate/builder callbacks: `commerce_product_menu_ui_form_commerce_product_form_submit`,
  `commerce_product_menu_ui_commerce_product_builder`,
  `commerce_product_menu_ui_form_commerce_product_type_form_validate`,
  `commerce_product_menu_ui_form_commerce_product_type_form_builder`,
  `commerce_product_menu_ui_link_submit_build_tokens`.
- Config schema key: `commerce_product.commerce_product_type.*.third_party.menu_ui` →
  `available_menus` (sequence of menu machine names) + `parent` (string, e.g. `main:`).
- Menu link entity: core `menu_link_content`, link URI `entity:commerce_product/<product_id>`,
  `enabled = 1`.
- Reused core validation constraint: `MenuSettings` (from `menu_ui`).
- Tokens: `[commerce_product:menu-link]` (type `menu-link`), plus chained `menu-link:*`, `menu:*`
  tokens (see `commerce_product_menu_ui.tokens.inc`).
- Core services consumed (via `\Drupal::service`): `menu.parent_form_selector`,
  `plugin.manager.menu.link`, `entity.repository`, `entity_field.manager`, `token`.
- Libraries attached from core menu_ui: `menu_ui/drupal.menu_ui` (product form),
  `menu_ui/drupal.menu_ui.admin` (product-type form).
- Permission gate: core `administer menu` (no module-specific permission).

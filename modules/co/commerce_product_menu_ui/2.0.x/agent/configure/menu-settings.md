# Per-product-type menu settings & access model (configure)

There is **no module settings page** and **no `configure` route**. Configuration is per product type,
on the product-type edit form, and is stored as `menu_ui` **third-party settings** on the
`commerce_product_type` config entity — the same pattern core uses on `node_type`.

## Where to configure (UI)

`admin/commerce/config/product-types/<type>/edit` → **Menu settings** vertical tab (added by
`commerce_product_menu_ui_form_commerce_product_type_form_alter`, `.module:300`). Two controls:

- **Available menus** (`menu_options`, checkboxes) — which menus may be chosen on the product form for
  this bundle. Default `['main']`.
- **Default parent item** (`menu_parent`, select) — the default parent for a new link, e.g. `main:`.

The tab is only rendered when the current user has **`administer menu`** (`.module:304`); otherwise the
alter returns early and the settings are left untouched. A validate handler
(`commerce_product_menu_ui_form_commerce_product_type_form_validate`, `.module:360`) rejects a parent
that is not under one of the selected available menus.

## Config schema and storage

Schema file `config/schema/commerce_product_menu_ui.schema.yml`:

```yaml
commerce_product.commerce_product_type.*.third_party.menu_ui:
  type: mapping
  mapping:
    available_menus:      # sequence of menu machine names
      type: sequence
      sequence:
        type: string
    parent:               # string, e.g. "main:" or "main:menu_link_content:<uuid>"
      type: string
```

Written by the entity builder `commerce_product_menu_ui_form_commerce_product_type_form_builder`
(`.module:380`):

```php
$type->setThirdPartySetting('menu_ui', 'available_menus', array_values(array_filter($form_state->getValue('menu_options'))));
$type->setThirdPartySetting('menu_ui', 'parent', $form_state->getValue('menu_parent'));
```

## Set it from code

```php
$type = \Drupal\commerce_product\Entity\ProductType::load('default');
$type->setThirdPartySetting('menu_ui', 'available_menus', ['main', 'footer']);
$type->setThirdPartySetting('menu_ui', 'parent', 'main:');
$type->save();
```

Read back with `$type->getThirdPartySetting('menu_ui', 'available_menus', ['main'])` and
`...'parent', 'main:'`. These are the exact keys the product form reads to build its menu section.

## The product form (per product)

For each product of that type, the product edit form gains a **Menu settings** `details` section
(`commerce_product_menu_ui_form_commerce_product_form_alter`, `.module:150`) with: **Provide a menu
link** (checkbox), **Menu link title**, **Description**, **Parent item** (limited to the bundle's
`available_menus`), and **Weight**. The parent select is built by the core
`menu.parent_form_selector` service; if it yields no options the whole section is suppressed.

## Access model (security-relevant, benign)

The module reuses core menu_ui's access model rather than inventing one:

- The product-form Menu settings section sets
  `'#access' => \Drupal::currentUser()->hasPermission('administer menu')` (`.module:184`).
- The product-type-form Menu settings tab returns early unless the user has `administer menu`
  (`.module:304`).

`administer menu` is precisely the permission core's `menu_link_content` access-control handler
requires to create, update or delete a menu link
(`core/modules/menu_link_content/src/MenuLinkContentAccessControlHandler.php`), so a product editor who
lacks it cannot add products to menus here any more than they could via the core menu admin UI. Because
Drupal does not process submitted input for elements whose `#access` is `FALSE`, the submit handlers
receive only the default (empty/disabled) menu values for such users and create nothing. Restrict which
menus are exposed per bundle (Available menus) as an editorial control to keep storefront menus
manageable.

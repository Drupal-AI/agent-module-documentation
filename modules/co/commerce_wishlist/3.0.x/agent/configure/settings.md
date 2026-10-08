# Settings, wishlist types, button & block

## Global settings — `commerce_wishlist.settings`

Form: `\Drupal\commerce_wishlist\Form\SettingsForm` at
`/admin/commerce/config/wishlist-settings` (route `commerce_wishlist.admin_settings`,
permission `administer commerce_wishlist`).

| Key | Default | Meaning |
|---|---|---|
| `allow_multiple` | `false` | Allow more than one wishlist per customer. |
| `allow_anonymous_sharing` | (unset) | Let anonymous users share wishlists by email. |
| `duplicate` | `false` | When an anonymous wishlist is shared by email, duplicate it (preserve the original). Only relevant with anonymous sharing. |
| `default_type` | `default` | The `commerce_wishlist_type` used for new wishlists. |
| `view_modes` | (per entity type) | View mode used to render each purchasable entity type on the wishlist. |

```bash
drush cget commerce_wishlist.settings
drush cset commerce_wishlist.settings allow_multiple true -y
drush cset commerce_wishlist.settings default_type default -y
```

## Wishlist types — `commerce_wishlist_type`

A **config bundle** for `commerce_wishlist`. Ships one type `default`. Schema
`commerce_wishlist.commerce_wishlist_type.*` — mapping `label`, `id`, `allowAnonymous` (bool).

```php
$type = \Drupal::entityTypeManager()->getStorage('commerce_wishlist_type')->create([
  'id' => 'registry', 'label' => 'Gift registry', 'allowAnonymous' => TRUE,
]);
$type->save();
```

Add fields to a type like any bundle (Manage fields on the wishlist type). Managed at
`/admin/commerce/config/wishlists` (route `commerce_wishlist.configuration`).

## The "Add to wishlist" button

Two injection points (no config entity — it is form/formatter behavior):

- **Add-to-cart form:** `commerce_wishlist_form_commerce_order_item_add_to_cart_form_alter()`
  adds the button to the Commerce order-item add-to-cart form, with an AJAX submit that calls
  the wishlist manager.
- **Field formatter third-party settings:** on a product-variation field formatter you get
  (`commerce_wishlist_field_formatter_third_party_settings_form()`):
  - `show_wishlist` (bool) — show the button,
  - `weight_wishlist` (int) — sort order,
  - `label_wishlist` (text) — override the button label,
  - `region` — where the button renders.
  Stored under `third_party_settings.commerce_wishlist` on the formatter
  (schema `field.formatter.third_party.commerce_wishlist`).

## Wishlist block

`@Block(id = "commerce_wishlist")` ("Wishlist"). Setting `dropdown` (bool) —
display wishlist contents in a dropdown. Place it in a region (Block layout).

## Key routes

| Route | Path | Permission |
|---|---|---|
| `commerce_wishlist.page` | `/wishlist` | `access wishlist` |
| `commerce_wishlist.user_page` | `/user/{user}/wishlist` | `access wishlist` |
| `commerce_wishlist.admin_settings` | `/admin/commerce/config/wishlist-settings` | `administer commerce_wishlist` |
| `commerce_wishlist.configuration` | `/admin/commerce/config/wishlists` | `administer commerce_wishlist` |

Shared/optional config: Views `commerce_wishlists` and `commerce_wishlist_item_table`, a
`commerce_product_variation` "wishlist" view mode, and a delete action.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the link & module settings

## 1. Show the link (pseudo/extra field on a view display)

`hook_entity_extra_field_info()` adds an **`add_to_cart_link`** display extra field to every
`commerce_product` bundle **and** every `commerce_product_variation` bundle. It is **hidden
by default** (`'visible' => FALSE`, weight 99).

- **Product display** → links the product's **default variation** (via `getDefaultVariation()`;
  nothing renders if the product has no active variation).
- **Variation display** → links **that** variation.

Enable it per view mode:

- UI: *Commerce → Configuration → Product types → {type} → Manage display* (choose the view
  mode via the local tabs, e.g. a "catalog"/"teaser" mode), drag **Add to cart link** out of
  *Disabled*, Save. Recommendation: keep the normal add-to-cart form on the full product
  page and use the link only on catalog/teaser modes.
- Config/PHP — enable on the variation's default display:

```php
$d = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('commerce_product_variation.default.default');
$d->setComponent('add_to_cart_link', ['weight' => 10, 'region' => 'content'])->save();
// Hide again: $d->removeComponent('add_to_cart_link')->save();
```

`getComponent('add_to_cart_link')` returns the settings array when shown, `NULL` when hidden.
The render is built by `AddToCartLink::build()` in the module's
`hook_ENTITY_TYPE_view()` implementations when the component is present.

## 2. Views field

Plugin `@ViewsField("commerce_add_to_cart_link")`
(`CommerceAddToCartLinkViewsField`, extends core `LinkBase`), exposed on the
`commerce_product_variation` data/revision tables (real field `variation_id`). Add it to a
view of product variations. Per-field options:

- `quantity` (default 1) — quantity to add.
- `combine` (default TRUE) — combine into an existing matching line item, or make a new one.
- `destination` (default FALSE) — append a `destination` back to the current view.
- Default label: *Add to cart*. Exposes a `{{ <id>__url }}` rewrite token.

## 3. Settings form (`commerce_add_to_cart_link.settings`)

Route `commerce_add_to_cart_link.settings` → `/admin/commerce/config/add-to-cart-link`
(permission `administer commerce_product_type`; menu under *Commerce → Configuration*).
`AdminSettingsForm` (a `ConfigFormBase`) edits:

```yaml
# commerce_add_to_cart_link.settings  (config/install defaults)
csrf_token:
  roles: {}          # sequence of role ids whose links get a CSRF token (default: none)
redirect_back: false # redirect to the referer instead of the cart page after adding
```

- **`csrf_token.roles`** — a user is token-protected if **any** of their roles is listed.
  Empty = no protection for anyone (links are stable/guessable — fine for anonymous caching).
- **`redirect_back`** — when TRUE and a valid internal referer exists (not the login route),
  redirect there after adding; otherwise redirect to `commerce_cart.page`.

Set via Drush:

```bash
drush cset commerce_add_to_cart_link.settings redirect_back true -y
drush cset commerce_add_to_cart_link.settings csrf_token.roles.0 authenticated -y
```

Both keys are covered by `config/schema/commerce_add_to_cart_link.schema.yml`
(`csrf_token.roles` sequence, `redirect_back` boolean). Rendered links carry
`#cache` context `user.roles` and tag `config:commerce_add_to_cart_link.settings`.

# Configuration and customization

There is **no settings form, no `configure` route, no permissions and no config schema**. The module's
`.info.yml` declares no `configure` key and the README states "No configuration is needed." Once the
module is enabled, the "Buy Now" button is added to every Commerce add-to-cart form automatically. All
"configuration" is therefore code or theme level.

## What is fixed (not configurable via UI)

- The button text `Buy Now`, weight `10`, and classes `button--primary button--buy-now`.
- The redirect always goes to the `commerce_checkout.checkout` route.
- The variation added is the product's **first** variation; the store is the product's **first** store.
- Quantity comes from the add-to-cart form's own `quantity` field.

## Theme / CSS

Target the button with the class `button--buy-now` (it also carries `button--primary`). No CSS or JS
library ships with the module, so styling is entirely up to your theme.

## Change behaviour in code

Implement `hook_form_commerce_order_item_add_to_cart_form_alter()` in a custom module that runs **after**
`commerce_buy_now` (higher module weight), then:

- **Remove the button** on some products / for some users:
  `unset($form['actions']['commerce_buy_now']);` (e.g. hide it on multi-variation products, or gate it
  on a permission/role check you add yourself).
- **Rename / restyle** it: edit `$form['actions']['commerce_buy_now']['#value']`, `['#weight']`, or
  `['#attributes']['class']`.
- **Change where it goes or what it adds**: replace `['#submit']` with your own callback (copy the logic
  from `_commerce_buy_now_submit()` and change the redirect route or the variation/quantity selection).

There is no hook or setting exposed by this module itself to override any of the above — the form alter
is the only extension point. See [../api/hooks.md](../api/hooks.md).

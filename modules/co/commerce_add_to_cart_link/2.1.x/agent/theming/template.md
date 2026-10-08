<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the cart link

## Theme hook

`hook_theme()` registers `commerce_add_to_cart_link` with variables:

- `url` — a `Drupal\Core\Url` to `commerce_add_to_cart_link.page` (already token-signed).
- `product_variation` — the `ProductVariation` entity.

Default template: `templates/commerce-add-to-cart-link.html.twig` in the module.

## Theme suggestions

`hook_theme_suggestions_commerce_add_to_cart_link()` adds, in order:

- `commerce_add_to_cart_link__{variation_bundle}`
- `commerce_add_to_cart_link__{variation_id}`

So override per variation **type** or per **variation id**, e.g.
`commerce-add-to-cart-link--default.html.twig` or `…--42.html.twig` in your theme.

## Customising markup / enabling AJAX

Copy `commerce-add-to-cart-link.html.twig` into your theme and edit text/markup. To make the
link fire as AJAX (updates the cart count live, no page reload), add the `use-ajax` class:

```twig
<a href="{{ url }}" class="add-to-cart-link use-ajax" rel="nofollow"
   data-variation="{{ product_variation.id }}">{{ 'Add to cart'|t }}</a>
```

For the Views field version, enable AJAX by rewriting the results as a custom link with
*Link class* `use-ajax`.

The controller's AJAX response updates `span.cart-block--summary__count` and triggers a
`addToCartLink.updated` jQuery event on `html` — bind to it in your own JS to update custom
cart indicators or show a toast:

```js
$('html').on('addToCartLink.updated', (e, data) => {
  // data.cart_total_count, data.product_title, data.quantity_added,
  // data.product_variation_id, data.product_id
});
```

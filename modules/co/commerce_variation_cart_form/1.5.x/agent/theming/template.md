# Theming the variation cart form

The rendered form is wrapped by the `commerce_variation_cart_form` theme hook
(`hook_theme()` in the .module), default template
`templates/commerce-variation-cart-form.html.twig`.

## Available variables

- `form` — the `AddToCartForm` render array.
- `product` — the parent product entity.
- `variation` — the current product variation entity.
- `order_item` — the order item created from the variation.
- `view_mode` — the variation view mode string.
- `active` — bool, whether the variation is published/available.

The default template renders `{{ form }}` when `active`, otherwise a
`<div class="commerce-variation-cart-form … disabled">This product is unavailable</div>`.
It lets you add wrappers and change the unavailable message, but **not** the form elements
themselves (those come from the order-item form mode — see configure/setup.md).

## Template suggestions

`hook_theme_suggestions_alter()` adds, in increasing specificity:

- `commerce-variation-cart-form--PRODUCT_TYPE.html.twig`
- `commerce-variation-cart-form--PRODUCT_TYPE--VARIATION_TYPE.html.twig`
- `commerce-variation-cart-form--PRODUCT_TYPE--VARIATION_TYPE--VARIATION_VIEW_MODE.html.twig`

Example: product type `foo`, variation type `bar`, view mode `cart` →
`commerce-variation-cart-form--foo--bar--cart.html.twig`. Copy the base template into your
theme and rename per the suggestion you need.

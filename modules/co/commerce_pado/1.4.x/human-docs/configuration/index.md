# Configuration

Commerce Product Add On has no central settings page. Instead, you decide which
products are offered as add-ons **per view display** of a product — the same
*Manage display* screen you use to arrange a product's fields. That makes add-ons a
per-bundle **and** per-view-mode decision, and it exports with your site
configuration.

## Configure add-ons on a product's view display

1. Go to **Commerce → Configuration → Product types**, pick a product type, and
   open its **Manage display** tab (this edits the product's entity view display).
   You can do this for any view mode you have enabled (for example the default
   product page, or a teaser).
2. The module adds add-on configuration to this display-edit form. Use it to choose
   which products should be offered as tick-box add-ons on this display.
3. Save the display.

On the storefront, the Add to Cart form for products rendered with that display now
shows the selected products as checkboxes. Each add-on a customer ticks is added to
the cart as **its own order item**, so it keeps its own price, stock and tax
handling and shows as a separate line.

Because the setting lives on the view display, you can offer different add-ons in
different view modes — for example a fuller set on the product page and none in a
teaser — and remove an add-on from a display later without deleting the product
itself.

## Theming the add-on labels

The module ships three Twig templates you can override in your theme to control the
markup and labelling:

| Template | Controls |
|----------|----------|
| `commerce-pado-add-to-cart-form.html.twig` | The Add to Cart form with its add-on checkboxes |
| `commerce-pado-addon-product-label.html.twig` | How each add-on **product** is labelled |
| `commerce-pado-addon-product-variation-label.html.twig` | How each add-on **variation** is labelled |

The two label templates have theme-suggestion hooks, so you can provide
per-product-type or per-variation-type variants — for example a differently styled
label for warranty add-ons versus gift-wrapping add-ons. Copy the template into your
theme and edit it as a standard Drupal template override.

## Notes on behaviour

- Add-ons are ordinary products, so their price, inventory and tax rules are exactly
  those you already configured on them — there is nothing add-on-specific to set up.
- Because each add-on becomes a separate order item, you can report on add-on sales
  independently and fulfil them like any other product.

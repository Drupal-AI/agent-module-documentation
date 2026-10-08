<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme: add-on form and label templates

`commerce_pado_theme()` registers three theme hooks. Override the templates in your theme to
control how the add-on form and its labels render (a common need is showing each add-on's price).

| Theme hook | Template | Variables | Suggestion hook |
|---|---|---|---|
| `commerce_pado_add_to_cart_form` | `commerce-pado-add-to-cart-form.html.twig` | `form`, `attributes` | — |
| `commerce_pado_addon_product_label` | `commerce-pado-addon-product-label.html.twig` | `product_entity` | `commerce_pado_theme_suggestions_commerce_pado_addon_product_label()` |
| `commerce_pado_addon_product_variation_label` | `commerce-pado-addon-product-variation-label.html.twig` | `product_entity`, `variation_entity` | `commerce_pado_theme_suggestions_commerce_pado_addon_product_variation_label()` |

- **Form** — `PadoAddToCartForm::buildForm()` appends `commerce_pado_add_to_cart_form` to the
  form `#theme`. The default template just prints `{{ form }}`; override it to place the
  `{{ form.add_ons }}` group where you want relative to `{{ form.purchased_entity }}`.
- **Product label** — used as the group title above a product's add-on options. Default:
  `Add {{ product_entity.label }}`.
- **Variation label** — used as each individual option label. Default: `Add {{ variation_entity.label }}`.

## Theme suggestions (per bundle)

- `commerce_pado_addon_product_label__<product bundle>` — e.g.
  `commerce-pado-addon-product-label--default.html.twig`.
- `commerce_pado_addon_product_variation_label__<variation bundle>` — e.g.
  `commerce-pado-addon-product-variation-label--default.html.twig`.

## Example: show the price in the label

The bundled test module demonstrates the common override (Commerce's `commerce_price_format`
Twig filter):

```twig
{# commerce-pado-addon-product-variation-label.html.twig #}
{{ variation_entity.label }} for {{ variation_entity.getPrice|commerce_price_format }}
```

```twig
{# commerce-pado-addon-product-label.html.twig #}
Add {{ product_entity.label }} for {{ product_entity.getDefaultVariation.getPrice|commerce_price_format }}
```

Note: the checkbox/select `#description` for each option is the add-on **variation rendered in the
`add_on` view mode** (configured under Manage display for the add-on product/variation types), so
richer add-on markup can also be controlled there without a template override.

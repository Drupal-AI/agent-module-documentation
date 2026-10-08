# Configuration

Configuring Commerce Product Availability has two parts: the module's own settings
form, and — where most of the work happens — adding and tuning the **Product
Availability** field on your product variation type.

## The settings form

The module provides a settings form at **`commerce_product_availability.settings`**
(reachable from the module's entry under Commerce/Configuration). Review it after
installing to set any site-wide defaults the module exposes.

Also grant the module's **permissions** at **People → Permissions** so the right
roles can manage availability.

## Add the Product Availability field to a variation type

1. Go to **Commerce → Configuration → Product variation types**
   (`/admin/commerce/config/product-variation-types`), choose the variation type
   you want, and open **Manage fields → Add field**.
2. Under the **Commerce** section, choose the **Product Availability** field type
   and create the field on the variation.

## The field's values

The Product Availability field is multi-value and holds:

- **Orderable** — whether the product can be purchased. This value alone decides
  whether the variation is purchasable.
- **Availability Status** — a status such as `in_stock` or `out_of_stock`. The
  available options can be altered by developers through a provided hook.
- **Available from** — the date the product becomes available.
- **Min / Max Delivery Period** — the minimum and maximum time it takes to deliver
  the product.

There is also an optional **field setting to alter the "Add to Cart" button**
behavior based on the Orderable and Availability Status values.

## Choose a widget and formatter

- **Widget** — after creating the field, pick the widget you prefer on **Manage
  form display**: **Product Availability Default** or **Product Availability
  Simple**.
- **Formatter** — on **Manage display**, adjust the formatter settings to taste.
  Because the formatter renders through a custom Twig template, its output can be
  themed/overridden as desired.

## Enforcement (good to know)

Once the field is set, the module enforces availability automatically: its
**Availability Checker** stops a shopper from adding a non-orderable product to the
cart, and its **Order Processor** removes an unavailable item from the cart. You do
not configure these separately — they act on the field's values.

## Optional: the Order Request (Webform) submodule

If you enabled **Commerce Product Availability Webform Request**, each Product
Availability field gains a **Webform Request** option in its field settings. When
enabled on a variation, an **"Order request"** button appears beside Add to Cart,
linking to a webform. The field settings let you:

- **Select the webform** to use for order requests.
- **Choose how the request link is displayed** — a regular link, in a modal, or in
  a new tab.
- **Add additional link classes.**
- **Override the button label.**

The button is rendered through a Twig template, so it too can be themed.

# Configuration

Commerce Cart Flyout has no settings page of its own. There are just two things to
set up: the flyout cart block (and its single option), and the Add to Cart
formatter on your product display.

## 1. The cart flyout block

If your store already displays a Commerce cart block, the module has already
switched it to the flyout on install — you may not need to place anything. To place
it yourself, or to reach its option:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place (or edit) the **Cart Flyout** block in the region you want, usually a
   header region so it is reachable from every page.
3. In the block's configuration form you will find one option:

### Setting: use quantity count

| Setting | Default | What it does |
|---------|---------|--------------|
| **Use quantity count** | Off | Off = the badge shows the **count of distinct items** in the cart. On = it shows the **sum of all item quantities**. |

Save the block. The flyout is now active site-wide — except on the checkout page,
where it is intentionally hidden so the order cannot be modified outside checkout.

## 2. The Add to Cart formatter

This turns the product's variation selector into an in-page, no-reload add-to-cart
form.

1. Go to **Commerce → Configuration → Product types**, pick your product type, and
   open its **Manage display** tab
   (`/admin/commerce/config/product-types/…/edit/display`).
2. Find the **Variations** field and set its format to **Flyout add to cart form**.
3. Save.

The formatter applies specifically to a Commerce product's **variations** field.
Shoppers can then choose variation attributes — as select lists, radio buttons, or
rendered swatches (for example colour images) — and add to the cart in place, with
the flyout updating live.

> On a module update, product displays that were using the standard Commerce "Add
> to cart" formatter are converted to this one automatically, so you may find it is
> already selected.

## Theming (optional)

There is nothing else to configure. To change how the flyout or add-to-cart form
looks, override the module's Twig templates in your theme (for example the flyout
block wrapper, the off-canvas panel and its line items, the add-to-cart button, and
the variation/attribute selectors). These templates are rendered server-side and
handed to the module's JavaScript, so overriding the Twig changes the live UI.

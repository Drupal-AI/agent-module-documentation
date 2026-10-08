# Configuration

Setting this module up is two steps: **turn AJAX on for a product display**, then
**configure the global pop‑up** that shoppers see after adding an item.

## Step 1 — Enable AJAX on a product display

1. Go to **Commerce → Configuration → Product types**, pick a type (for example
   *Default*), and open its **Manage display** tab
   (`/admin/commerce/config/product-types/default/edit/display`).
2. Find the **Variations** field, which uses the *Add to cart form* formatter, and
   click its gear/settings icon.
3. Tick the **Enable Ajax** checkbox that this module adds, then **Update** and
   **Save**.

The checkbox only appears on the Add to cart formatter (and the Commerce VADO group
add‑to‑cart formatter). Repeat for each product type or view mode where you want
AJAX; leave it off where you want the standard full‑page form.

## Step 2 — Configure the pop‑up

Go to **Commerce → Configuration → Ajax → Ajax add to cart pop‑up settings**
(`/admin/commerce/config/ajax-settings`). This form requires the **Access ajax atc
administration pages** (`access ajax atc administration pages`) permission.

> **Note:** the module ships no default settings, so until you save this form once
> there is no configured pop‑up type. Save it to establish your choices.

### Pop‑up type

- **Non‑modal** — a lightweight inline Drupal message.
- **Modal dialog** — a core modal dialog box.
- **Colorbox** — a Colorbox pop‑up. This option only appears when the Colorbox Load
  module is installed.

### Message and link text

- **Success message** — the confirmation text. It supports the `[variation_title]`
  token, which is replaced with the product's name. Left blank, it falls back to a
  default "… added to" message.
- **Cart link text** — the wording of the link after the message. Blank falls back
  to "your cart"; entering `[none]` removes the link entirely.

### Optional buttons

Each of these is a checkbox plus a label field:

- **View cart** button (default label "View cart").
- **Checkout** button (default label "Checkout") — sends the shopper straight to
  checkout.
- **Close** button (default label "Continue shopping") — dismisses a modal or
  Colorbox pop‑up.

### Modal and Colorbox sizing

- When the type is **Modal dialog**: **Modal title**, **Modal width**, and **Modal
  height**.
- When the type is **Colorbox**: **Colorbox width** and **Colorbox height**.

### Richer pop‑ups with a template

- **Use Twig template** — instead of the plain message, render the confirmation
  through the `commerce_ajax_atc_popup` theme hook, showing the purchased variation
  in a dedicated **commerce_ajax_atc_popup** view mode. Use this when you want a rich
  product confirmation (image, price, etc.) rather than a one‑line message.

### Other integrations

- **Enable Variation Cart Form AJAX** — a separate toggle that turns on AJAX for the
  Commerce Variation Cart Form module's add‑to‑cart form.

Click **Save configuration** when done. Then add a product to your cart from the
storefront to see the pop‑up and the in‑place cart refresh.

## Permissions

- **Access ajax atc administration pages** — controls who can open the pop‑up
  settings form. Grant it under **People → Permissions** to the roles that manage
  the store.

# Commerce Add To Cart Link — manual setup guide

**Commerce Add To Cart Link** (`commerce_add_to_cart_link`) replaces Drupal
Commerce's add-to-cart **form** with a plain **link**. Instead of an embedded
form with a quantity box and a submit button, you get a single "Add to cart" link
that adds a product variation to the cart with one click. This is exactly what you
want on product listings, "related products" blocks, and AJAX-paginated views —
places where a full form is overkill or actively breaks.

It solves two real Commerce headaches. Add-to-cart forms silently fail when the
product rendered on the page changes between page load and submit (common on
cached catalog pages), and AJAX-enabled views "steal" any forms embedded in them
so the button stops working after the first click. A link has neither problem: it
carries the product and variation in its URL and adds to the cart on a plain
request.

You turn the link on as a **pseudo field** on your product or variation display
(it's hidden by default, so you enable it per view mode), or add it as a **Views
field** to a product listing. The link is fully themeable through a Twig template,
so you control its text and markup, and you can even make it AJAX-driven to update
the cart count live. An optional per-role **CSRF token** hardens the link against
abuse for logged-in users while leaving anonymous, cacheable catalog links simple.
The bundled **Commerce add to wishlist link** submodule offers the same thing for
wishlists.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the wishlist submodule.
2. [Configuration](configuration/index.md) — enable the link on a display or in a
   view, and the module settings (token protection and redirect behavior).

## Where it lives in the admin menu

- The link itself is enabled on **Manage display** pages for your product and
  product-variation types (under *Commerce → Configuration → Product types*).
- The module's own settings form is at **Configuration → Commerce → Commerce Add
  To Cart Link** (`/admin/commerce/config/add-to-cart-link`).

## How to use it

1. Decide where you want one-click cart links — a catalog/teaser view mode, a
   product block, or a listing view.
2. **Enable the "Add to cart link" field** on that display's *Manage display*
   page (it starts in the *Disabled* region), or add the **Add to cart** Views
   field to your listing view. See [Configuration](configuration/index.md).
3. Optionally open the settings form to turn on **token protection** for chosen
   roles and to choose whether shoppers are **redirected back** to the listing
   after adding, instead of to the cart page.
4. A common setup is to keep the normal add-to-cart *form* on the full product
   page and use the *link* only on catalog and teaser displays.

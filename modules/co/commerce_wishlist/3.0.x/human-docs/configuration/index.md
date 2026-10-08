# Configuration

Commerce Wishlist works as soon as it is enabled — each customer gets one
default wishlist. The settings below let you expand what it can do: multiple
lists per person, email sharing, custom wishlist types, and where the "Add to
wishlist" button appears.

## Global settings

Go to **Commerce → Configuration → Wishlist settings**
(`/admin/commerce/config/wishlist-settings`). You need the **Administer
commerce_wishlist** permission (administrators have it). The form controls:

- **Allow multiple wishlists** — off by default. When on, a customer can create
  several named lists (for example "Birthday" and "Kitchen") instead of a single
  one.
- **Allow anonymous sharing** — lets anonymous (not-logged-in) visitors email a
  copy of their wishlist.
- **Duplicate on share** — only relevant with anonymous sharing. When on, an
  anonymous list is *duplicated* when it is shared, so the original list is
  preserved for the visitor after they send a copy.
- **Default wishlist type** — the wishlist *type* used for brand-new lists
  (ships as `default`). Change this if you create your own type and want it to
  be the default.
- **View modes** — for each purchasable entity type (typically product
  variations), choose the view mode used to render items on the wishlist page.

## Wishlist types

A **wishlist type** is a bundle for wishlists — think of it as the equivalent of
a content type, but for lists. The module ships one type called **default**.
Manage types at **Commerce → Configuration → Wishlists**
(`/admin/commerce/config/wishlists`).

Create a new type when you want lists that carry extra fields — for example a
"Gift registry" type with an event-date field. Each type has an **Allow
anonymous** flag that controls whether anonymous visitors may create lists of
that type. Add fields to a type from its **Manage fields** tab, exactly as you
would on a content type.

## The "Add to wishlist" button

The button is not a block you place — it is injected into the product display in
two ways:

- **On the add-to-cart form.** The module adds the "Add to wishlist" button next
  to "Add to cart" on the Commerce order-item add-to-cart form.
- **On a product-variation field formatter.** When you configure a
  product-variation field's display (**Manage display**), the formatter gains
  extra **Commerce Wishlist** third-party settings:
  - **Show wishlist button** — turn the button on for that display.
  - **Weight** — its sort order relative to other elements.
  - **Label** — override the button text (for example "Save for later").
  - **Region** — where the button renders within the formatter.

## The Wishlist block

Place the **Wishlist** block from **Structure → Block layout** into any region
(commonly the header). It shows the customer's wishlist item count and links to
their list. The block has one setting, **Dropdown**, which — when ticked —
displays the wishlist contents in a drop-down from the block.

## Wishlist pages and sharing

- Each customer's list is at **`/wishlist`** (and an owner-scoped
  `/user/{user}/wishlist`), gated by the **Access wishlist** permission.
- From the list, customers can move an item straight into the cart, move a cart
  item back to the list, edit quantities, or remove an item.
- A share form emails a copy of a list to someone else (subject to the
  anonymous-sharing setting above for guests).

## Permissions

Set these at **People → Permissions**:

- **Access wishlist** (`access wishlist`) — view the wishlist page. Grant to
  authenticated users (and anonymous, if you allow guest wishlists).
- **Administer commerce_wishlist** (`administer commerce_wishlist`) — full
  control, including the settings form and the Wishlists page. Admin-only.
- **Administer commerce_wishlist_type** (`administer commerce_wishlist_type`) —
  manage wishlist *types* and their fields. Admin-only.

Because a wishlist is a Commerce content entity, Commerce also generates the
usual owner-scoped permissions (view own / update own / delete own) — grant
those according to your store's needs.

You can also grant permissions from the command line, for example:

```bash
drush role:perm:add authenticated 'access wishlist'
```

# Configuration

Commerce Product Limits has no admin settings page. You configure limits in two
steps: **enable a trait on a product variation type**, then **set the value on
individual variations**.

## Step 1 — enable the limit traits on a variation type

Commerce Product Limits provides three "traits" (optional add-ons) for product
variation types:

- **Minimum order quantity**
- **Maximum order quantity**
- **Step order quantity** (sell only in multiples)

To turn one on:

1. Go to **Commerce → Configuration → Product variation types**
   (`/admin/commerce/config/product-variation-types`).
2. **Edit** the variation type you want to add limits to (for example *Default*).
3. In the **Traits** section, tick the limit(s) you want — **Minimum quantity**,
   **Maximum quantity**, and/or **Step quantity**.
4. Save the variation type.

Enabling a trait installs a matching field on that variation type. Disabling the
trait later removes the field again.

## Step 2 — set the limit on each variation

Now that the fields exist, set the actual numbers on your product variations:

1. Edit a product and open one of its variations (for example under **Variations**
   on the product edit screen).
2. Fill in the fields that appeared:
   - **Minimum order quantity** — the fewest units a customer must buy.
   - **Maximum order quantity** — the most a customer may buy in one order.
   - **Step order quantity** — the increment; for example `6` means the quantity
     must be a multiple of 6.
3. Save the variation.

Leave a field **empty** to mean "no limit" for that variation. Because the values
are per variation, you can set different limits for each size, color, or other
variation within the same product.

## How the limits are enforced

- **Server side (authoritative):** when a customer tries to add to the cart or
  update the cart, Commerce checks the requested quantity — including any of the
  same item already in their cart — against the minimum and maximum. If it is out
  of range, the change is rejected with a clear message ("You must order at least
  @min…" or "You cannot order more than @max…").
- **Client side (convenience):** the module sets the HTML min, max, and step
  attributes on the quantity fields of the add-to-cart form and the shopping cart,
  and pre-fills the add-to-cart quantity to the minimum, so shoppers see the limits
  before they submit.

The **step** limit is applied as the HTML step attribute on those quantity fields
for client-side guidance.

## Removing a limit

To remove a limit from one variation, clear its field value (empty = unrestricted)
and save. To remove a limit type entirely, untick its trait on the variation type,
which removes the field.

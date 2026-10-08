# Configuration — a tour and setup order

The base `commerce` module does not have a single settings form. Instead it
provides the **Commerce → Configuration** hub (`/admin/commerce/config`), an
overview page whose links are added by the submodules you enabled. Each link
opens the form for one part of your shop.

## Open the configuration hub

Go to **Commerce → Configuration** (`/admin/commerce/config`). You will see the
areas grouped into cards:

![The Commerce Configuration landing page](../images/config.png)

The groups you see depend on which submodules are enabled. With a typical
install you get:

- **Store** — *Currencies*, *Stores* and *Store types*.
- **Orders** — *Order types*, *Order item types*, *Order settings* and
  *Number patterns* (the format of generated order numbers).
- **Payment** — *Payment gateways* (the processors you take money through).
- **Shipping** — *Shipping methods*, *Shipment types* and *Package types*
  (present only when the shipping submodule is installed).

Other areas — such as **Product types** and **Attributes**, **Checkout flows**
and **Tax types** — are reached from the same hub (or from
`/admin/commerce/config/…` paths) once their submodules are enabled.

## Recommended setup order

Commerce entities reference one another, so it is easiest to build them in
dependency order. Work through these steps top to bottom.

### 1. Create a Store

Everything you sell belongs to a store, so create one first. From the hub, open
**Store → Stores** and click **Add store**. A store defines:

- its **currency** — the default currency prices are entered and charged in;
- its **address** — the business location, used as the origin for tax and
  shipping calculations;
- its **tax settings** — how tax is applied for this store.

Set one store as the **default** so the storefront knows which to use. You can
add more stores later to run several brands or regions from one install.

### 2. Define Product types and attributes

Next decide how your catalogue is shaped. Open **Product types** to review or
add product types (a *product* is the thing shoppers browse) and **Product
variation types** for the purchasable variations beneath them. If your products
come in options such as size or colour, open **Attributes** and define those
attribute values — variations are generated from the attribute combinations.

### 3. Create Products and variations

With types in place, add your actual catalogue from **Content → Products**
(`/admin/commerce/products`). Each product holds one or more **variations**, and
each variation carries its own SKU and price. The variation is what a customer
actually adds to the cart, so a "T-shirt" product might have "Small / Red",
"Small / Blue", and so on.

### 4. Review Order types and the Checkout flow

Back in the hub, open **Orders → Order types** to see how orders are modelled.
Each order type is tied to a **checkout flow** — the ordered set of steps and
panes a customer moves through (cart, contact/address, review, payment,
confirmation). Review the default checkout flow before customising it, and
confirm each order type points at the flow you want.

### 5. Add a Payment gateway

To take money you need at least one gateway. Open **Payment → Payment gateways**
and click **Add payment gateway**. For a first pass — and for testing without a
real processor — add the **Manual** gateway (a "pay on delivery" / offline
style gateway): it lets orders be placed and then marked paid by hand in the
admin UI, so you can exercise the whole checkout without live credentials. Swap
in a real on-site or off-site gateway later.

### 6. Configure Taxes

Finally, if you charge tax, enable the tax submodule and open **Tax types** from
the hub. Add the tax type that fits your market (for example a European VAT type
or a US sales-tax type) and Commerce applies the right rate to orders based on
the store address and the customer's location.

## Where to go next

Each of these areas — stores, products, checkout, payment and tax — is a
submodule with its own detailed behaviour. Once your first store, product and
Manual gateway are in place, place a test order end to end to confirm the flow
works, then return to the relevant configuration form to refine it.

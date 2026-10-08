# Configuration

Getting shipping working is a short sequence: make your products shippable, turn on
shipping for the order type customers use, then create one or more shipping methods.
This page walks through each step and the supporting settings.

You need the **Access the administration pages** Commerce permission (an
administrator by default) to reach these screens.

## Step 1 — Make products shippable

A product can only be shipped if it carries a weight. On each **product variation
type** that represents a physical product, enable the **Shippable** trait. This
adds a weight field to those variations. You'll find variation types under
**Commerce → Configuration → Product variation types**.

## Step 2 — Enable shipping on an order type

Go to **Commerce → Configuration → Orders → Order types** and edit the order type
your customers check out with (usually *Default*):

- Tick **Enable shipping for this order type**.
- Choose a **Shipping type** — this is the *shipment type* used for that order's
  parcels (the built-in one is called *Default*).
- Select the **Shipping** checkout flow, or move the **Shipping information** pane
  into your existing checkout flow.

## Step 3 — Create a shipping method

Shipping methods live at **`/admin/commerce/shipping-methods`** (add a new one at
`/admin/commerce/shipping-methods/add`). Each method:

- Belongs to one or more **stores**.
- Wraps a **shipping-method plugin** that does the actual rate calculation.
- Can be limited by **conditions** (see below).

The two built-in plugins are:

- **Flat rate** — one fixed fee for the whole shipment. You set the rate label,
  an optional description, and the rate amount.
- **Flat rate per item** — the same fee charged for each item, multiplied by the
  total quantity in the shipment.

Fill in the label and amount, pick a store, save, and the method becomes available
at checkout.

### Limiting a method with conditions

Conditions decide *when* a method is offered. Add any combination of:

| Condition | Offers the method only when… |
|-----------|------------------------------|
| **Shipping address** | the destination falls inside the address zone you define (specific countries/regions). |
| **Shipment weight** | the parcel weight is above/below a threshold you set. |
| **Shipment quantity** | the item count matches the operator and number you set. |
| **Order shipping method** | a particular shipping method is (or isn't) selected. |

A method with no conditions is offered everywhere.

## Shipment types

A **shipment type** is the bundle for shipments — think of it as the template that
decides which shipping-address profile is collected and whether a confirmation
email is sent. Manage them at **Commerce → Configuration → Shipment types**
(`/admin/commerce/config/shipment-types`). The **Default** shipment type is created
for you. Each shipment type lets you set:

- the **profile type** used for the shipping address,
- whether a **shipment confirmation** email is sent when the order ships, and
- an optional **BCC** address for that email.

Create additional shipment types when different products need different fulfilment
fields or confirmation behaviour.

## Package types

A **package type** describes a physical box — its fixed dimensions and weight — at
**Commerce → Configuration → Package types** (`/admin/commerce/config/package-types`).
A shipping method can pick a default package type, which carrier rate calculators
use when quoting. A sample *Custom box* type ships with the module.

## The checkout pane

When shipping is enabled, checkout gains a **Shipping information** pane that
collects the shipping address, packs the order, and shows selectable rates. Two of
its settings are worth knowing:

- **Recalculate rates when the address changes** — refreshes the quoted rates as
  soon as the customer edits their address.
- **Require a shipping profile** — hides shipping costs until an address has been
  entered.

## What the customer pays

Once a rate is chosen, its cost is added to the order total as a **shipping**
adjustment. If you run promotions, a shipping discount appears as a separate
**shipping promotion** adjustment. With **Commerce Tax** installed you can create a
**Shipping** tax type so shipping is taxed like any other line item.

## Tracking shipments

Each order with shipping gains a **Shipments** tab in the admin UI where staff can
see and update its parcels. Shipments run a workflow — **draft → ready → shipped**
(with a **canceled** option) — and can hold a tracking number that the tracking
field formatter renders as a link.

## Permissions

Commerce Shipping adds four administrative permissions, all marked as restricted:

- **Administer commerce_shipment** — manage shipments.
- **Administer commerce_shipping_method** — manage shipping methods.
- **Administer commerce_shipment_type** — manage shipment types.
- **Administer commerce_package_type** — manage package types.

Grant them only to trusted store-manager roles at
**People → Permissions**.

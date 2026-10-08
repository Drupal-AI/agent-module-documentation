# Configuration

This module has **no settings form of its own**. You configure it through Commerce's
existing screens, in four steps. The example below collects an "order comments"
field; the same steps apply to any field you want on the order.

## Step 1 — Add fields to the order type

Go to **Commerce → Configuration → Order types → (your type, e.g. Default) → Manage
fields** (`/admin/commerce/config/order-types/default/edit/fields`). Add whatever
fields you want to collect at checkout — for example a *Text (plain, long)* field
called "Order comments", a date field for a delivery date, or a plain text field for
a PO number. These attach to the order entity.

## Step 2 — Enable and arrange the Checkout form display

Go to **Manage form display** for the same order type
(`/admin/commerce/config/order-types/default/edit/form-display`). At the bottom,
under **Custom display settings**, tick **Checkout** and **Save**. This turns on the
dedicated Checkout form display that the module ships.

Now open that **Checkout** display (the *Checkout* secondary tab, or
`.../form-display/checkout`). Disable every field except the ones you want to collect
at checkout, arrange them in the order you want, and **Save**. Only the fields you
leave enabled here will appear in the checkout pane.

## Step 3 — Place the pane in your checkout flow

Go to **Commerce → Configuration → Checkout flows → (your flow, e.g. Default)**
(`/admin/commerce/config/checkout-flows/manage/default`). You will see a pane called
**Order fields: Checkout** in the *Disabled* column. Drag it into a real step — for
example **Order information** or **Review** — position it where you want it to
appear, and **Save**.

(If you create additional order form-display modes later, each one gets its own
"Order fields: …" pane, so you can collect different fields at different points.)

## Step 4 — Configure the pane

On the checkout-flow page, click the **gear/edit icon** on the *Order fields:
Checkout* pane to set its own two options:

- **Wrapper element** — how the fields are wrapped in the checkout form:
  - **Container** *(default)* — a plain wrapper with no visible border or heading.
  - **Fieldset** — a bordered group with a legend/heading.
- **Display label** — the heading text shown **only** when *Wrapper element* is set
  to **Fieldset** (for example "Order comments" or "Delivery details"). It is
  ignored for a plain container. It defaults to the pane's label.

Save the pane, then save the flow.

## Result

Go through checkout as a customer. Your fields now appear in the step where you
placed the pane, and whatever the customer enters is validated and saved directly
onto the order — so it shows up on the order in the admin and exports with the order
data. On the **Review** step, the collected values are summarised automatically.

## How it works under the hood

For reference: the pane renders your order type's **Checkout** form display against
the current order and writes the submitted values back onto the order entity (the
built-in *coupons* component is stripped from the rendered display). Because it is a
plugin of Commerce's own checkout-pane system, there is no custom hook to extend —
to customise behaviour you would subclass the pane. The details are in the
[`agent/` checkout-pane docs](../agent/plugins/checkout-pane.md).

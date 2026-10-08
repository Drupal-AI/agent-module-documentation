# Configuration

Commerce InPost is configured in two places: the **shipping method** (where you
set the flat price) and your **checkout flow** (where you enable the InPost
panes so the locker picker appears). There is no separate global settings page,
and there are **no API credentials to enter** — the locker map is InPost's public
browser widget.

## Step 1 — Add the InPost shipping method

1. Log in as a user who can **administer commerce shipping** (an administrator by
   default).
2. Go to **Administration → Commerce → Configuration → Shipping methods**
   (`/admin/commerce/config/shipping-methods`).
3. Click **Add shipping method**.
4. Give it a **Name** for admins, choose the **store(s)** it applies to, and set
   any conditions as you would for any shipping method.
5. Under the plugin selector, choose **InPost Shipping**.

### Fill in the InPost Shipping settings

The plugin behaves like a flat-rate method — you set the price yourself:

- **Rate label** *(required)* — the text customers see when selecting the rate at
  checkout (for example "InPost parcel locker").
- **Rate description** *(optional)* — extra detail shown to the customer about the
  rate.
- **Rate amount** *(required)* — the fixed shipping price (amount + currency).
  This same amount is charged regardless of weight, destination, or which locker
  is chosen.

Click **Save**.

## Step 2 — Enable the InPost panes on your checkout flow

The locker picker and the review summary are **checkout panes**, so they must be
enabled on the checkout flow your store uses:

1. Go to **Administration → Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`) and edit your flow (for example
   `/admin/commerce/config/checkout-flows/manage/shipping`).
2. Make sure these two panes are enabled (drag them out of *Disabled* if needed):
   - **InPost** — by default in the **Order information** step. This is where the
     shopper sees the **Select pick up point** button and the delivery phone
     field. You can drag it to another position in the step.
   - **InPost review** — by default in the **Review** step. It shows the chosen
     locker back to the customer before they place the order.
3. Save the checkout flow.

### InPost pane options (phone number field)

Edit the **InPost** pane's settings to control the delivery phone number:

- **I have a phone number field in the customer profile set up already** — leave
  unchecked to collect the phone number with the module's own "Delivery phone
  number" field at checkout.
- If you check it, pick the **user or customer-profile field** that holds the
  phone number; the checkout field will be pre-filled from it.

## How it looks at checkout

When a shopper selects the InPost shipping method, a **Select pick up point**
button appears. Clicking it opens InPost's map (the "easyPack" geowidget, loaded
in the browser from InPost over HTTPS). The shopper picks a locker; its name and
address are captured, and a **delivery phone number** is required. The chosen
locker is shown on the **Review** step, and afterwards on both the **admin** and
**customer** order views.

## Test end to end

Place a test order: add a product, go to checkout, and confirm that **InPost**
appears as a shipping choice, that the flat rate is applied, that the map opens
and lets you pick a locker, and that the selected locker appears on the review
step and on the completed order.

> **Fulfilment note:** this module records and displays the locker choice; it does
> not create InPost labels or track parcels. Use the locker and phone shown on the
> order to book the shipment in InPost's own tools.

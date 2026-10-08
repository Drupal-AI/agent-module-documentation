# Configuration

Setting up Commerce Purchase Order has two parts: deciding **who** may pay by PO
(the authorization field and permission) and adding the **PO payment gateway**
itself.

## Step 1 — Decide how customers get approved

Enabling the module adds a **Purchase Orders Authorized** field to the User
entity, but it is hidden by default. If you want to require per-account approval
before a customer can use purchase orders:

1. Go to **Configuration → People → Account settings → Manage form display**
   (`/admin/config/people/accounts/form-display`).
2. Drag **Purchase Orders Authorized** out of the **Disabled** region into the
   form.
3. Save. Now, when editing a user, an administrator can tick this box to approve
   that account for PO payment.

Treat granting approval as a **credit decision** — an approved customer's orders
ship before you are paid. The related permission, **"authorize user purchase
orders"**, governs who can extend this, so grant it only to the people who own
that commercial call.

## Step 2 — Add the Purchase Order payment gateway

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **Purchase Order** plugin and give it a name.
4. Configure its options:
   - **Limit maximum open purchase orders** — cap how many unpaid POs a customer
     may have at once. When they reach the limit, new PO purchases are blocked.
   - **Purchase order users require approval in the user account settings** — when
     ticked, the customer's **Purchase Orders Authorized** value is checked at
     "pay and complete". If it is not set, the payment is denied.
   - **Payment instructions** — formatted text telling the customer how to pay the
     PO amount. Shown at checkout and in the confirmation email.
5. Save the gateway.

### Offering PO alongside other gateways

If Purchase Order is one of several gateways, you can add the condition
**Customer → Limit by field: Purchase Orders Authorized** so the PO gateway is
only offered to approved customers.

## The purchase order workflow

A purchase order normally moves through three states:

- **New** — checkout has begun and a PO number is assigned to the payment method.
- **Authorized** — the payment record is saved and the customer has checked out.
  The order is placed but **not yet paid**.
- **Paid** — a user with permission to administer payments opens the order's
  **Payments** tab, selects the **Receive** operation, and records the payment by
  saving the **Receive Payment** form.

Because the order completes without an actual transaction, plan how PO orders reach
your finance team and how incoming payments are later recorded against them.

# Configuration

Setting up withdrawal takes three required steps — grant the permission, enable
withdrawal per order type, and (if you want customers to find it easily) surface the
withdrawal link. Nothing is withdrawable until at least the first two are done.

## 1. Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and give **"Use the
order withdrawal form"** (`access commerce order withdrawal form`) to the roles that
should be allowed to submit a withdrawal.

On a site that does **not** use guest checkout, you may want to **withhold this
permission from the anonymous role** so random visitors can't reach the form — the
dedicated per-user form stays usable for logged-in customers. Granting a public
order action to anonymous users is worth a deliberate decision, not a default.

## 2. Enable withdrawal per order type (opt-in)

Withdrawal is off until you switch it on for an order type. Go to **Commerce →
Configuration → Order types → *(order type)* → Edit**
(`/admin/commerce/config/order-types/{type}/edit`) and open the **Order withdrawal**
section:

- **Enable order withdrawal for this order type** *(required)* — tick this;
  nothing is withdrawable for the order type until it is on.
- **Withdrawal confirmation subject** — the confirmation email's subject line. It
  is **token-aware**, so you can use `[commerce_order:*]` tokens. Leave it empty to
  use the default subject.
- **Withdrawal confirmation BCC** — a BCC address for the confirmation email, also
  token-aware. Leave it empty to send no copy (for example to the merchant).

Save the order type. Repeat for any other order types that should allow withdrawal.

## 3. The confirmation email body (template)

There is no message-body field in configuration. The email body is rendered from the
`commerce-order-withdrawal-confirmation` **Twig template**. To change the wording,
**override that template in your theme** rather than looking for a settings field.

## 4. (Optional) Show the withdrawal link

To help customers find the form:

- **On the order page** — enable the **Withdrawal link** field at the order type's
  **Manage display** (`…/edit/display`).
- **In the customer orders View** — add the **Order withdrawal link** field to the
  View that lists a customer's orders.

## What happens on submission

When a customer submits the form, the module records the request on the order (via
Commerce Log) and sends the confirmation email — and stops there. It does **not**
cancel or refund the order; that is left to your staff or to custom code reacting to
the module's events. This is by design, so a withdrawal request never moves money
without review.

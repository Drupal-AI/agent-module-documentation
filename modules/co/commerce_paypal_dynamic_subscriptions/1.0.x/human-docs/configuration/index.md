# Configuration

Commerce PayPal Dynamic Subscriptions is configured as a Drupal Commerce **payment
gateway**, and it relies on a **subscription plan** you create in PayPal.

## 1. Create a subscription plan in PayPal

In the PayPal dashboard, create a **subscription plan** (under a product) that
describes the recurring billing you want. Note its **plan id** — you'll enter it on
the gateway.

## 2. Add the gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Dynamic Subscriptions** plugin.
3. Configure the settings:
   - **Client ID** and **Secret** — your PayPal API credentials (per gateway).
   - **Subscription plan id** — the plan id you created in PayPal.
   - Set the environment to **sandbox** while testing and **live** for production
     (this is governed through the Commerce PayPal client).
4. Save, then attach the gateway to your **checkout flow**.

## How a subscription is confirmed (and why it's safe)

- At checkout the off-site PayPal button redirects the shopper to PayPal to approve
  the subscription against your configured plan.
- On return, PayPal includes a `subscription_id`. The gateway fetches that
  subscription **server-to-server** via the merchant-authenticated PayPal API and
  **verifies that its `plan_id` matches the plan stored on the order** before
  completing the payment — this guards against plan spoofing.
- The completed payment's amount is taken from the **order total**
  (server-authoritative), not from any client value, and the PayPal subscription id
  and status are stored on the order.

A minor hardening note: the return check confirms the plan matches but does not
additionally assert the subscription status is ACTIVE/APPROVED. Because the amount is
server-side and the subscription is fetched with your merchant credentials, exposure
is low — but if you want belt-and-braces, add a status check (or reconcile
subscription status with PayPal) before fulfilling.

## Events (for developers)

The gateway dispatches subscription **create** and **cancel** events, so you can
subscribe to add post-create logic or provide a custom redirect when a shopper
cancels; otherwise the shopper is returned to the previous checkout step on cancel.

## Keep your credentials safe

Your PayPal **client id / secret** are secrets. Restrict who can administer payment
gateways and protect your configuration exports. Prefer keeping the real values
**out of version control**; with DDEV you can store a secret as an environment
variable:

```bash
ddev dotenv set .ddev/.env --paypal-secret=<value>
ddev restart
```

(Never commit `.ddev/.env`.) Always test against the **PayPal sandbox** before going
live.

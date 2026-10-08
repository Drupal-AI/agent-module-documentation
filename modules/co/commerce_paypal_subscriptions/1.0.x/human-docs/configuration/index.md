# Configuration

Commerce Paypal Subscriptions is configured as a Drupal Commerce **payment gateway**.

## Add the gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Paypal checkout subscriptions** payment method.
3. Enter your PayPal **client ID** and **client secret**.
4. Set up the product/plan (see below).
5. Save, then attach the gateway to your **checkout flow**.

## Set up the PayPal product and plan

To finish configuring checkout you need a **product** and a **plan** in your PayPal
account. You have two choices:

- **Dynamic plans (auto-generate).** Select **Dynamic plans** and tick
  **Autogenerate product**. Plans are generated on the fly, with the price based on
  the Commerce order total.
- **Use an existing plan.** Fill in **Default subscription plan** with a subscription
  plan you created earlier in PayPal.

### Switching environments (sandbox ↔ live)

If you use **dynamically generated products**, note that a product is only generated
in the **PayPal environment you're currently working with**. To reconfigure for a new
environment (production vs sandbox), change the credentials in the UI, **clear the
product ID field**, and press **Save**. Using the **Config Split** module is strongly
recommended to keep sandbox and live settings separate.

## Security: protect credentials and confirm the environment

- Store the PayPal **client ID / client secret as secrets** and operate over HTTPS.
- When a shopper approves the subscription, the module confirms it by **re-fetching
  the subscription from PayPal's authenticated API server-side** and matching its
  plan to the order before recording a completed payment (the amount is the
  server-side order total, not client input).
- Restrict the **administer commerce payment gateway** permission — the credentials
  are entered on the gateway form.
- Always confirm whether the gateway is pointed at **sandbox** or **live** before
  going into production.

## Keep your credentials safe

Prefer keeping the real client id / secret **out of version control**; with DDEV you
can store a secret as an environment variable:

```bash
ddev dotenv set .ddev/.env --paypal-secret=<value>
ddev restart
```

(Never commit `.ddev/.env`.) Restrict who can administer payment gateways and protect
your configuration exports.

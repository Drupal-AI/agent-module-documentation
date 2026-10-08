# Configuration

Setting up LinkTypePlus has three parts: add and configure the gateway, assign the
custom order workflow to your order type, and register the return/notification URLs
in the GMO back office.

## 1. Add the payment gateway

1. Log in as a user who can **administer commerce payment gateways**.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** and select the **LinkTypePlus** plugin.
4. Enter your **GMO shop credentials** and the hosted-page (LinkPlus) settings.
5. Configure the redirect targets and messages the module reads back when GMO
   returns a result:
   - **Success URL** and **success message**
   - **Pending URL** and **pending message**
   - **Failure URL** and **failure message**
   - **Cancel message**

Set the gateway **Mode** to **Test** first and complete an end-to-end order before
switching to **Live**.

## 2. Assign the order workflow

The module ships a dedicated order workflow, **`linktypeplus order workflow`**
(draft → pending → completed/canceled), that its payment logic depends on.

1. Go to **Commerce → Configuration → Order types**
   (`/admin/commerce/config/order-types`).
2. Edit the order type you use for these payments.
3. Set its **Workflow** to **LinkTypePlus order workflow** and save.

## 3. Register the return / notification URLs in GMO

In your GMO/Mul-Pay LinkTypePlus configuration, point GMO at these endpoints on
your site:

- **`/payment/success/order`** — the browser return. The module decodes GMO's
  `result` POST, loads the order, creates or updates the Commerce payment, and
  applies the order transition based on the reported status (for example
  PAYSUCCESS → completed, ERROR/EXPIRED/INVALID → expire/cancel).
- **`/payment/response/save`** — the server-to-server response saver that triggers
  the module's fulfilment subscribers.
- **`/reccuringcredit/response`** — the recurring-credit webhook.

## Store credentials securely

Your GMO shop password and related credentials are secrets — keep them out of
version control. Store each value in an environment variable and reference it
through a **Key** entity where the module supports one:

```bash
ddev dotenv set .ddev/.env --gmo-shop-password=<your-password>
ddev restart
```

If the [Key module](https://www.drupal.org/project/key) is not enabled yet, add it
with `ddev composer require drupal/key && ddev drush en key -y`, then create a Key
that reads the environment variable.

## Security caveat — please review before production

This is worth repeating from the overview. The response-handling routes above have
a **permissive access posture**, and the browser-return handler trusts the
base64-encoded `result` POST for the payment **status without verifying a
signature or HMAC**; the recurring webhook is reachable with only the *access
content* permission (effectively anonymous). The charged **amount** is safe — it is
taken from the loaded order, not the request — but the payment *status* comes from
an unverified callback. Before accepting real payments, review these routes,
restrict access where you can, and consider corroborating the payment against GMO
server-side rather than trusting the return alone.

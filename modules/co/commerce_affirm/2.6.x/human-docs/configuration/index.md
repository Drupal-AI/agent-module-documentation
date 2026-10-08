# Configuration

Setting up Commerce Affirm has two parts: the module's **settings form** (where you
enter API keys and choose the environment) and the **payment gateway** you add so
Affirm appears as a checkout option. You can also place advertising blocks.

## Affirm settings form

1. Log in as a user who can administer Commerce configuration.
2. Open the Affirm settings (config `commerce_affirm.settings`) under **Commerce →
   Configuration**.
3. Enter your **public** and **private** API keys — ideally by referencing the Key
   entities you created in [Installation](../installation/index.md) rather than
   pasting raw values.
4. Set the **mode** to **sandbox** while testing. Switch to **live/production**
   only once you've verified the full financing flow with your production keys.

Save the form.

## Add the Affirm payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
2. Click **Add payment gateway**, name it (for example "Affirm"), and choose the
   **Affirm** plugin.
3. Confirm the mode (sandbox vs live) and credentials, then save. Affirm now
   appears as a payment option at checkout.

## How the payment flow behaves

At checkout the customer selects Affirm and completes Affirm's financing steps.
Your Drupal server then **authorizes and captures** the charge server‑side against
Affirm's authenticated API, using your private key and the checkout token Affirm
returns — it does not simply trust a client‑side "success" message. Keep the
private key secret and serve checkout over HTTPS.

## Advertising blocks

Commerce Affirm provides blocks that promote Affirm's offering. To display them,
go to **Structure → Block layout** (`/admin/structure/block`) and place the Affirm
block(s) in a region. On product pages, the messaging block uses the product's
price to show the estimated monthly payment.

## Test before going live

With everything in **sandbox** mode, place a test order through the Affirm flow and
confirm the charge is authorized and captured against your Affirm sandbox account.
Only then swap in your production keys and set the mode to **live**.

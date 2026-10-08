# Configuration

Commerce Culqi is configured the same way as any Drupal Commerce payment gateway:
you add a gateway, choose the Culqi type, and enter your credentials. There is no
separate module settings page.

## Store your Culqi keys safely

Your Culqi **secret key** is a credential — treat it like a password. Rather than
pasting it into configuration that ends up in the database or exported config,
keep it in an environment variable and reference it through a **Key** entity.

With DDEV, set the secret as an environment variable and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --culqi-secret-key=sk_test_xxxxxxxx
ddev restart
```

Then install the **Key** module if it is not already enabled and create a Key
that reads from that environment variable:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save culqi_secret_key --label='Culqi Secret Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"CULQI_SECRET_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Never commit `.ddev/.env` to version control.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** (for example "Culqi card") and choose the **Culqi** plugin
   for card payments, or **Culqi Cash** for the cash / PagoEfectivo flow. You can
   add both if you want to offer each option.
3. Enter your Culqi **public key** and **secret key**. Use your **sandbox** keys
   while testing and switch to **live** keys only once you have confirmed the flow
   end to end.
4. Set the gateway's **Status** to enabled and save.

## Offer the cash / PagoEfectivo flow

If you added the **Culqi Cash** gateway, add the module's **cash message**
checkout pane to your checkout flow (at **Commerce → Configuration → Checkout
flows**) so customers see the PagoEfectivo instructions after placing the order.

## Test before you go live

Culqi provides sandbox credentials and test cards. Run a full purchase — card
tokenization, charge, and (if used) the cash instructions — against the sandbox
before switching to live keys.

## Security caveat — please read

The module's public documentation records a **price‑manipulation** issue that you
should understand and mitigate before taking real money:

- The front‑end Culqi JS calls the module's `create_charge` (and `create_order`)
  endpoints to create the charge. **These endpoints are reachable anonymously**
  (their route access is effectively open).
- More importantly, the charge amount is built from the **incoming request** —
  the amount the client sends — rather than being re‑derived server‑side from the
  authoritative Commerce order total. A caller who talks to the endpoint directly
  could therefore influence the amount that is charged.

What to do about it as a site operator:

- **Validate the charge amount server‑side** against the order total before the
  charge is created, so a client‑supplied amount cannot override the real price.
- **Restrict or firewall the `create_charge` / `create_order` endpoints** if your
  deployment does not need them publicly reachable.
- Keep in mind the separate `order_event` endpoint *is* protected (it requires
  Basic Auth and a logged‑in user) — the concern is specifically the anonymous
  charge‑creation path.

This is recorded from the module's own review notes; it is surfaced here so you
can harden your deployment accordingly.

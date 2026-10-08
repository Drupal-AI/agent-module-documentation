# Configuration

Nexi XPay needs a small amount of configuration before it can take payments: the
Nexi **environment** and your Nexi **credentials**. Everything is done through the
standard Drupal admin UI — no code required.

## Open the settings form

1. Log in as a user with the **administer nexi xpay** permission (an administrator
   by default).
2. Go to **Configuration → Web Services → Nexi XPay**, or navigate directly to
   `/admin/config/services/nexi_xpay`.

## Environment and credentials

On the settings form you:

- **Choose the Nexi environment** — **Test (sandbox)** while you are integrating
  and testing, or **Production** for live payments. Always complete a full test in
  sandbox before switching to production.
- **Enter the required Nexi credentials** — the API key / alias and MAC secret
  issued by Nexi for your account. These identify your shop to Nexi and are used to
  sign requests to the Hosted Payment Page.

After saving, the module adds the **Nexi XPay transaction** entity. You create a
transaction at **Content → Nexi XPay transactions**, then share the generated
payment link with the customer. Viewing transactions is gated by the **view nexi
xpay transactions** permission.

## How the payment outcome is confirmed (verification posture)

Understanding how the module confirms a payment matters for any gateway
integration:

- The customer is redirected to Nexi to pay and returned to your site. The
  authoritative confirmation comes from Nexi's **server‑to‑server notify
  callback**, not from the browser return, which is the correct design.
- The notify endpoint is `/nexi-xpay/notify/{transaction}/{token}`. Each
  transaction carries its own **256‑bit secret token** (a 64‑character hex string),
  and the module's access check verifies that token with a **constant‑time
  `hash_equals()`** comparison before it will process the callback. A caller who
  does not know the per‑transaction token is rejected, so forged or guessed notify
  requests do not mark orders as paid. This is a solid, defensive posture — the
  callback authenticates the caller by a per‑transaction shared secret rather than
  trusting arbitrary request input.
- Status handling is described as **idempotent**, so a notification delivered more
  than once does not double‑process the payment.

In short: the module protects the callback with a strong per‑transaction secret
verified in constant time, which is the key control you want on a payment notify
endpoint. As always with payments, reconcile against your Nexi back office and test
the full flow (success, cancellation, and repeated notifications) in sandbox before
going live.

## Store the Nexi credentials as secrets

The API key/alias and MAC secret are sensitive and must **never** be committed to
version control or pasted into exported configuration. Keep them in an environment
variable and reference them through Drupal.

1. **Store the value in a DDEV environment variable** (do not commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nexi-mac-secret=<value>
   ddev restart
   ```

   The flag `--nexi-mac-secret` becomes the variable `NEXI_MAC_SECRET`. Repeat for
   the API key/alias as needed.

2. **Confirm the variable is present in the container without printing it:**

   ```bash
   ddev exec 'test -n "$NEXI_MAC_SECRET"'   # exit status 0 means it is set
   ```

3. **Expose it to Drupal via a Key entity** (install the Key module if needed —
   `ddev composer require drupal/key && ddev drush en key -y`) using the built‑in
   environment provider:

   ```bash
   ddev drush key:save nexi_mac_secret --label='Nexi MAC secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"NEXI_MAC_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   Then select that Key on the settings form if the field supports a Key
   reference; where it does not, read the value from settings.php via
   `getenv('NEXI_MAC_SECRET')`.

## Egress note

This module makes outbound HTTPS calls to Nexi (for the Hosted Payment Page and
transaction handling), and Nexi calls back into your site's notify endpoint. If
your environment restricts outbound traffic, allow HTTPS egress to Nexi's XPay
hosts, and make sure your site is reachable over HTTPS for the inbound notify
callback.

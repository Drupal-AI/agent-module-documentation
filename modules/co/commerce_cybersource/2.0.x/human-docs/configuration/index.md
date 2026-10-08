# Configuration

CyberSource is configured like any Drupal Commerce payment gateway, but it also
requires matching setup in your **CyberSource account** and — for the hosted
checkout flow — a change to Drupal's cookie handling. Work through all three parts
below.

## Store your CyberSource credentials safely

The shared **secret key** used to sign and verify payment responses is a
credential — keep it out of plain configuration. Store it in an environment
variable and reference it through a **Key** entity.

With DDEV, set the secret and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --cybersource-secret-key=<value>
ddev restart
```

Then enable the **Key** module and create a Key that reads the environment
variable:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save cybersource_secret_key --label='CyberSource Secret Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"CYBERSOURCE_SECRET_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Never commit `.ddev/.env` to version control.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** and choose the CyberSource plugin. Select the API you want:
   - **Secure Acceptance Hosted Checkout (SAHC)** — an off‑site redirect flow.
   - **Flex Microform v2** — an on‑site iframe flow.
3. Enter your CyberSource credentials — the merchant/profile identifiers and the
   **secret key** (reference the Key you created above where the form allows it).
4. Choose the **mode** — use your CyberSource **sandbox** account while testing and
   switch to **production** only after a successful end‑to‑end test.
5. Enable the gateway and save.

## Apply the required CyberSource account settings

Both APIs require specific settings on the CyberSource side (in your live or
sandbox account), and the module's **README** documents exactly which. Apply those
before testing — the integration will not complete correctly otherwise.

## SameSite cookie change for SAHC

Because SAHC sends the customer off‑site and then returns them to your store, the
return can be lost if Drupal's default **SameSite cookie attribute** blocks the
cookie on the cross‑site return. The README documents the manual change required
to Drupal's SameSite setting for SAHC to work. Make this change if you use the
hosted‑checkout flow.

## Test before you go live

CyberSource provides a sandbox and test card numbers. Run a full purchase against
the sandbox — including the return/response handling — before switching to live
credentials.

## Security notes

How the integration protects payments:

- **Card data stays off your server.** SAHC and Flex Microform mean card details
  are entered against CyberSource, reducing your PCI scope. This is the correct
  architecture.
- **The payment response is signature‑verified.** The module recomputes the
  HMAC‑SHA256 over the signed response fields with your shared secret and rejects
  the response on any mismatch, and the return handler throws a payment exception
  on failure. A forged "payment accepted" response without a valid signature is
  therefore rejected — exactly the check that matters most.

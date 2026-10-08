# Configuration

Setting up Redsys payment has three parts: create a **Key** that holds the
merchant secret, fill in the **Redsys settings** form, and place the **payment
form block**. Because this is a payment gateway, the secret handling matters most —
do it first.

## 1. Store the merchant secret in a Key

The module never stores the Redsys secret in its own configuration — it stores
only the **ID of a Key entity** that holds the secret. So create the Key first.

1. Keep the secret out of version control by putting it in an **environment
   variable**. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --redsys-merchant-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Create an **authentication** Key backed by the environment provider at
   **Configuration → System → Keys** (`/admin/config/system/keys`), or via Drush:

   ```bash
   ddev drush key:save redsys_merchant_key --label='Redsys Merchant Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"REDSYS_MERCHANT_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   In production use a **file, environment, or external** Key provider — **not**
   the configuration provider, which would write the secret into exported config.
   A missing or empty key throws and blocks both payment creation and callback
   validation, so the Key must resolve to a real value.

## 2. Fill in the Redsys settings

Go to **Configuration → System → Redsys settings**
(`/admin/config/system/redsys-settings`, route `redsys_button.redsys_config_form`;
requires the **Administer redsys settings** permission). The form writes to the
`redsys_button.settings` config object. Field by field:

- **Environment** *(default `test`)* — `test` or `live`. Selects the Redsys
  endpoint (test `sis-t.redsys.es`, live `sis.redsys.es`). Stay on `test` until
  end‑to‑end payments succeed.
- **Merchant code** — your FUC, digits only, up to 16. Required.
- **Key** — pick the **Key entity** you created above (the one holding the
  merchant secret). Required.
- **Terminal** *(default `001`)* — 1–3 digits, non‑zero.
- **Currency** *(default `978`)* — ISO 4217 numeric code (`978` = EUR).
- **Transaction type** — always forced to `0` on save.
- **Language** *(default `001`)* — the Redsys consumer language code (for example
  `001` Spanish, `002` English).
- **Notification email** *(optional)* — an address emailed **only after** a
  signed successful notification.
- **Signature version** *(default `HMAC_SHA512_V2`)* — use the SHA‑512 V2 default
  for new terminals; choose **`HMAC_SHA256_V1`** only for legacy terminals that
  require it.

Save the form. (You can also set non‑secret values from the CLI, e.g.
`drush cset redsys_button.settings merchant_code 123456789 -y`; the secret itself
always lives in the Key entity.)

## 3. Place the payment form block

Add the **Redsys Button Block** (block plugin `redsys_button_block`, in the
*Forms* category) to a region via **Structure → Block layout**, on the page where
you want to accept standalone payments. Customers fill in the amount, email,
description, and method, then get redirected to Redsys.

## How callbacks are verified (nothing to configure — good to understand)

The bank posts results to the public `/redsys/notify` route. Although that route
is unauthenticated by necessity (Redsys is an outside caller), the module does
**not** trust the request blindly:

- it verifies the Redsys `Ds_Signature` with a **timing‑safe** comparison against
  your Key‑held secret, and
- it matches the **amount, currency, merchant, terminal, and transaction type**
  to the local operation **before** the payment is marked completed.

Processing is **idempotent**, so a repeated notification won't fulfil twice, and
the confirmation email is sent only after a signed success. The return and cancel
pages are guarded by unguessable per‑operation tokens. You don't configure any of
this — but it's why forged "paid" callbacks are rejected.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`) as needed —
all are marked *restrict access*:

- **Administer redsys settings** — the settings form above.
- **View redsys payments** — the payment audit list and detail pages
  (`/admin/content/redsys-payments`).
- **View redsys payment requests** — viewing the payment‑request list/detail.
- **Administer redsys payment requests** — create/duplicate/cancel payment
  requests (`/admin/content/redsys-payment-requests`).

## Submodule credentials

If you enable **`commerce_redsys_button`**, remember its gateway credentials
(merchant code, key, terminal) are set **per Commerce gateway** at
`/admin/commerce/config/payment-gateways`, independently of the global
`redsys_button.settings` above. The **`redsys_button_webform`** handler reuses the
core signing/validation and maps webform elements to the amount, email, and
description.

## Test before going live

Run real payments — and confirm their signed return notifications — against the
Redsys **test** environment first. Only switch **Environment** to `live` once test
payments behave correctly end to end.

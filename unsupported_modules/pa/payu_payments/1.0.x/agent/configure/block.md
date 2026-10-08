<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the PayU Donations block

1. Go to `/admin/structure/block` and **Place block** → "PayU Block" in a region.
2. Fill the required fields:
   - `payu_environment` — Production (`secure`) or Sandbox.
   - `payu_pos_id` — PayU point-of-sale id.
   - `payu_second_key_md5` — MD5 signature key.
   - `payu_client_id` / `payu_client_secret` — OAuth credentials.
   - `payu_currency` — ISO-4217 code.
   - `payu_payment_description`, `payu_submit_button_text`.
3. The visitor sees an amount field plus the submit button.

## Runtime
`PayUBlock::build()` requires the `OpenPayU_Configuration` class (install `payu/openpayu`) and configures it from block settings. `PayUForm::submitForm()` builds the order (amount ×100 for minor units except HUF), calls `OpenPayU_Order::create()`, and redirects to `response->getResponse()->redirectUri` via `TrustedRedirectResponse` when the status is `SUCCESS`.

## Notes for agents
- There is **no** inbound PayU notification/IPN route in this module; do not look for a signature-verification handler here.
- Credentials live in block config — handle exported block config as secret material.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a "PayU Block" that renders a donation form; a visitor enters an amount and is redirected to PayU to complete payment.

---

The block (`payu_payments_block`) is configured per placement at `/admin/structure/block` with PayU merchant data: environment (production/sandbox), point-of-sale ID, MD5 second key (signature key), OAuth client_id and client_secret, currency (ISO-4217), payment description and button label. At render time `PayUBlock::build()` pushes those into the `OpenPayU_Configuration` static (requiring the `payu/openpayu` PHP library) and builds `PayUForm`. On submit, `PayUForm` assembles an order — description, customer IP, merchant POS id, currency, and the amount (multiplied by 100 for minor units except HUF) — calls `OpenPayU_Order::create()`, and on `SUCCESS` issues a `TrustedRedirectResponse` to PayU's `redirectUri`.

This is a create-order-and-redirect flow with no local callback/notify (IPN) route, so order fulfilment and payment verification happen on PayU's side rather than in this module. The amount is entered by the visitor, which is expected for a donation form. Note that the PayU secrets (second key / MD5 signature key and OAuth client_secret) are stored in block configuration and entered through plain textfields, so block config exports contain live credentials and should be treated as sensitive; there is no server-side signature verification here because the module never receives an inbound PayU callback.

---
- Place a PayU donation block in a region
- Choose production or sandbox environment per block
- Set the PayU point-of-sale (pos_id)
- Configure the MD5 second/signature key
- Configure OAuth client_id and client_secret
- Pick the donation currency (ISO-4217)
- Set the payment description sent to PayU
- Customise the submit button label
- Let visitors enter an arbitrary donation amount
- Validate that the amount contains only numbers
- Redirect the donor to PayU to complete payment
- Raise funds for a charitable cause on a page
- Run multiple donation blocks with different currencies
- Test the flow against the PayU sandbox first
- Log PayU order errors to the payu_payments channel

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Wise provides Commerce integration for Wise.

---

Commerce Wise **provides a Wise Quick Pay off-site payment gateway** for Drupal Commerce.
At checkout the shopper is redirected (GET) to a Wise Quick Pay payment link
(`https://wise.com/pay/business/{wise_tag}?amount=&currency=&description={reference}`);
Wise then notifies the store of the deposit through a webhook, which the module maps back
to the local order and records the payment. It depends on Commerce Payment and Commerce
Order.

Use it to accept Wise Quick Pay payments. It registers **one gateway plugin**
(`wise_quick_pay`, label "Wise Quick Pay", display "Wise") extending
`OffsitePaymentGatewayBase`. The gateway form configures a **Wise @tag** (`wise_tag`),
**Wise's webhook public key** (`public_key`), the **account type** (`business`), a
**logging** checkbox, and the standard test/live **mode** (which selects the Wise host).
The webhook endpoint is the Commerce-provided `/payment/notify/{gateway}` route handled by
`onNotify()`: it reads the `X-Signature-SHA256` header and calls `openssl_verify` against
the configured public key, then, for a `balances#update` event with a numeric
`transfer_reference`, loads the order by that reference and records a completed payment
before transitioning the order to `place`. Two alter events —
`commerce_wise.quick_pay_link` and `commerce_wise.quick_pay_reference` — let other modules
change the redirect reference/amount and the reference-to-order mapping. There are no
routes, permissions, config schema, or credentials/API-token fields of its own. Serve the
site over HTTPS.

---

- Provide a Wise Quick Pay off-site payment gateway (`wise_quick_pay`).
- Redirect the shopper (GET) to a Wise Quick Pay payment link at checkout.
- Build the link as `{host}/pay/business/{wise_tag}?amount=&currency=&description={reference}`.
- Select the Wise host from the gateway mode (live → wise.com, test → sandbox.transferwise.tech).
- Receive Wise deposit webhooks on the Commerce `/payment/notify/{gateway}` route.
- Verify the `X-Signature-SHA256` header via `openssl_verify` against the configured public key.
- Map a numeric `transfer_reference` to a local order, then record a completed payment.
- Transition the order to `place`, unlock, and save on a matched webhook.
- Configure the Wise @tag, Wise's webhook public key, account type, mode, and logging.
- Alter the redirect via `commerce_wise.quick_pay_link` (order, reference, balance).
- Alter reference-to-order matching via `commerce_wise.quick_pay_reference`.
- Depend on Commerce Payment + Commerce Order.
- Note: the module has no API token, no routes/permissions, and no config schema of its own.
- Serve the site over HTTPS.

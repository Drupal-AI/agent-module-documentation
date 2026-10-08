<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
eSewa Payment Gateway integrates Drupal Commerce with Nepal's eSewa ePay v2 API as an off-site redirect payment gateway.
---
At checkout the gateway plugin (`EsewaCheckoutCheckout`) builds a signed request via the eSewa SDK and redirects the customer to eSewa, storing the order/gateway/transaction UUID and total in the PHP session. eSewa then redirects the browser back to `/esewa/success?data=<base64>` (or `/esewa/cancel`). The success controller verifies the HMAC-SHA256 signature on the returned payload through the SDK's `verifyPayment()`, cross-checks the transaction UUID against the session (replay protection), requires `status === COMPLETE`, and validates the returned amount against the stored total (±0.01) before creating the completed payment and advancing checkout. The cancel route unlocks the order and steps it back so the customer can retry.

Both callback routes are `_access: 'TRUE'` by necessity — eSewa's server redirects an unauthenticated browser to them — but the success path performs no order fulfilment without a valid signature, a matching session UUID, a COMPLETE status, and an amount match, so the open access does not permit forged completions. Configure it as a payment gateway at `/admin/commerce/config/payment-gateways`, supplying eSewa merchant/secret credentials and test/live mode.
---
- Accept eSewa payments in a Drupal Commerce store
- Offer eSewa as an off-site redirect checkout option
- Verify eSewa's HMAC-SHA256 signed response before completing payment
- Cross-check the transaction UUID to block replay attacks
- Validate the charged amount against the order total
- Complete a Commerce payment on a verified success callback
- Roll the order back a step on cancellation/failure
- Run the gateway in test mode against eSewa sandbox
- Switch to live eSewa credentials for production
- Customise the success message via hook_esewa_success_message
- Customise the cancel message via hook_esewa_failure_message
- Store transaction UUID/total in session for verification
- Unlock a locked order after a cancelled payment
- Reconstruct callback URLs to rebuild the eSewa client
- Log signature-verification failures for auditing
- Configure the gateway at the Commerce payment-gateways page
- Support NPR-denominated payments for Nepali customers

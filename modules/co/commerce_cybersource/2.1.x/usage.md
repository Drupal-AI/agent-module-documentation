Commerce CyberSource integrates Drupal Commerce with CyberSource (Visa Acceptance Solutions) through three payment gateway plugins: Secure Acceptance Hosted Checkout (SAHC), Flex Microform v2, and Unified Checkout.

---

The module adds CyberSource as a payment provider for Drupal Commerce stores, letting shoppers pay by credit card without card data ever touching your server (PCI-scope reduction). SAHC redirects the customer off-site to a CyberSource-hosted page; Flex Microform embeds tokenizing card fields on your own checkout via an iframe; Unified Checkout renders CyberSource's newer hosted widget (with optional Google Pay / Apple Pay / Click to Pay) inline. Flex and Unified Checkout call the CyberSource REST API for authorization, capture, refund, and void, support 3-D Secure (Payer Authentication) with an optional step-up challenge, and store reusable payment instruments via CyberSource Token Management. SAHC is deprecated and slated for discontinuation in September 2026, with Unified Checkout as the recommended path forward.

---

- Accept credit-card payments (Visa, Mastercard, Amex, Discover, Diners Club, JCB, Maestro, UnionPay) in a Drupal Commerce store through CyberSource.
- Keep card data out of your server and reduce PCI scope by redirecting to CyberSource's hosted checkout (SAHC) or tokenizing card fields client-side (Flex / Unified Checkout).
- Offer an off-site redirect checkout with SAHC for merchants who want CyberSource to host the entire payment page.
- Embed on-site card entry with Flex Microform v2 so customers never leave your checkout flow.
- Use Unified Checkout to present card entry plus digital wallets (Google Pay, Apple Pay, Click to Pay) in one hosted widget.
- Authorize funds only and capture later, or authorize and capture in a single transaction.
- Capture a previously authorized payment (fully or partially) from the Drupal order admin.
- Refund captured payments in full or in part, tracking partially-refunded state.
- Void an authorization before it is captured.
- Tokenize cards into reusable payment instruments so returning customers can pay with a stored card.
- Add 3-D Secure / Strong Customer Authentication (SCA) via Payer Authentication, including an optional mandatory step-up challenge (challengeCode 04) for European SCA compliance.
- Skip or auto-submit the checkout review step when no 3DS challenge is required, streamlining the flow.
- Run against the CyberSource sandbox in Test mode and switch to Live mode for production without code changes.
- Choose HTTP Signature or JWT v2 shared-secret (HMAC HS256) authentication for REST API calls, ahead of the September 2026 HTTP Signature deprecation.
- Localize the hosted widget with per-gateway locale and country settings across dozens of languages.
- Restrict which card networks and payment types are offered in Unified Checkout.
- Configure a capture mandate in Unified Checkout to request the customer's email, phone, or shipping address and limit ship-to countries.
- Sync the billing address collected in the Unified Checkout widget back to the Drupal order's billing profile.
- Pass order line items (SKU, name, quantity, price) to CyberSource for richer transaction records and decision management.
- Record AVS (address verification) response codes and human-readable labels on SAHC payments.
- Log CyberSource requests and responses to a dedicated logger channel for debugging (off by default; contains PII when enabled).
- Track failed transactions as order log comments visible in the order's activity history.
- Support both Drupal Commerce 2.37+ and 3.x on Drupal 10.3+ / 11.

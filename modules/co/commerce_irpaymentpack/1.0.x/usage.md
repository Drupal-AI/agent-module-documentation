<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Iranian Payment Pack provides a collection of Iranian bank gateways.

---

Commerce Iranian Payment Pack provides a **collection of Iranian bank payment gateways** for Drupal
Commerce (e.g. Saman/SEP and other local banks) — letting Iranian merchants accept card payments through their
banks' gateways. It depends on Commerce and Commerce Payment, in the Commerce (contrib) package.

Use it to accept payments via Iranian banks. It is an e-commerce/payment feature, and (for the reviewed Saman
gateway) it follows the correct pattern: after the bank redirect it **confirms the transaction server-side with
the bank** (`VerifyTransaction` against the bank's authoritative endpoint) and only completes the payment when
that verification succeeds — not trusting the client return alone. Handle each bank's **merchant credentials** as
secrets over HTTPS, and (as always) verify each gateway's return/verification flow for your version. It has no
access-control role. Configure the bank gateway credentials.

---

- Provide Iranian bank gateways.
- Accept card payments via local banks.
- Support Saman/SEP and others.
- Depend on Commerce and Commerce Payment.
- Serve Iranian merchants.
- Offer multiple gateways.
- Confirm the transaction server-side with the bank.
- Complete payment only on successful VerifyTransaction.
- Not trust the client return alone.
- Store merchant credentials as secrets over HTTPS.
- Verify each gateway's flow per version.
- Have no access-control role.
- Handle Iranian payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the integration.
- Take payments.
- Secure the credentials.
- Provide Iranian payment gateways.

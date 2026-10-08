<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
B2B procurement features for MonkeysCommerce (companies, quotes, POs, PunchOut).

---

MKC B2B adds B2B procurement features to MonkeysCommerce — companies, quotes, purchase orders, contract pricing, and PunchOut (cXML/OCI) — so a store can serve business buyers with procurement-system integration.

**Security note (as shipped, 1.0.1):** the PunchOut endpoints `/mkc/punchout/cxml` and `/mkc/punchout/oci` are `_access: 'TRUE'`; the cXML handler verifies the sender `SharedSecret` with `hash_equals()` **only when a secret is configured** — when `cxml_shared_secret` is unset (the default) the credential check is skipped and an anonymous cXML SetupRequest can start a PunchOut session (B2B-catalog/pricing exposure). **Configure the PunchOut shared secret.** Depends on the MonkeysCommerce suite; supports Drupal 11.3+ and 12.

---

- Add B2B procurement.
- Provide companies/quotes/POs.
- Support contract pricing.
- Provide PunchOut (cXML/OCI).
- WARNING: PunchOut skips credential check when no secret set.
- Verify SharedSecret with hash_equals when configured.
- Require setting the PunchOut secret.
- Depend on the MonkeysCommerce suite.
- Support Drupal 11.3+ and 12.
- Serve business buyers.
- Handle procurement.
- Configure PunchOut.
- Support Drupal.
- Support Drupal.
- Support Drupal.

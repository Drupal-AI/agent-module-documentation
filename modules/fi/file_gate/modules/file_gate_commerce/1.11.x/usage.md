<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Gate Commerce gates file delivery behind a completed purchase or entitlement, re-checked live on every download.

---

File Gate Commerce is an optional submodule of File Gate that adds a `commerce` gate method: a gated file is
delivered only to a buyer or licensee, and the entitlement is re-checked **live on every download** so expiry and
revocation take effect immediately. It depends only on `file_gate`; the bundled checker additionally needs Drupal
Commerce (`commerce_order`). The `commerce` method decides access live (`mint()` returns `NULL`, so there is no
pre-issued URL) and delegates to a swappable `EntitlementCheckerInterface` service. The bundled
`CommerceEntitlementChecker` grants when the requesting authenticated user placed a completed order (state
`completed` or `fulfillment`) containing a purchased product variation whose SKU matches the field's configured
SKU, using a bounded SKU-scoped query with a bounded legacy scan fallback. Override
`file_gate_commerce.entitlement_checker` to gate on licences or an external entitlement API instead. This is
access gating, not DRM. Enable with `drush en file_gate_commerce`.

---

- Sell a downloadable file and deliver it only to buyers (`commerce` gate method).
- Re-check entitlement live on every download so a refund or expiry revokes access immediately.
- Grant access on a completed Drupal Commerce order (state `completed` or `fulfillment`).
- Match access to a specific product variation SKU configured on the gated field.
- Serve licence-based downloads by swapping the `file_gate_commerce.entitlement_checker` service.
- Gate on an external entitlement API by implementing `EntitlementCheckerInterface`.
- Deny anonymous requests and empty-SKU fields (fail closed).
- Bound the entitlement query for large B2B accounts (SKU index, then a capped recent-order scan).
- Fall back gracefully when Commerce is absent (checker returns FALSE; a warning appears on the status report).
- Combine paid access with File Gate's deny-by-default `/system/files` protection.
- Keep the download route free of tokens — access is decided from the buyer's live session.
- Gate a Commerce license file, a paid whitepaper, or member-only media.
- Avoid a full order-history load — the checker scopes to the matching SKU or the account's recent orders.
- Restrict downloads to the exact purchaser (the order's `uid` must equal the requesting account).
- Layer the commerce gate alongside signed-URL, OTP, or assurance gates on other fields.

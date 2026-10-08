<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Achla AI Search connects a Drupal site to the hosted Achla AI Search service and embeds a signed, backend-authorized search/answer widget on public pages.
---
Search indexing, answer generation, billing, and widget design all live in the Achla SaaS; the Drupal module is intentionally small and only proves site ownership, stores connector authority locally, checks lifecycle state, and places the verified widget. Connection uses the **Ownership v2** protocol: Drupal starts an attempt from the admin page, and Achla completes it by calling back server-to-server. There is no pasted-key setup path.

The public callback route `/achla-ai/ownership/callback` (POST, `_access: 'TRUE'`) is deliberately open because it is authenticated cryptographically rather than by Drupal permission: `OwnershipCallbackController` runs a bounded-body/JSON preflight, flood-rate-limits by hashed client IP (30 per 300s), then `OwnershipManager::handleCallback()` calls `callbackVerifier->parseAndVerify()` and confirms a PKCE-style `code_challenge` with `hash_equals()` before binding. Production trust anchors are compiled into the release package as public verification keys; if the policy chain is unavailable, callback and widget verification fail closed. All admin/config and AJAX routes are gated by the restricted `manage achlaai_search connector` permission (the placement-validation route additionally requires a CSRF token). Typical setup: install, grant the connector permission to a trusted operator, open the settings page, and complete Ownership v2 reconnect.
---
- Connect a Drupal site to the Achla AI Search hosted service.
- Complete the Ownership v2 server-to-server verification flow.
- Grant the restricted `manage achlaai_search connector` permission to trusted operators only.
- Place the signed search/answer widget on public pages via a configured CSS selector.
- Validate a placement selector from the admin UI (CSRF-protected AJAX).
- Check connector lifecycle/status at `/admin/config/services/achlaai-search/status`.
- Disconnect a site from Achla.
- Migrate from the legacy `achlaai/achlaai-search` beta package to `drupal/achlaai_search`.
- Reconnect after an upgrade that disabled a previous connector.
- Recover a stalled ownership attempt via DNS polling without exposing the verifier to the browser.
- Confirm the site origin is public before starting a connection.
- Rely on flood rate-limiting to blunt callback abuse.
- Serve only backend-authorized, signed widget releases (no arbitrary JS).
- Keep local connector authority stored securely rather than as a pasted key.
- Ensure HTTPS site origin for production trust.
- Review the status endpoint after a lifecycle change reported by Achla.
- Restrict widget output until ownership is proven (fail-closed).
- Audit callback rejections in the module log channel.
- Provide site-owner search without hosting the index locally.
- Emit non-cacheable, nosniff, no-referrer headers on callback responses.

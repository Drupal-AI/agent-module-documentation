<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Achla AI Search — ownership callback

`POST /achla-ai/ownership/callback` — route `_access: 'TRUE'` (intentionally public; authenticated by cryptography, not Drupal permission).

Flow in `OwnershipCallbackController::callback()`:
1. **Preflight** — rejects query strings, non-`application/json`, and bodies over `OwnershipProtocol::MAX_CALLBACK_BYTES` (400/413).
2. **Flood** — `flood->isAllowed('achlaai_search.ownership_callback', 30, 300, sha256(client_ip))`; 429 when exceeded.
3. **Verify** — `OwnershipManager::handleCallback()` → `callbackVerifier->parseAndVerify()`, then confirms the PKCE `code_challenge` against the stored verifier with `hash_equals()` and completes the binding via `ownershipClient->complete()`.
4. Responds `204` with `Cache-Control: no-store`, `X-Content-Type-Options: nosniff`, `Referrer-Policy: no-referrer`; failures return a generic `callback_rejected`.

Production trust anchors are compiled-in public keys; missing policy chain → fail closed. No configuration body is returned to the caller.

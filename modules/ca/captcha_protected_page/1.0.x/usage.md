<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAPTCHA Protected Page

## What it is / when to use

- Forces users to pass a CAPTCHA challenge before viewing configured paths (exact or `/prefix/*` wildcard).
- Anonymous users always challenged; selected authenticated roles can also be required.
- Use to shield download or sensitive listing pages from bots.

---

## Install & configure

- Requires the `captcha` module.
- Configure at `/admin/config/system/captcha-protected-page` (route `captcha_protected_page.settings`, permission `administer captcha protected pages`).
- Enter one protected path per line; set cookie expiration (seconds) and any additional roles.
- Once verified, a cookie is set so the user is not re-challenged until it expires.

---

## Usage & API notes

- A kernel `REQUEST` event subscriber (`CaptchaRedirectSubscriber`) intercepts matching paths and redirects to `/captcha-protected-verify`.
- After passing the CAPTCHA (`CaptchaForm`), a verification cookie named `captcha_protected_<hash>` with value `verified` is set.
- SECURITY (bypass 1): the cookie name is `Crypt::hashBase64($path)` (an UNKEYED SHA-256 of the known path) and the value is the constant string `verified` — any client can precompute the cookie name and set the value to bypass the gate without solving a CAPTCHA.
- SECURITY (bypass 2): `shouldSkipVerification()` returns TRUE for any `POST` request, so POST requests to a protected path skip the challenge.
- The gate is a redirect layer, not access control — the underlying content permissions are unchanged.
- Authenticated users are skipped unless one of their roles is in the configured `roles` list.
- Protected-path matching supports exact match and `/*` prefix wildcards.
- The subscriber runs at priority 28 on `KernelEvents::REQUEST`.
- Original URL is stashed in the session and restored after verification.
- Cookie is `HttpOnly`, `SameSite=Lax`, secure-flag mirrors request scheme.
- Cookie expiration defaults to 86400 seconds.
- The verify form route `/captcha-protected-verify` requires `access content`.
- To harden, bind the cookie value to a server-side signed token/nonce and do not blanket-skip POST.
- The settings permission is marked `restrict access: true`.
- Config object is `captcha_protected_page.settings` (`protected_paths`, `cookie_expiration`, `roles`).
- The subscriber logs cookie checks at notice level (verbose).

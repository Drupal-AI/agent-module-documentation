<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent Unsafe Login (prevent_unsafe_login) — agent index

**Disables the user login form when the request scheme is not HTTPS, so credentials cannot be submitted over plaintext.**

- **Version:** 8.x-1.x (info.yml `8.x-1.2`)
- **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Configuration:** none.
- **How it works:** `hook_form_alter` on `user_login_form` sets `#disabled` and shows a warning fieldset when `request->getScheme() !== 'https'`; `hook_module_implements_alter` moves the alter last; cache context service `cache_context.url.site.scheme__prevent_unsafe_login` (`UrlSchemeCacheContext`) separates cached HTTPS/non-HTTPS variants.
- **Security:** app-level defense-in-depth for the **login form only** — it disables the form on non-HTTPS but does not force site-wide HTTPS or redirect; combine with server/Drupal HTTPS enforcement. drush login still works on dev. No request-facing endpoints of its own.

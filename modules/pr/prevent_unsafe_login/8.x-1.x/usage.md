<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent Unsafe Login disables the Drupal user login form whenever the current request is served over a non-HTTPS scheme, preventing users from POSTing their username and password over a plaintext connection.

---

Via `hook_form_alter` on `user_login_form`, when `\Drupal::request()->getScheme()` is not `https` the module sets `#disabled` on the form and prepends a fieldset explaining that login over a non-HTTPS connection is forbidden, advising a one-time login link or `drush uli` instead. A `hook_module_implements_alter` moves this alter to the end of the implementation list so it runs after other modules. The scheme decision is made cacheable through a dedicated cache context `url.site.scheme__prevent_unsafe_login` (service `UrlSchemeCacheContext`), added to the form's cache metadata so the HTTPS and non-HTTPS variants are cached separately (the custom suffix avoids clashing with an upcoming core cache context).

This is defense-in-depth for the login form specifically; it does not enforce HTTPS site-wide, redirect to HTTPS, or block already-authenticated sessions — pair it with server/Drupal-level HTTPS redirection for full coverage. On dev sites you can still authenticate via drush. No routes, permissions or configuration.
---
- Block password submission over plain HTTP on the login form.
- Show a clear "unsafe login forbidden" message on non-HTTPS login pages.
- Encourage one-time login links when HTTPS is unavailable.
- Keep drush-based login working on dev sites without HTTPS.
- Add defense-in-depth on top of server HTTPS redirection.
- Prevent credential capture on misconfigured mixed-scheme environments.
- Disable all login form fields when the scheme is not https.
- Cache HTTPS and non-HTTPS login form variants separately.
- Run the form alter last so it overrides other login form changes.
- Protect the login form on sites behind partial TLS termination.
- Remind editors to use `drush uli` on local/dev instances.
- Reduce risk from users bookmarking an http:// login URL.
- Harden the standard `user_login_form` without custom code.
- Signal to users that plaintext login is intentionally blocked.
- Complement HSTS/redirect policies with an app-level guard.
- Avoid accidental plaintext credential entry on staging.
- Apply protection to any theme rendering the core login form.

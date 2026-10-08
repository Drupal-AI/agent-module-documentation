<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart IP Redirect to Locale (smart_ip_locale_redirect) — agent index

**Redirects visitors to a language matching their IP-derived country, caching the choice in a cookie.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** smart_ip, redirect, path_alias, locale
- **Config route:** `/admin/config/search/smart_ip_locale_redirect` (`AdminForm`), delete route `/…/delete/{country_code}`
- **Permission:** `access smart IP locale redirect settings`
- **Key services:** `smart_ip_locale_redirect.request_subscriber` (KernelEvents::REQUEST @256), `smart_ip_locale_redirect.checker` (`RedirectChecker`)
- **Security:** Admin config routes are permission-gated. The request subscriber runs for anonymous traffic but only issues a `TrustedRedirectResponse` to the site's OWN scheme+host+base (langcode/path appended); the redirect target is not attacker-controllable to an external domain, so no open-redirect. The `update_hl` param and `smart_ip_hl` cookie only choose a langcode. Only GET/HEAD front-controller requests are redirected.

See [configure/settings.md](configure/settings.md)
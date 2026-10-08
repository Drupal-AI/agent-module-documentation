<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymous Redirect — agent index

Redirects anonymous users to an internal path or external URL on every request; authenticated users are unaffected. No plugins, no permissions of its own, no Drush. Configured at `/admin/config/system/anonymous-redirect` (route `anonymous_redirect.settings`, gated by core `administer site configuration`).

- **Config keys, defaults, override/wildcard behavior, external vs internal handling** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `anonymous_redirect.settings`: `enable_redirect` (bool, default `false`), `redirect_url` (default `/user/login`), `redirect_url_overrides` (newline-separated paths, `*` wildcards).
- Logic in `AnonymousRedirectSubscriber::redirectAnonymous()` (kernel REQUEST, priority 100). Early-returns unless enabled + anonymous + not maintenance mode; skips `assets://` paths.
- External URL → `TrustedRedirectResponse`; `<front>` → front page; else internal path. Login target adds `?destination=<requested path>`.
- `AnonymousRedirectCacheTag` invalidates the `rendered` cache tag on settings save.
- The redirect target is admin-set (trusted). External redirects use `TrustedRedirectResponse`, so the open-redirect surface is limited to whoever holds `administer site configuration`.

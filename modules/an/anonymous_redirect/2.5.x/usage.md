<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anonymous Redirect sends every anonymous (not-logged-in) request to a configured internal path or external URL, while authenticated users browse the site normally. Useful for turning a site into a login-gated, "coming soon", or members-only experience without a full access-control module.

---

The module registers a single kernel `REQUEST` event subscriber (priority 100) that fires on every request. It returns early — doing nothing — unless the `enable_redirect` flag is on, the user is anonymous, and the site is not in maintenance mode; it also skips asset-generation paths (the `assets://` stream wrapper directory). When it does redirect, it reads `redirect_url` from `anonymous_redirect.settings`: an external URL (detected by `UrlHelper::isExternal()`) is issued as a `TrustedRedirectResponse`, `<front>` redirects to the front page, and any other value is treated as an internal path via `Url::fromUri('internal:...')`. A `redirect_url_overrides` textarea (one path per line, `*` wildcards supported through the path matcher) lists paths that are exempted so anonymous users can still reach them (e.g. the login page, a public landing page). When the target is the login route, the originally requested path is appended as a `?destination=` query so the user lands where they intended after logging in. A language prefix at the start of the path is stripped before override matching. All responses attach the config as a cacheable dependency, and a second event subscriber invalidates the `rendered` cache tag whenever the settings are saved so cached pages reflect the new behavior. Configuration lives at `/admin/config/system/anonymous-redirect` behind the `administer site configuration` permission.

---

- Force all anonymous visitors to the login page (`/user/login`) so the site is effectively private.
- Redirect anonymous users to an external "coming soon" or marketing domain while you build the site.
- Gate a members-only community: only authenticated users see content, everyone else is bounced to login.
- Send anonymous users to a custom internal landing/splash page (`/welcome`) instead of the requested content.
- Redirect anonymous traffic to the front page (`<front>`) so only logged-in users reach deep pages.
- Keep the login page reachable for anonymous users by adding it to the override list.
- Whitelist a public path (privacy policy, contact form) via `redirect_url_overrides` so it bypasses the redirect.
- Use `*` wildcards in the override list to exempt an entire section (e.g. `/public/*`).
- Preserve the visitor's intended destination after login using the automatic `?destination=` handling.
- Temporarily lock the whole site to logged-in users during a soft launch.
- Point anonymous users to an external SSO/identity provider domain.
- Redirect to a paywall or subscription domain for non-members.
- Toggle the whole behavior on/off with a single `enable_redirect` config flag (e.g. via Config Split per environment).
- Exempt asset paths automatically so CSS/JS aggregation and image derivatives still generate.
- Keep redirects off during maintenance mode so admins can recover the site.
- Drive the redirect target from `settings.php` config overrides for per-environment control.
- Build a staging-site lockdown that only lets authenticated editors in.
- Redirect anonymous users on a multilingual site while correctly stripping the language prefix before matching overrides.

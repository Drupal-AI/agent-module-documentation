<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Basic Site Settings exposes a site's name, slogan, front page and theme settings over JSON:API, so a decoupled front end can read them from Drupal rather than hard-coding its own copies.

---

A headless front end still needs the handful of values a Drupal theme takes for granted — the site name for the page title, the slogan, the logo path, which page is the front page, where 403 and 404 go. JSON:API serves entities, and these are *configuration*, so there is no core resource for them; the usual result is a front end that hard-codes values that then drift from Drupal. This module adds a single read-only endpoint at `/jsonapi/site/site` that returns a JSON:API-shaped document with those values under `data.attributes` (name, mail, slogan, `page_front`/`page_403`/`page_404`, default langcode, default and admin themes, global logo and favicon paths), plus the site UUID as `data.id`. It is `GET`-only and speaks `application/vnd.api+json` for both request and response. Access requires an authenticated caller: the route sets `_user_is_logged_in: 'TRUE'` and restricts authentication to the **Key Auth** module (a hard dependency) via its `_auth` list, so a client authenticates with a Key Auth API key belonging to a user who has the `use key authentication` permission — session cookies do not apply to this route and anonymous requests get a 403. There is no admin form; the one extension point is `hook_jsonapi_site_data_alter(&$data)` (documented in `jsonapi_site.api.php`), which lets a custom module add its own values to, or adjust, the payload. Pairing it with JSON:API Extras gives a front end a fuller view of the backend API.

---

- Read site name and slogan from a decoupled front end.
- Avoid hard-coding site settings in a front end.
- Expose the front page path over API.
- Read the default theme's logo path.
- Keep a front end in step with Drupal settings.
- Serve 403 and 404 paths to a client app.
- Add custom values through the alter hook.
- Authenticate API reads with a Key Auth API key.
- Build a headless site's chrome from Drupal.
- Read the default language code.
- Provide settings to a mobile app.
- Avoid a second source of truth for site metadata.
- Feed a static site generator.
- Read theme settings over JSON:API.
- Support a Next.js or Nuxt front end.
- Update front-end branding from Drupal.
- Provide the site UUID to an integration.
- Extend the payload for a bespoke client.
- Read the admin and default theme machine names.
- Fetch the global favicon path for a client.

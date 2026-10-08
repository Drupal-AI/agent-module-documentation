# Configuration

Cookiehub is inert until you connect it to your CookieHub account. All settings live
on one form.

## Open the settings form

1. Log in as a user with the **`administer cookiehub configuration`** permission
   (grant it under Administration → People → Permissions to a compliance admin
   role — it is a restricted permission).
2. Go to **Configuration → Web services → Cookiehub**, or navigate directly to
   `/admin/config/services/cookiehub`.

## Fields

- **CookieHub code** (`id`) — your 8‑digit CookieHub code, from
  `https://dash.cookiehub.com/domain`. Enter it as a plain code (keep it to the
  expected 8‑digit format).
- **Enable** (`enable`) — the master switch. When off, no script is attached; when
  on, the banner is loaded site‑wide (subject to the path exclusions below).
- **Development mode** (`dev_mode`) — when on, loads the dev build from
  `dash.cookiehub.com/dev/<id>.js` instead of the production build at
  `cookiehub.net/c2/<id>.js`. Use it for testing, and turn it off in production.
- **Automatic cookie blocking** (`automatic_cookie_blocking`) — when on, the script
  is attached via a `src` tag and `window.cookiehub.load()` runs on
  `DOMContentLoaded`, so scripts wait for consent. When off, the module injects the
  classic inline async loader snippet instead. Turn this on if you want the banner
  to actually hold trackers back rather than only display a notice.
- **Disable on paths** (`disable_on_paths`) — newline‑separated path patterns (with
  `*` wildcard). On a matching path the script is not attached — use it to keep the
  banner off API/utility paths or specific landing pages.

Save the form. When **Enable** is on, the loader and init scripts are added to the
page `<head>` (early, at weights ‑1000/‑999) on every non‑excluded path.

## Cookie declaration field

The module also provides a **CookieDeclaration** field type with a widget and
formatter. Add it to a content type and place it (via that content type's *Manage
display*) to render a cookie‑declaration block — handy for a dedicated cookie‑policy
page. Note this CookieHub feature requires a premium subscription.

## Notes

- The CookieHub script loads from `cookiehub.net` (or `dash.cookiehub.com` in dev
  mode) on every non‑excluded page. If you run a Content‑Security‑Policy, allow that
  origin as a script source.
- Consent categories and records are managed in the CookieHub service, not in
  Drupal. Disclose your use of CookieHub in your privacy policy.

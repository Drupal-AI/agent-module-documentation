# Configuration

Facebook Pixel is configured from a single form at **Configuration → Web services →
Facebook Pixel** (`/admin/config/facebook_pixel`), which requires the **Configure
facebook_pixel** permission. The form is organised into a pixel id plus three tabs —
**Pages**, **Roles** and **Privacy**.

## Facebook pixel id

The **Facebook pixel id** is the only thing you must set. Paste the id from your Meta
Events Manager. If it is left **empty, nothing is tracked at all** — no JavaScript and
no `<noscript>` fallback are emitted — which is also the quickest way to switch
tracking off site‑wide.

## Pages tab — which URLs are tracked

- **Mode** — a radio choice:
  - *All pages except those listed* (the default) — track everywhere except the paths
    you list.
  - *The listed pages only* — track only the paths you list.
- **Pages** — one path per line. Each must start with `/` (or be `<front>`), and `*`
  wildcards are allowed; paths are matched against both the internal path and its
  alias. The shipped default list keeps tracking off admin pages, batch, node forms
  and user account subpages:

  ```
  /admin
  /admin/*
  /batch
  /node/add*
  /node/*/*
  /user/*/*
  /user/login
  ```

## Roles tab — which users are tracked

- **Mode** — a radio choice:
  - *All roles except the selected ones* — track everyone except the roles you tick.
  - *Only the selected roles* — track only the roles you tick.
- **Roles** — checkboxes of your site's roles. Leaving all unticked (with the default
  mode) means everyone is tracked. Use this to, for example, exclude logged‑in
  editors, or to track only a "customer" role.

## Privacy tab — four opt‑outs

These are **client‑side** switches passed to the browser — they influence the
JavaScript, not a server‑side gate:

- **Respect Do‑Not‑Track** (`donottrack`, on by default) — the JavaScript skips
  tracking when the browser sends a Do‑Not‑Track header.
- **Honour `fb-disable`** (`fb_disable_advanced`) — the JavaScript honours a global
  `window['fb-disable']` flag and exposes an `fbOptout()` function that sets an
  opt‑out cookie.
- **Wait for EU Cookie Compliance consent** (`eu_cookie_compliance`) — tracking is
  held until the visitor agrees via the EU Cookie Compliance module. This checkbox is
  only enabled when that module is installed, and its *Script scope* must be set to
  **Header**.
- **Disable the `<noscript>` image** (`disable_noscript_img`) — suppresses the
  `<noscript>` tracking‑pixel image so no request is made before consent.

> **Worth knowing:** the `<noscript>` fallback image is emitted independently of the
> page/role rules and the JavaScript privacy flags — it fires on every page whenever a
> pixel id is set, *unless* you tick *Disable the `<noscript>` image*. If you rely on
> consent gating, turn that image off.

Save with **Save configuration**, then clear caches if needed.

## Reading and writing the settings with Drush

```bash
drush cget facebook_pixel.settings
drush cset facebook_pixel.settings facebook_id 123456789012345 -y

# track only two landing pages, only for the authenticated role
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("visibility.request_path_mode", "listed_pages")
    ->set("visibility.request_path_pages", "/campaign\n/campaign/*")
    ->set("visibility.user_role_mode", "listed_roles")
    ->set("visibility.user_role_roles", ["authenticated" => "authenticated"])
    ->save();
'
drush cr
```

## Migrating from Drupal 7

If you are upgrading a Drupal 7 site, the module ships a migration
(`d7_facebook_pixel_settings`) that carries the old `facebook_pixel_id` variable over
into the new `facebook_id` setting. Nothing else is migrated.

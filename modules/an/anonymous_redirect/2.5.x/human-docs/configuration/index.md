# Configuration

All settings live on one form at **Configuration → System → Anonymous Redirect**
(`/admin/config/system/anonymous-redirect`). You need the **Administer site
configuration** permission (an administrator by default).

## The settings form

- **Enable Anonymous Redirect** — the master on/off switch. It is **off** by
  default; nothing redirects until you turn it on. (Stored as `enable_redirect`.)

- **Redirect Base URL** — where anonymous visitors are sent. It defaults to
  `/user/login`. You can enter:
  - an **internal path** such as `/welcome`,
  - `<front>` to send them to the site's front page, or
  - an **external URL** such as `https://example.com` (no trailing slash) —
    external targets are issued as a *trusted* redirect.

  (Stored as `redirect_url`.)

- **Redirect URL Overrides** — a list of paths, **one per line**, that anonymous
  users are allowed to reach without being redirected. `*` wildcards are
  supported, so `/public/*` exempts an entire section. Typical entries are the
  login page and any public pages (privacy policy, contact form). (Stored as
  `redirect_url_overrides`.)

Click **Save configuration** when done. Saving automatically clears the relevant
render cache so previously cached pages immediately reflect the new behavior.

## How the redirect behaves

Once enabled, on each request the module redirects a visitor only when **all** of
these are true: the redirect is enabled, the visitor is **anonymous**, and the
site is **not in maintenance mode**. Beyond that:

- **Asset paths are skipped**, so CSS/JS aggregation and image derivatives keep
  generating normally.
- On multilingual sites, a leading **language prefix** (like `/es`) is stripped
  from the current path before it is checked against your override list.
- If the target is the **login page** and the visitor asked for a real page, the
  requested path is appended as `?destination=…` so they return to it after
  logging in.
- **Maintenance mode disables the redirect**, so administrators can always
  recover the site.

## Per-environment overrides (optional)

Because these are ordinary config values, you can toggle or retarget the redirect
per environment straight from `settings.php` — useful for locking down only a
staging site while leaving production open:

```php
$config['anonymous_redirect.settings']['enable_redirect'] = TRUE;
$config['anonymous_redirect.settings']['redirect_url'] = 'https://staging-lock.example.com';
```

You can also set values with Drush (note the overrides are a newline-separated
string):

```bash
drush config:set anonymous_redirect.settings enable_redirect true -y
drush config:set anonymous_redirect.settings redirect_url '/user/login' -y
drush config:set anonymous_redirect.settings redirect_url_overrides "/user/login
/privacy
/public/*" -y
```

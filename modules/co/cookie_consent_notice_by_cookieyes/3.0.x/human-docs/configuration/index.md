# Configuration

Configuring this module means two things: pasting your CookieYes `<script>`
snippet, and turning it on. Both are stored in the
`cookie_consent_notice_by_cookieyes.settings` config object as `scripts` (the
snippet) and `enable` (a boolean).

## What you need first

A **CookieYes account**. Log in to CookieYes, set up your banner there, and copy
the `<script>` snippet it provides — it looks something like:

```html
<script id="cookieyes" type="text/javascript"
  src="https://cdn-cookieyes.com/client_data/XXXX/script.js"></script>
```

The module reads the `src` (and optional `id`, defaulting to `cookieyes`) out of
whatever you paste, and loads that one script tag in the page `<head>` on non‑admin
pages.

## Option A — the settings form

1. Log in as a user with the **`cookieyes_scripts_settings`** permission.
2. Go to **Configuration → Development → Cookie Consent Notice by CookieYes**
   (`/admin/config/development/cookie_consent_notice_by_cookieyes`).
3. Paste your snippet into the **scripts** textarea and tick **Enable**.
4. Save.

> **Important (3.0.x defect).** In this release the settings route references a
> form class that does not exist, so the page will error until the module is
> patched. If you hit that error, use the Drush method below instead.

## Option B — set it with Drush (works around the form defect)

Because the values are plain config, you can set them directly with Drush — this is
the recommended path for the 3.0.x release:

```bash
# Turn injection on:
ddev drush config:set cookie_consent_notice_by_cookieyes.settings enable 1 -y

# Paste your CookieYes snippet (replace XXXX with your account's value):
ddev drush config:set cookie_consent_notice_by_cookieyes.settings scripts \
  '<script id="cookieyes" type="text/javascript" src="https://cdn-cookieyes.com/client_data/XXXX/script.js"></script>' -y
```

(Drop the `ddev` prefix if you're running inside the container.)

## The two settings

| Setting | Meaning |
|---------|---------|
| **scripts** | The full CookieYes `<script>` snippet from your account. The module extracts its `src` URL and `id`. |
| **enable** | Whether to actually inject the script on front‑end pages. Untick (or set to `0`) to temporarily disable the banner — e.g. during maintenance — without deleting your snippet. |

## How it behaves

- The script is only added on **non‑admin** routes, so it never loads on Drupal's
  admin pages.
- Nothing is injected unless **enable** is on *and* the snippet is non‑empty, so an
  empty/disabled configuration is harmless.
- Everything the visitor sees — the banner, cookie scanning and blocking, consent
  logging — is handled by CookieYes' hosted script, not by this module. To swap in a
  different CookieYes site, just replace the snippet.
- Because the settings live in config, you can export them and promote them between
  environments like any other configuration.

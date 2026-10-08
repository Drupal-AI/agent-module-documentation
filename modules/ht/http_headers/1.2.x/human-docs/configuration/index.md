# Configuration

HTTP Headers is configured from a settings form where you add and manage the HTTP
response headers your site sends. This is a security-sensitive area — read the
cautions below before enforcing anything.

## Open the settings form

1. Log in as a user who has the module's configuration permission (grant it only to
   trusted administrators).
2. Open the settings form from the module's **Configure** link on the **Extend**
   page (`/admin/modules`), or from the site's administration configuration menu.

## What you can configure

The form lets you set the site-wide HTTP response headers, including the common
security and policy headers:

- **Content-Security-Policy (CSP)** — restricts where scripts, styles, images, and
  other resources may load from. The single most powerful header here, and the
  easiest to get wrong: an over-broad policy gives little protection, while a
  too-strict one can break legitimate functionality (inline scripts, third-party
  embeds, analytics).
- **Strict-Transport-Security (HSTS)** — tells browsers to only ever reach the site
  over HTTPS, for a duration you set (`max-age`). Effective, but **sticky**: once a
  browser has seen it, it remembers for the whole `max-age`, so start with a short
  duration while testing.
- **X-Frame-Options** — controls whether your pages may be embedded in frames,
  mitigating clickjacking.
- **Referrer-Policy** — controls how much referrer information the browser sends
  when users follow links away from your site.
- **Permissions-Policy** — controls which browser features (camera, geolocation,
  etc.) your pages may use.

Because the exact fields and layout can vary between releases, rely on the
descriptions shown on the form itself for what each option expects, then save.

## Test before you enforce

- **Start permissive, then tighten.** For CSP especially, verify the site still
  works with your policy before relying on it — a broken CSP can silently disable
  scripts and styles.
- **Use a short HSTS `max-age` while testing.** Browsers honor HSTS for the full
  duration you set, so a long `max-age` applied by mistake is hard to walk back.
- **Confirm what is actually sent.** Use the module's "current request headers"
  report or your browser's developer tools (Network tab → Response Headers) to check
  the live headers after saving.

## A note on scope

This module **adds and manages** response headers. If your goal is instead to
*remove* information-disclosure headers (like `X-Generator`), that is the job of a
companion module such as HTTP-Headers cleaner — the two complement each other.

## Save

Click **Save** to apply your header configuration. Changes take effect for
subsequent responses; clear caches if a change does not appear immediately.

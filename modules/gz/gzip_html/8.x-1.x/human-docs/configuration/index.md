# Configuration

Gzip Html output has no settings form of its own. It hangs its single option off
core's **Performance** page, so that's where you switch compression on.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Performance**, or navigate directly to
   `/admin/config/development/performance`.

## Turn on HTML compression

On the Performance page, look for the Gzip Html output option and enable it, then
**Save configuration**. From that point on, Drupal will gzip-compress the HTML it
sends to browsers.

That is the whole configuration — there are no other fields to set.

## Before you rely on it

- **BigPipe must be off.** This module is incompatible with core's BigPipe
  module. If BigPipe is enabled, disable one of the two.
- **Don't double-compress.** If your web server or CDN already compresses HTML,
  you don't need this module and shouldn't enable it as well.
- **Sensitive dynamic pages.** For the rare case of a page that reflects
  user-supplied input alongside a secret (a CSRF token, session data), be aware
  of the BREACH compression side-channel before compressing it. Ordinary public
  HTML is not affected.

## Verify

Request a page and confirm the response carries `Content-Encoding: gzip` (via
your browser's Network tab or `curl -I -H 'Accept-Encoding: gzip'
https://your-site/`).

# Configuration

There is one short settings form, and the important part is choosing your paths
carefully — because every path you list here loses its clickjacking protection.

## Open the settings form

Go to **Configuration → System → Allow site to be iframed**
(`/admin/config/system/allow_iframed_site`). You need the **Administer site
configuration** permission.

## The form, field by field

The form embeds Drupal's standard **Request path** condition:

- **Pages** — a list of paths, one per line, on which the `X-Frame-Options` header
  should be removed (making those pages embeddable). You can use:
  - exact paths, e.g. `/node/42`;
  - wildcards, e.g. `/embed/*` to match everything under `/embed/`;
  - `<front>` to refer to the site's front page.

- **Negate the condition** — a checkbox that inverts the match:
  - **Unchecked** *(the normal case)* — the header is stripped **only** on the
    listed pages; everything else stays protected.
  - **Checked** — the header is stripped **everywhere except** the listed pages. Use
    this only if you deliberately want most of the site to be embeddable, which is
    unusual and riskier.

Click **Save configuration**. Saving flushes all caches so the change takes effect
immediately.

## How it behaves

- If **Pages is empty and Negate is off**, the module does nothing — the header
  stays in place on every page. You must list at least one page (or turn on negate)
  for the module to remove anything.
- Otherwise, for each incoming request the module checks the path against your
  condition and removes `X-Frame-Options` when it matches, allowing that page to be
  framed.

## Security notes — read before you save

- **This intentionally weakens a protection.** Removing `X-Frame-Options` is exactly
  what the module does, and it re-exposes the matched pages to **clickjacking**.
  Keep the **Pages** list as tight as possible — ideally a single dedicated embed
  path or path pattern.
- **Never open up authenticated or admin paths** (like `/admin/*` or `/user/*`) for
  framing. Limit it to public, low-risk pages built for embedding.
- **This module only manages the legacy `X-Frame-Options` header.** It does **not**
  add or manage a Content-Security-Policy `frame-ancestors` directive. If another
  part of your stack — a CSP module, a reverse proxy, a CDN — sets `frame-ancestors`,
  that will still control framing regardless of this module. If your pages still
  refuse to frame after configuring this module, check for a CSP `frame-ancestors`
  rule elsewhere and adjust it separately.

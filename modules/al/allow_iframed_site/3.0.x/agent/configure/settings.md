<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Allow site to be iframed

## What it does

By default Drupal sends `X-Frame-Options: SAMEORIGIN`, which stops other origins from framing your
pages. This module's response subscriber (`RemoveXFrameOptionsSubscriber`, priority -10 on
`KernelEvents::RESPONSE`) **removes** that header on paths you select, so those pages can be embedded
in an `<iframe>` on another site.

## Settings form

Route `allow_iframed_site.settings` at `/admin/config/system/allow_iframed_site` (permission
*administer site configuration*). It embeds core's **Request path** condition (`request_path`
plugin):

- **Pages** — one path per line (e.g. `/embed/*`, `/node/42`); `<front>` allowed; wildcards `*`.
- **Negate** — invert the match (checkbox). Off = strip the header only on the listed pages; On =
  strip it everywhere **except** the listed pages.

Saving the form calls `drupal_flush_all_caches()` so the change takes effect immediately.

## Config shape: `allow_iframed_site.settings`

Stored under the `request_path` key (same structure as any request_path condition):

```yaml
request_path:
  id: request_path
  pages: "/embed/*\n/node/42"
  negate: false
  # (context_mapping/negate keys as produced by the condition)
```

Read/write:

```bash
drush cget allow_iframed_site.settings request_path
```

```php
// Allow framing of /embed/* only.
$cfg = \Drupal::configFactory()->getEditable('allow_iframed_site.settings');
$rp = $cfg->get('request_path') ?? [];
$rp['id'] = 'request_path';
$rp['pages'] = '/embed/*';
$rp['negate'] = FALSE;
$cfg->set('request_path', $rp)->save();
drupal_flush_all_caches();
```

## How matching works at response time

For each response the subscriber loads the `request_path` condition from config, evaluates it, and
removes `X-Frame-Options` when the path matches the intended selection. Guard behaviour:

- If **`pages` is empty and `negate` is 0**, the subscriber leaves the header in place (no-op) —
  you must configure at least one page (or enable negate) for it to strip anything.
- Otherwise it strips the header on responses whose path matches (respecting negate).

## Security caveat (by design — not a module bug)

Removing `X-Frame-Options` is exactly the point of the module, but it re-exposes those pages to
**clickjacking**; the module's own description says "Watch out for clickjacking!". Scope `pages`
as tightly as possible and avoid framing authenticated/admin paths.

## Limitation

This module manages only the legacy **`X-Frame-Options`** header. It does **not** add or manage a
Content-Security-Policy **`frame-ancestors`** directive. If something else on your stack sets
`frame-ancestors` (a CSP module, a reverse proxy), that will still govern framing regardless of this
module — handle CSP separately.

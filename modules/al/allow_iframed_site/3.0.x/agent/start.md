<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allow site to be iframed — agent index

Removes the **`X-Frame-Options`** response header on chosen paths so those pages can be embedded in
an `<iframe>`. Uses core's **Request path** condition to pick paths. No dependencies beyond core, no
permissions of its own (form gated by `administer site configuration`), no Drush, no plugins.

- **Configure which paths can be framed, config shape, the header behaviour, caveats** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Settings config: **`allow_iframed_site.settings`**; key **`request_path`** with `pages` (newline
  path list) and `negate` (0/1). Form at `/admin/config/system/allow_iframed_site` (permission
  `administer site configuration`).
- Mechanism: `RemoveXFrameOptionsSubscriber` on `KernelEvents::RESPONSE` (priority -10) evaluates the
  request_path condition and `->headers->remove('X-Frame-Options')` on matching responses.
- If `pages` is empty and `negate` is 0, the header is **kept** (module does nothing).
- Saving the form runs `drupal_flush_all_caches()`.
- Ships **no config/install and no config schema** — the config is created when you first save the form.
- Only touches `X-Frame-Options`; it does **not** manage CSP `frame-ancestors`.

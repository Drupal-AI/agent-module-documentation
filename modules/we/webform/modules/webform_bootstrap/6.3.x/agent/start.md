<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Bootstrap 3.x (webform_bootstrap) — **DEPRECATED**

Submodule of **webform**. Bootstrap 3 form theming, **Drupal Bootstrap theme only** — explicitly
not for other Bootstrap Framework themes (Radix and similar).
Version **6.3.0**. Core `^10.3 || ^11.0`. `lifecycle: deprecated`,
`package: 'Webform [DEPRECATED]'`, `lifecycle_link` → the Webform FAQ on deprecated external
libraries.

**Two things to know.**

1. **`drupal/webform_bootstrap` is a metapackage.** It resolves to nothing of its own and installs
   **webform**; the module lands at `web/modules/contrib/webform/modules/webform_bootstrap`. There
   is no top-level directory — tooling that looks for one reports a failed install that did not
   fail.
2. **Do not adopt it.** Bootstrap 3 is out of support. New sites: style Webform's markup in the
   theme. Existing Drupal Bootstrap sites: remove it as part of moving off Bootstrap 3.

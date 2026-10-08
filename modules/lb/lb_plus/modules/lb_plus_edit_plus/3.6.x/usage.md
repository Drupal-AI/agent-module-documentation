<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder + Edit + is **deprecated**. Its functionality has been moved into `lb_plus`, and the module remains only so that database updates can uninstall it cleanly.

---

The info file says so explicitly: `lifecycle: deprecated`, with `lifecycle_link` pointing at the `lb_plus` project and a description that reads "DEPRECATED: This module is no longer needed. Functionality has been moved to lb_plus. Run database updates to uninstall."

There is nothing to configure and nothing to adopt. The only correct action is the one the description gives: run database updates, which uninstall it, and then remove it. If it is still enabled on a site, that is a signal the site is mid-upgrade rather than a working configuration to preserve.

Do not install it on a new site, do not carry it forward in a composer file, and do not recommend it for the in-place editing behaviour it used to provide — that now lives in `lb_plus` itself.

---

- Recognise a deprecated module on an inherited site.
- Run database updates to uninstall it.
- Remove it from composer after uninstalling.
- Confirm its functionality now lives in lb_plus.
- Avoid installing it on a new site.
- Audit a site still carrying it.
- Plan an lb_plus upgrade that clears it.
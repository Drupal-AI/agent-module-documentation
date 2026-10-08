<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Webform (lb_webform) — agent index

Webform **block type** for YMCA Layout Builder pages. Version **2.0.0**.
Core `^9 || ^10 || ^11`. Depends on `y_lb`.

**Two checks on any placed webform:** the form's **own access settings still apply** (a restricted
form on a public page renders as an empty region, not an error), and a public form **will be found
by bots** — confirm the site's CAPTCHA/honeypot applies.

A location-page form usually collects **personal data**, so retention and submission-access are part
of placing it.

**Documented from source — cannot be enabled** (the `y_lb` Packagist stub; see `modules/y_/y_lb`).
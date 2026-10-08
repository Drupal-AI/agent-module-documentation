<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block: Webform (vlsuite_block_webform) — agent index

Nested submodule of **vlsuite_block**. Places a **webform** as a component.
Version **2.3.3**. Core `^10.3 || ^11`.

Configuration stays where it belongs: fields, validation, handlers and confirmation are Webform's;
placement, section and styling are the layout's.

**Two checks:** the webform's own **access settings** still apply (a form restricted to
authenticated users on a public page simply will not render for anonymous visitors), and a public
landing-page form **will be found by bots** — confirm the site's CAPTCHA/honeypot applies.
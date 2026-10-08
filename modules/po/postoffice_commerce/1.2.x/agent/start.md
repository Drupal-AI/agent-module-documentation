<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Postoffice Commerce (postoffice_commerce) — agent index

**Mail plugin `postoffice_commerce_mail` that sends Drupal Commerce emails (incl. order receipts) via Postoffice / Symfony Mailer as themed messages.**

- **Version:** 1.2.x (release 1.2.0) · Core: ^10.2 || ^11
- **Dependencies:** postoffice, postoffice_compat, postoffice_compat_theme, commerce
- **Mail plugin:** `#[Mail(id: 'postoffice_commerce_mail')]` `CommerceMail extends CompatMailBase`; `emailFromMessage()` → `OrderReceiptEmail` for `commerce_order_receipt`, else `CommerceEmail`
- **Email classes:** `CommerceEmail`, `OrderReceiptEmail` (Symfony `Email`; localized/site/themed/attachment traits)
- **Theme hooks:** `postoffice_commerce_email`, `postoffice_commerce_order_receipt_email` (+ per-key/order-type/langcode suggestions)
- **Setup:** `drush config:set system.mail interface.commerce postoffice_commerce_mail` (and `interface.commerce_license` for Commerce License)

See [configure/mail-plugin.md](configure/mail-plugin.md)

**Security:** Developer-oriented; no routes, permissions, forms, or user input. Only transforms outbound Commerce mail server-side; the rendered HTML body is the body already produced by Commerce/core mail. No anonymous or mutating endpoints. No security findings.

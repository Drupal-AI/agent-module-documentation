<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Postoffice Commerce provides a `postoffice_commerce_mail` mail plugin that routes Drupal Commerce emails (including order receipts) through Postoffice / Symfony Mailer as themed messages.

---

Postoffice sends themed emails using Symfony Mailer; this bridge module makes Commerce use it. It defines a mail backend plugin `postoffice_commerce_mail` (`CommerceMail`, extending `postoffice_compat`'s `CompatMailBase`). In `emailFromMessage()` it maps Drupal's mail `$message` array to a Symfony `Email`: `commerce_order_receipt` messages become an `OrderReceiptEmail` (carrying the Commerce order and deriving the recipient's preferred langcode), and everything else becomes a generic `CommerceEmail`. Both classes implement Postoffice's localized/site/themed/attachment interfaces and expose a `buildThemedEmail()` that wraps the Commerce-rendered HTML body in a `postoffice_commerce_email` / `postoffice_commerce_order_receipt_email` theme hook. `hook_theme()` and theme-suggestion hooks add per-key, per-order-type, and per-langcode template suggestions for customisation.

Setup is Drush-configuration: point Commerce's mail interface at the plugin with `drush config:set system.mail interface.commerce postoffice_commerce_mail` (and, because it uses core's mail manager, `interface.commerce_license` separately for the Commerce License submodule). The module is developer-oriented and has no routes, permissions, forms, or user input of its own — it only transforms outbound Commerce mail server-side. The HTML body it renders is the body already produced by Commerce/core mail (wrapped with `Markup::create`), so there is no new untrusted-input surface; there are no anonymous or mutating endpoints and no security findings.

---

- Send Drupal Commerce emails through Symfony Mailer via Postoffice
- Deliver themed order-receipt emails for Commerce orders
- Route `commerce_order_receipt` mails to a dedicated receipt email class
- Route other Commerce mails through the generic Commerce email class
- Set the plugin with `drush config:set system.mail interface.commerce postoffice_commerce_mail`
- Cover commerce_shipping and similar extensions via the commerce mail handler
- Configure `interface.commerce_license` explicitly for Commerce License mails
- Theme Commerce emails with `postoffice_commerce_email` templates
- Theme receipts with `postoffice_commerce_order_receipt_email` templates
- Override templates per email key (e.g. per Commerce mail id)
- Override receipt templates per order type (bundle)
- Localise email templates per langcode via theme suggestions
- Derive the receipt language from the customer's preferred langcode
- Attach files to Commerce emails via Postoffice's attachment support
- Apply site-wide Postoffice email theming/branding to Commerce mail
- Keep Commerce transactional emails consistent with other Postoffice mail
- Customise create-order confirmation and receipt wording via templates
- Provide a developer-controlled mail pipeline instead of the default handler
- Combine with Postoffice compat theme for consistent rendering
- Switch away from the default Commerce mail handler cleanly via config

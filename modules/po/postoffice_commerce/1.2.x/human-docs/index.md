# Postoffice Commerce — manual setup guide

**Postoffice Commerce** (`postoffice_commerce`) is a small bridge that makes **Drupal Commerce**
send its emails — including order receipts — through the **Postoffice** module and **Symfony
Mailer**, as themed messages. It provides a mail backend plugin (`postoffice_commerce_mail`):
order‑receipt messages are turned into a dedicated receipt email (carrying the Commerce order
and using the customer's preferred language), and all other Commerce mails become a generic
Commerce email. Both are rendered through theme hooks you can override per email key, per order
type, and per language.

This is a developer‑oriented module with **no admin forms, routes, or permissions of its own** —
it only transforms outbound Commerce mail on the server. You wire it up with a single Drush
configuration command.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it
   alongside Postoffice and Commerce.

There is no configuration page — setup is a Drush command, described under "How to use it"
below.

## How to use it

1. Make sure Postoffice itself is configured — its transport DSN and mail theme, set on the
   **Postoffice** module's own settings form at `/admin/config/system/postoffice`.
2. Point Commerce's mail interface at this plugin:

   ```bash
   drush config:set system.mail interface.commerce postoffice_commerce_mail
   ```

   Most Commerce extensions (such as Commerce Shipping) send through the Commerce core mail
   handler and are covered by that one line.
3. **Commerce License** is an exception — it uses core's mail manager directly, so configure it
   explicitly too if you use it:

   ```bash
   drush config:set system.mail interface.commerce_license postoffice_commerce_mail
   ```

### Theming your Commerce emails

Override the rendered output in your theme using these theme hooks:

- `postoffice_commerce_email` — generic Commerce emails.
- `postoffice_commerce_order_receipt_email` — order receipts.

Template suggestions let you target specific cases (most specific last), for example per email
key, per order type (bundle), and per language — such as
`postoffice_commerce_order_receipt_email__{order_type}__{langcode}`. These work well together
with the **Postoffice Compat Theme** submodule for consistent rendering.

# Mailchimp Transactional — manual setup guide

**Mailchimp Transactional** (`mailchimp_transactional`) sends your site's outgoing
email through the [Mailchimp Transactional](https://mailchimp.com/developer/transactional/)
service — the platform formerly known as Mandrill — instead of PHP's built‑in mail
or a plain SMTP server. Transactional email services like this improve deliverability
and give you delivery tracking, so password resets, order confirmations, and webform
notifications are more likely to land in the inbox and you can see what happened to
them.

It works through Drupal's [Mail System](https://www.drupal.org/project/mailsystem)
module. This module registers two mail plugins — a real one that talks to the
Mailchimp Transactional API, and a test one that doesn't hit the live service — and
you choose them in Mail System as the sender for your whole site or for specific
modules (route only webform or commerce email through it, for example). When Drupal
sends a message, this module builds it into a Mailchimp Transactional message with
your configured sender, open/click tracking, attachments, analytics tags, and an
optional subaccount, then either sends it immediately or queues it to go out on cron
so page requests stay fast.

Configuration lives on a single settings form: API key, sender name and address,
tracking options, timeouts, a denylist of mail keys whose content shouldn't be
stored (password resets, for instance), and the async queue toggle. A second tab
sends a test email so you can confirm the wiring. The module requires the
`mailchimp/transactional` PHP library and the Mail System module, and defines an
**Administer Mailchimp Transactional** permission. Three optional submodules add
per‑user activity views, an account‑wide reporting dashboard, and template mapping.
If you're migrating from the old Mandrill module, your settings are carried over
automatically on install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the PHP
   library), enable the module, and pick submodules.
2. [Configuration](configuration/index.md) — the settings form, wiring it up as the
   mailer in Mail System, storing the API key safely, and sending a test email.

## Where it lives in the admin menu

- **Settings:** **Configuration → Web services → Mailchimp Transactional**
  (`/admin/config/services/mailchimp_transactional`).
- **Send a test email:** the **Send Test Email** tab on that page (only reachable
  once an API key is set and Mail System points at this mailer).
- **Mail System (to select the mailer):** **Configuration → System → Mail System**
  (`/admin/config/system/mailsystem`).

All of these require the **Administer Mailchimp Transactional** permission.

## How to use it

1. Install the module and its PHP library, then enable it (see
   [Installation](installation/index.md)).
2. Enter your API key and sender details on the settings form.
3. In Mail System, set the default sender (or a specific module's sender) to
   **Mailchimp Transactional**.
4. Use the **Send Test Email** tab to confirm everything works.

See [Configuration](configuration/index.md) for the details.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Mass Email (webform_mass_email) — agent index

Adds a **Mass Email** tab to a webform's Results that emails **one message to every address** the form's
submissions collected. Recipients are read from a chosen email element, de-duplicated, queued (one item per
unique address) into Drupal's `webform_mass_email` queue, and delivered by a **cron queue worker** —
individual sends, never a shared `To`/`CC`. Version **2.0.0**. Core `^8.8 || ^9 || ^10 || ^11`.
Requires **`webform:webform_ui`** (composer: `drupal/webform ^5.0 || ^6.0`).

## Mechanism (source of truth)
- **Send form** `src/Form/WebformResultsMassEmailForm.php`, route `entity.webform.results_mass_email`,
  path `/admin/structure/webform/manage/{webform}/results/mass-email`.
  - `buildForm()` lists every element of type `email`, `webform_email_confirm`, `webform_email_multiple`
    as the **Email field** select; warns and stops if the form has no email element or no submissions.
  - Body is a `textarea`, or a `text_format` editor when the **html** setting is on. With the optional
    `token` module it gets `token_element_validate` + a `webform_submission` token-tree link.
  - `submitForm()` queries `webform_submission_data` for `sid`/`value` where `webform_id` = this form and
    `name` = the chosen element, de-dupes addresses (`webform_email_multiple` values are split on commas),
    and calls `queueFactory->get('webform_mass_email')->createItem(...)` once per unique address. Shows
    *"N items queued for sending."* — the count is reported **after** queueing, not before.
- **Queue worker** `src/Plugin/QueueWorker/WebformMassEmailQueue.php` (`@QueueWorker id="webform_mass_email"`,
  default `cron time = 15`). `processItem()` skips items missing email/subject/body, replaces
  `[webform_submission:*]` tokens against **that item's own** submission (`clear => TRUE`), and sends via
  `plugin.manager.mail`→`webform_mass_email_mail()` with the single address as `$to`. Re-throws on failure
  so the item is retried.
- **hook_mail** (`webform_mass_email.module`, key `mass_email`): `from` = `system.site` mail;
  sets `Content-Type: text/html` header only when the html setting is on.
- **hook_queue_info_alter**: overrides the queue's per-cron `time` with the configured `cron` value.

## Config & access
- Settings form `webform.config.mass_email` at `/admin/structure/webform/config/mass-email`
  (perm **`administer webform_mass_email`**). Config `webform_mass_email.settings`: `cron` (int seconds,
  default 15), `html` (bool), `log` (bool). See [configure/settings.md](configure/settings.md).
- Send route requires **all** of: perm `send webform_mass_email`, entity access `webform.submission_view_any`,
  and `WebformEntityAccess::checkResultsAccess`. So a sender must already be able to view that form's results.

## Notes / gotchas
- **No test send, no recipient preview**, no unsubscribe — it emails the full de-duped list on submit.
- HTML mode only adds a header; you must install a module that actually renders HTML email.
- Deliverability: hundreds of messages via PHP `mail()` will bounce/spam — use a real MTA/relay.
- Consent is on you: form submission is not consent to further mail beyond the expected follow-up.

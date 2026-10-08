<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Campaign Monitor adds a Webform handler (`campaignmonitor`) that, when a form is submitted, subscribes the submitter to a Campaign Monitor list. It maps an email element and an optional merge-vars YAML block to the subscriber record and delegates the actual API call to the `campaignmonitor` module.

---

This module is deliberately thin: it is a single `WebformHandler` plugin and nothing else — no routes, no config schema, no library of its own. All of the Campaign Monitor connection (API key, client ID, the createsend-php library, list retrieval and the subscribe request) lives in the required **`campaignmonitor`** contrib module; this module only bridges a webform submission to `campaignmonitor.subscription_manager::userSubscribe()`. You configure it per form under **Settings → Emails / Handlers → Add handler → CampaignMonitor**, choosing the target **List** (from lists the campaignmonitor module has pulled via cron, or a token in the Other field), the **Email field**, an optional **Control field** (a checkbox that must be ticked for the subscription to run — this is the opt-in gate), a **Merge vars** YAML block (`mergevars`, token-aware, and the `name:` key is passed as the subscriber name), and a **Double opt-in** flag. On `postSave` for a *new* submission only (updates are skipped), it token-replaces the configuration, reads the email from the submission data, decodes the merge-vars YAML, and calls the subscription manager. Version **1.0.1** on core `^10.3 || ^11.0`. Because the handler is a Drupal form handler, the form itself keeps the site's styling, validation, spam protection and accessibility — the subscription runs after a valid submission. Two things to get right operationally: the **control checkbox** is what turns this into genuine opt-in consent (without it every submission subscribes), and the **API credential** is a live key over your subscriber list, held in the campaignmonitor module's config — treat it accordingly (environment variable / Key entity where supported). Note the merge-vars decode assumes a `name` key exists, so an empty or nameless mergevars block will raise a PHP warning; always include at least `name:` in the YAML.

---

- Subscribe webform submitters to a Campaign Monitor list.
- Add a newsletter signup to any Drupal-styled webform.
- Gate subscription behind an opt-in checkbox (control field).
- Map a webform email field to a Campaign Monitor subscriber.
- Pass custom subscriber fields via a merge-vars YAML block.
- Use tokens to set the subscriber name and merge values.
- Choose the target list dynamically with a token in the Other field.
- Enable single or double opt-in per form.
- Subscribe after an event-registration form.
- Add a supporter signup to a charity campaign page.
- Route a contact form's opt-in box to a mailing list.
- Attach multiple CampaignMonitor handlers to one form (cardinality unlimited).
- Replace an embedded Campaign Monitor form with a native webform.
- Capture consent and subscribe in one submission.
- Add spam protection (via Webform) to a newsletter signup.
- Subscribe only submissions where the marketing checkbox is ticked.
- Send segmented list signups from a landing page.
- Keep signup validation and accessibility inside Drupal.
- Collect subscriber preferences as merge vars.
- Bridge a webform to Campaign Monitor without writing a custom submit handler.

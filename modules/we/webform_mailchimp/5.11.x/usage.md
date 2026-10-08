<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform MailChimp adds a Webform handler that subscribes people to a Mailchimp audience (list) when they submit a webform, mapping the webform's email field and other fields to Mailchimp merge fields and interest groups.

---

The module ships a single `@WebformHandler` plugin with id `mailchimp` (label "MailChimp", `CARDINALITY_UNLIMITED`, `RESULTS_PROCESSED`) that you add to any webform under *Settings → Handlers → Add handler → MailChimp*. On the handler you choose the target Mailchimp `list` (audience), pick which webform element is the `email` address, toggle `double_optin`, map extra webform fields to Mailchimp merge fields via a YAML `mergevars` mapping, select `interest_groups` (grouped by category), and optionally set a `control` field that decides whether a given submission subscribes at all. On submit (`postSave()`), the handler builds the merge vars (fireable through `hook_webform_mailchimp_lists_mergevars_alter()` for last-minute changes) and calls Mailchimp through the [Mailchimp](https://www.drupal.org/project/mailchimp) module, which holds the API key and the audience/merge-field/interest metadata. It depends on both `webform` and `mailchimp`; there is no settings page of its own (`configure: null`), no permissions and no Drush — all configuration lives inside each webform's handler config (schema `webform.handler.mailchimp`). A working Mailchimp account, API key (configured in the Mailchimp module) and at least one audience are required for it to actually subscribe anyone.

---

- Subscribe newsletter-signup webform submitters to a Mailchimp audience automatically.
- Map a webform's email element to the Mailchimp subscriber email.
- Enable double opt-in so subscribers must confirm via Mailchimp's email.
- Map webform fields (first name, last name) to Mailchimp merge fields via YAML.
- Add submitters to specific Mailchimp interest groups (e.g. topics they chose).
- Use a checkbox "control" field so only opted-in submissions are subscribed.
- Attach several MailChimp handlers to one webform to write to multiple audiences.
- Combine a contact webform with a "subscribe me" option that pushes to Mailchimp.
- Alter merge vars in code before sending with hook_webform_mailchimp_lists_mergevars_alter().
- Feed event-registration webforms into a Mailchimp audience for follow-up.
- Sync a job-application webform's applicant emails to a talent-pool audience.
- Grow a marketing list from any public webform without custom API code.
- Segment subscribers by mapping a webform select list to Mailchimp interest categories.
- Keep webform submissions and Mailchimp subscriptions in sync on each submit.
- Reuse the Mailchimp module's stored API key across many webforms.
- Add subscribers to a specific audience per webform (different lists per form).
- Provide a GDPR-friendly opt-in by pairing a consent checkbox with the control field.
- Push lead-generation webform data straight into an email nurture audience.
- Map custom merge tags that match your Mailchimp signup form field tags.
- Enable/disable subscription behavior per webform by adding or removing the handler.

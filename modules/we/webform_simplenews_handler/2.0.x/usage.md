<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Simplenews Handler adds a "Submission Newsletter" Webform handler that subscribes (or unsubscribes) a submission's email value to one or more Simplenews newsletters when the form is submitted.

---

The whole module is one Webform handler plugin (`submission_newsletter`,
`SubmissionSimplenewsWebformHandler`) plus a summary theme hook. It has no config, permissions,
schema, routes, or Drush. You add the handler to any webform (Webform → Settings → Emails/Handlers →
Add handler → "Submission Newsletter", category "Newsletter"; cardinality is unlimited so you can add
several). Per handler you choose: which submission element supplies the subscriber email (`token` —
either "Default" or a specific form element), one or more target newsletters (`newsletters_lst`,
from `simplenews_newsletter_get_visible()`), the action (`subscribe`/`unsubscribe`), and which
submission states trigger it (`states`: draft/converted/completed/updated, default completed). On
`postSave`, for each selected newsletter it calls `\Drupal::service('simplenews.subscription_manager')
->subscribe()`/`->unsubscribe()` with the email, then loads the Simplenews subscriber and — unless
`skipConfirmation()` is true — sets the subscriber to UNCONFIRMED and sends a confirmation email
before saving. This lets you collect richer signup forms (name, region, preferences, etc.) rather
than Simplenews's bare email-only block, while keeping Simplenews's double-opt-in behaviour.

---

- Turn any webform into a newsletter signup that feeds Simplenews.
- Collect extra fields (name, company, region) alongside the newsletter subscription email.
- Subscribe the submitter's email to a single Simplenews newsletter on submission.
- Subscribe to multiple newsletters at once from one form submission.
- Add an unsubscribe handler so a form removes the email from a newsletter.
- Attach several "Submission Newsletter" handlers to one webform (unlimited cardinality) for different lists.
- Choose exactly which form element provides the subscriber email address.
- Only subscribe when a submission is fully completed (default), not on drafts.
- Also trigger on draft-saved, anonymous-to-authenticated conversion, or update states.
- Preserve Simplenews double opt-in: set new anonymous subscribers to UNCONFIRMED and email them a confirmation.
- Respect Simplenews `skipConfirmation()` to auto-confirm where configured.
- Build a multi-step or conditional webform that subscribes users based on their answers.
- Combine a contact form with an optional newsletter opt-in checkbox mapped to this handler.
- Add newsletter subscription to an event-registration webform.
- Manage subscriptions to visible newsletters without writing custom code.
- Reuse the handler across many forms with different newsletter targets.

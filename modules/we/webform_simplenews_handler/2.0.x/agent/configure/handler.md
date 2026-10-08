<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Submission Newsletter" handler

Class `src/Plugin/WebformHandler/SubmissionSimplenewsWebformHandler.php`, id `submission_newsletter`.
Add it per webform: **Webform → Settings → Emails / Handlers → Add handler → "Submission Newsletter"**
(category "Newsletter"). Unlimited cardinality — add multiple with different targets.

## Configuration (per handler instance)

| Setting | Form control | Meaning |
|---|---|---|
| `states` | checkboxes | Submission states that trigger it: `draft`, `converted` (anon→auth), `completed` (default), `updated`. If the webform has results disabled, forced to `completed`. |
| `token` | select | Which submission **element** supplies the subscriber email, or `Default`. Options are the form's input elements. |
| `newsletters_lst` | checkboxes | Target newsletters, from `simplenews_newsletter_get_visible()`. |
| `action` | select | `subscribe` or `unsubscribe`. |

Defaults (`defaultConfiguration`): `states=[completed]`, `token='default'`, `newsletters_lst=[]`,
`action=''`, `debug=FALSE`. "Default" token/newsletters fall back to
`webform.settings:submission_newsletter.*` if set.

## Runtime behaviour (`postSave`)

For a submission whose state is in `states`:
1. `email = $submission->getElementData($token)`. If empty, or no newsletters selected, nothing happens.
2. For each selected newsletter id (skipping `'0'`):
   - `\Drupal::service('simplenews.subscription_manager')->{$action}($email, $newsletter_id, NULL)`.
   - `Subscriber::loadByMail($email)`; unless `$subscriber::skipConfirmation()`, set status
     `SubscriberInterface::UNCONFIRMED`.
   - `$subscriber->sendConfirmation()` then `$subscriber->save()` (Simplenews double opt-in).

## Notes

- No module config/permissions of its own — access is Webform's normal handler-admin access
  (`administer webform` / webform-specific update). Email comes from the form submitter, but it is
  only passed to Simplenews's subscription manager (which handles confirmation), not to any injection
  sink.
- Summary rendering uses the `webform_handler_submission_newsletter_summary` theme hook
  (`templates/webform-handler-submission-newsletter-summary.html.twig`).

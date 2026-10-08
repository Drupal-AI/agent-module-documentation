<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailjet Webform Subscription provides a custom Webform element — a "mail list" checkbox — that, when ticked,
appends the submitter to a chosen Mailjet contact list. It supports a double-opt-in flow: on submission a
confirmation link containing a random token is emailed (optionally via a Mailjet template), and the
subscription is only appended to the list when the recipient clicks through and the token is validated.
Depends on [Webform](https://www.drupal.org/project/webform) and
[Mailjet API](https://www.drupal.org/project/mailjet_api).

---

The element is a `WebformMailListCheckbox` (Element + WebformElement plugin) configured with which
webform fields hold the email/first-name/last-name, the target Mailjet `#list_id`, and optional
success-template/success-node settings. On submission the plugin generates a token as
`hash('sha256', random_bytes(55))` and stores it on the submission. The confirmation route,
`GET /newsletter-subscription` (`ConfirmSubscriptionController::content`, `_access: 'TRUE'`, no-cache,
page-cache kill-switch), reads `token` and `caller` query params, **sanitises** them
(`preg_replace` to alphanumerics/underscore), then looks up the matching `webform_submission_data` row via
a **parameterised** query (conditions on `value` = token and `name` = caller — no SQL injection). If a
match is found and the token has not been consumed, it marks `token_consumed`, calls
`MailjetApiWrapper::appendToList()` (Mailjet SDK, `addnoforce`), optionally sends a success template
email, and optionally renders a configured success node — which is guarded by
`isPublished()` + `access('view')` (no access bypass) or throws `NotFoundHttpException`. The
`MailjetApiWrapper` instantiates `new \Mailjet\Client($public, $secret, TRUE, ['version'=>'v3'])`; keys
come from `mailjet_api.settings` and TLS is handled by the Mailjet SDK (HTTPS, not disabled). No custom
permissions.

---

- Add a newsletter opt-in checkbox to any webform.
- Subscribe submitters to a specific Mailjet contact list.
- Require double opt-in via an emailed confirmation link.
- Generate a strong random confirmation token per submission.
- Send the confirmation/welcome email through a Mailjet template.
- Map webform fields to Mailjet email/first-name/last-name properties.
- Prevent token reuse by marking submissions as consumed.
- Show a configurable thank-you response after confirmation.
- Redirect confirmed users to a chosen success node (access-checked).
- Collect first/last name alongside the email for personalisation.
- Support multiple lists via multiple checkbox elements on one form.
- Keep the confirmation endpoint uncacheable so tokens validate correctly.
- Sanitise token/caller query parameters before lookup.
- Use a parameterised DB query to resolve tokens (no SQL injection).
- Only append to Mailjet after the recipient confirms (reduces spam/bad addresses).
- Localise the response template and success messaging.
- Integrate email marketing signups into existing webforms without custom code.

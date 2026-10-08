# The email_confirmation handler

## Adding it

On a webform's **Emails / Handlers** page → *Add handler* → **Email confirmation** (route
`entity.webform.handler.add_email_confirmation`, requires `webform.update` access). It behaves like the
core Email handler plus the confirmation-specific settings below. Set the **To** address to a
user-entered email element (e.g. `[webform_submission:values:email]`) so the link reaches the submitter.

## Behavior

- `EmailConfirmationWebformHandler` (id `email_confirmation`) extends
  `Drupal\webform\Plugin\WebformHandler\EmailWebformHandler`, `tokens = TRUE`, cardinality unlimited.
- `defaultConfiguration()` forces `states` to `STATE_DRAFT_CREATED` + `STATE_DRAFT_UPDATED` (the states
  field is hidden in the form), and defaults subject/body to the "other" option; default body is
  `[webform_submission:confirmation_link]` for both text and html.
- `preSave()` sets `in_draft = TRUE` for new submissions, so the confirmation email (a draft-state
  email) is what gets sent.
- `confirmForm()` clears the draft flag in the form object only to stop Webform treating the persisted
  record as a deletable draft — the DB record stays pending until the link is visited.

## Handler settings (schema `webform.handler.email_confirmation`)

| Key | Type | Meaning |
|---|---|---|
| `confirmation_url_timeout` | int (seconds) | Link lifetime; empty/0 = never expires |
| `redirect_path` | string (required) | Where to redirect after confirming; validated with `UrlHelper::isValid()` |
| `confirmation_message` | string (required) | Message shown after a successful confirmation |

Plus every setting inherited from the core email handler (to/from/subject/body/reply-to/conditions),
because `hook_config_schema_info_alter()` appends the `webform.handler.email` mapping onto this
handler's schema.

## Token & confirmation route

- `hook_token_info` / `hook_tokens` add `[webform_submission:confirmation_link]`, an absolute URL to
  route `webform_email_confirmation_link.confirmation`:
  `/webform_email_confirmation/{uuid}/{timestamp}/{hash}` (permission `access content`).
- `webform_email_confirmation_link_rehash($submission, $timestamp)` =
  `Crypt::hmacBase64("{timestamp}:{submission-uuid}", Settings::getHashSalt())`.

## What the controller does (`WebformEmailConfirmationController::confirmation`)

1. Load submission by UUID; bail (redirect home) if not found or the enabled handler is missing.
2. Resolve `redirect_path` (token-replaced; falls back through `Url::fromUserInput`).
3. `validatePathParameters()`: submission must still be a draft; `timestamp` between the submission's
   created time and now; within `confirmation_url_timeout` if set; `hash_equals` against the re-derived
   HMAC.
4. On success: set completed + changed time, `in_draft = FALSE`, save, show `confirmation_message`,
   redirect to `redirect_path`. On failure: an error message and redirect.

Because step 3 requires `isDraft()`, a link stops working once its submission is confirmed — effectively
single-use. The link only completes a submission; it does not expose submission data.

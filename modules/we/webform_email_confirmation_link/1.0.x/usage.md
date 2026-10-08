Adds an "Email confirmation" Webform handler that holds each new submission as a draft and emails the submitter a one-time confirmation link; visiting the link (double opt-in) marks the submission as completed.

---

The module registers a single Webform handler plugin, `email_confirmation`, which extends core Webform's `EmailWebformHandler`, so it inherits the full email configuration UI (to/from/subject/body, conditions, etc.). Its differences: it forces the handler to fire on the draft-created / draft-updated states, sets any new submission to `in_draft = TRUE` in `preSave()`, and its default email body is just the `[webform_submission:confirmation_link]` token. That token (provided via `hook_tokens`) builds an absolute URL to route `webform_email_confirmation_link.confirmation` at `/webform_email_confirmation/{uuid}/{timestamp}/{hash}`, where `hash` is `Crypt::hmacBase64("{timestamp}:{uuid}", Settings::getHashSalt())` — an HMAC keyed by the site hash salt, so the link cannot be forged or guessed without server secrets. The controller loads the submission by UUID, re-derives and constant-time-compares the hash (`hash_equals`), checks the submission is still a draft and the timestamp is in-range and within the optional `confirmation_url_timeout`, then flips `in_draft` to FALSE, sets completed/changed times, saves, shows the configured confirmation message, and redirects to the configured `redirect_path`. Because confirmation only works while the submission is a draft, the link is effectively single-use. Handler settings add `confirmation_url_timeout` (seconds, empty = never), `redirect_path`, and `confirmation_message`; there is no global config page.

---

- Require newsletter or mailing-list signups to confirm their email (double opt-in) before the submission counts.
- Verify that a user-entered email address is real and belongs to the submitter before acting on a form.
- Hold event registrations as drafts until the registrant clicks the emailed confirmation link.
- Add a GDPR-friendly consent confirmation step to any Webform.
- Reduce fake/spam submissions by only completing submissions that pass email confirmation.
- Send a branded confirmation email reusing core Webform's email handler UI (from/subject/HTML body).
- Insert the confirmation link anywhere in the email body with the `[webform_submission:confirmation_link]` token.
- Expire confirmation links after a set number of seconds via `confirmation_url_timeout`.
- Keep confirmation links valid indefinitely by leaving the timeout empty.
- Redirect confirmed users to a thank-you page via the handler's `redirect_path` setting.
- Show a custom on-screen message after a link is confirmed (`confirmation_message`).
- Combine with core Webform conditions so confirmation emails only send for certain submissions.
- Add multiple email-confirmation handlers to one form (cardinality unlimited) for different recipients.
- Direct the confirmation email to a user-supplied email element rather than a fixed admin address.
- Build a member-signup flow where accounts/actions are provisioned only after email confirmation.
- Prevent premature processing by other handlers by keeping submissions in draft until confirmed.
- Give submitters a self-service way to activate their own submission without admin intervention.
- Track unconfirmed vs confirmed submissions via the draft flag in the Webform results.
- Localize the confirmation email and message per site language using Webform's translation support.
- Use HMAC-signed, hash-salt-keyed links so confirmation URLs are tamper-proof and unguessable.
- Provide a friendly "link used/expired/invalid" error and redirect when a stale link is visited.

Email confirmer is a developer-facing suite providing a central service and content entity for confirming that an email address belongs to whoever supplied it: it sends a unique HMAC-signed link, records the outcome, and remembers already-confirmed addresses so they need not be re-confirmed.

---

The base module does nothing user-visible on its own; it exposes the `email_confirmer` service (`EmailConfirmerManager`) and the `email_confirmer_confirmation` content entity. Your code calls `\Drupal::service('email_confirmer')->confirm($email, $data, $realm)` to start a confirmation: it creates/loads a confirmation entity, emails the address a link, and returns the entity. Each confirmation stores the email, initiating uid, IP, timestamp, an arbitrary key→value property map, a `realm` (the scope/module that created it), status flags (pending/sent/confirmed/cancelled), per-outcome redirect URLs, and a `private` flag (only the initiating user may respond). The confirmation link points to `/email-confirmer/reply/{uuid}/{hash}` where `{hash}` is a 43-char base64 HMAC (`Crypt::hmacBase64(email.created.ip, private_key)`); the response form (or an auto-skip mode) verifies the hash before flipping the status and invoking `hook_email_confirmer($op, $confirmation)`. A UUID param converter resolves the confirmation from its UUID. Route access is governed by an entity access handler: the `access email confirmation` permission (disabled by default), an optional same-IP restriction, and the private-flag owner check — but the hash is the real gate. A resend route (`/email-confirmer/resend/{id}`) requires that permission plus a CSRF token. Settings (`/admin/config/system/email-confirmer`, `administer site configuration`) control hash expiration, confirmation lifetime (old records are auto-deleted by cron), resend delay, same-IP restriction, the request email subject/body (tokenized), and whether to skip the response form. Optional cron integration ships an `ultimate_cron` job. The included `email_confirmer_user` submodule applies all this to user email changes.

---

- Confirm an email address a user typed into a custom form before acting on it (double opt-in).
- Provide a reusable confirmation service so multiple modules share one confirmed-email database.
- Send a signed confirmation link and record whether the recipient confirmed or cancelled.
- Avoid re-confirming an address already confirmed for the same user/realm.
- Scope confirmations per feature using the `realm` argument (e.g. `newsletter`, `email_confirmer_user`).
- Store arbitrary metadata against a confirmation via its property map.
- Mark a confirmation `private` so only the initiating user can respond to it.
- Restrict responses to the same IP that requested the confirmation (optional hardening).
- Auto-expire and delete stale confirmation records after a configurable lifetime.
- Let users resend the confirmation email (rate-limited by a configurable delay, CSRF-protected).
- Auto-confirm without showing the response form (`skip_confirmation_form`) for a one-click flow.
- React to confirmation/cancellation events by implementing `hook_email_confirmer()`.
- Customize the confirmation request email subject and body with tokens (`[email-confirmer:confirmation-url]`).
- Send redirect users to specific pages after confirm/cancel/error.
- Queue confirmation request emails when a resend is attempted too soon.
- Grant the `access email confirmation` permission to the roles allowed to use the service.
- Confirm addresses for anonymous submitters (guarded by the unguessable HMAC hash in the link).
- Build subscription / mailing-list opt-in on top of the confirmation entity.
- Query confirmations by email/status/realm via the manager's `getConfirmations()` / `getConfirmation()`.
- Integrate with `ultimate_cron` for scheduled cleanup of confirmation entities.

# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Email Confirmer**, or navigate directly to
   `/admin/config/system/email-confirmer`.

All of these settings are stored in the `email_confirmer.settings` configuration
object.

## Timing settings

- **Response time limit** (`hash_expiration`, default **24 hours**) — how long a
  confirmation link stays valid after it is sent. After this window the link's
  signature no longer matches and the address must be confirmed afresh. The form
  presents this as an hours/minutes selection.
- **Confirmation lifetime** (`confirmation_lifetime`, default **7 days**) — how
  long a confirmation record is kept before cron automatically deletes it. Set it
  to `0` to keep records forever.
- **Resend delay** (`resendrequest_delay`, default **15 minutes**) — the minimum
  time that must pass before the confirmation email can be resent. If someone asks
  to resend sooner, the email is queued instead of sent immediately, which also
  rate-limits abuse.

## Security settings

- **Restrict to same IP** (`restrict_same_ip`, default **off**) — when on, only the
  IP address that requested the confirmation may respond to it. This is optional
  hardening; leave it off if your users might switch networks between requesting and
  confirming.

Note that the real security of a confirmation link is the **HMAC signature** built
into the URL — a 43-character hash the module verifies before it will flip a
confirmation's status. That means the link works even for anonymous submitters, and
holding a permission is never enough on its own to confirm an address without the
signed link.

## The request email

- **Subject** (`confirmation_request.subject`) — the subject line of the email that
  carries the confirmation link.
- **Body** (`confirmation_request.body`) — the message body. It supports tokens;
  the important one is **`[email-confirmer:confirmation-url]`**, which is replaced
  by the actual signed link. Make sure your body includes that token, or recipients
  will have no way to confirm.

## The response experience

- **Skip confirmation form** (`confirmation_response.skip_confirmation_form`,
  default **off**) — when on, clicking the link confirms the address immediately in
  one click, with no intermediate form. When off, the recipient lands on a response
  form first.
- **Response questions** — the text shown on the response form for each status
  (pending, expired, cancelled, confirmed).
- **Redirect URLs** (`confirmation_response.url.confirm` / `cancel` / `error`,
  default the site front page) — where to send the user after they confirm, cancel,
  or hit an error. These are fallbacks; code that starts a confirmation can set its
  own per-confirmation redirect that takes precedence.

Click **Save configuration** when you are done.

## Cron cleanup

Old confirmation records (older than the **Confirmation lifetime** above) are
deleted automatically on cron, so the table does not grow without bound. If you use
[Ultimate Cron](https://www.drupal.org/project/ultimate_cron), the module ships an
optional job for this cleanup.

## Permissions

Email confirmer defines two permissions at **People → Permissions**:

| Permission | Gates |
|------------|-------|
| **Administer email confirmations** (`administer email confirmations`) | Full control — update or delete any confirmation record without restriction. A restricted, trusted-admin permission. |
| **Access email confirmation** (`access email confirmation`) | Use the confirmation service — respond to (confirm/cancel) and resend confirmations. **Disabled by default**; grant it to the roles that should be able to use the flow. |

The access logic layers these together: an administrator can do everything; the
same-IP restriction (if on) and the private-owner check are applied next; and
otherwise a user needs **Access email confirmation**. But as noted above, the
signed hash in the link is the ultimate gate.

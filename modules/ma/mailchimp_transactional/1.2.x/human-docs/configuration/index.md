# Configuration

Setting up Mailchimp Transactional is two jobs: fill in the module's settings form,
and tell Mail System to use this module as the mailer. Both are required — the
settings alone don't route any mail until Mail System points at the plugin.

## Open the settings form

1. Log in as a user with the **Administer Mailchimp Transactional** permission.
2. Go to **Configuration → Web services → Mailchimp Transactional**
   (`/admin/config/services/mailchimp_transactional`).

## The settings form, field by field

- **API key** — your Mailchimp Transactional API key. This is required: without it,
  real sends fail and the test‑email tab stays locked. See
  [Storing the API key safely](#storing-the-api-key-safely) below.
- **From email** and **From name** — the sender address and name on outgoing mail.
  These default to your site's email and name on install. The address must be one
  Mailchimp Transactional recognizes (verified in your account).
- **Subaccount** — optionally send through a named subaccount, which lets you keep a
  separate sending reputation for a segment of mail. Leave it empty for none.
- **Text format** — if set, the email body is run through this text format's filters
  before sending.
- **Track opens** and **Track clicks** — on by default; record when recipients open
  a message or click its links.
- **Strip query strings from tracked URLs** — removes `?...` query strings from
  links when click tracking rewrites them.
- **Analytics campaign** and **Analytics domains** — tag outgoing mail with a Google
  Analytics campaign name and a comma‑separated list of domains.
- **Log queued messages** — write a log entry when a message is queued (only
  relevant with async sending on).
- **Queue worker timeout** — how many seconds cron may spend sending queued mail per
  run (default 15).
- **Log defaulted sends** — log when a mail key used this mailer only because it's
  the site default sender, which helps you find mail you didn't explicitly route
  here.
- **API timeout** — seconds to wait on an API request before giving up (default 60).
- **Mail key denylist** — a comma‑separated list of mail keys whose message content
  should *not* be stored or made viewable (the default includes
  `user_password_reset`). Keep sensitive messages like password resets on this list.
- **Process asynchronously** — off by default. When on, outgoing mail is placed in a
  queue and sent on cron instead of during the page request, so users aren't kept
  waiting while the API is contacted. Recommended for busy sites, provided cron runs
  frequently.

Click **Save configuration** when done.

## Storing the API key safely

Treat the API key as a secret. Rather than typing it directly into configuration
(where it can end up in exported config), follow this project's convention: keep the
value in an environment variable and reference it — for example via a
[Key](https://www.drupal.org/project/key) entity or `getenv()` in `settings.php`.
However you supply it, the effective value has to reach the module's `api_key`
setting for the mailer and the test‑email access checks to work.

## Wire it up as the mailer (Mail System)

The settings form only configures the plugin — it doesn't make Drupal use it. Go to
**Configuration → System → Mail System** (`/admin/config/system/mailsystem`) and set
the sender (and, if you like, the formatter) to **Mailchimp Transactional**:

- Set the **site‑wide default** sender to route *all* mail through the service, or
- Set a **specific module or mail key** to route only that mail (for example, only
  Webform).

To use the safe, non‑sending test plugin in a staging environment, choose the
**Mailchimp Transactional (test)** mailer instead — it goes through the same code
path but never contacts the live API.

## Send a test email

Once an API key is set *and* Mail System's default sender points at this mailer, the
**Send Test Email** tab on the settings page becomes available. Use it to send a
message and confirm the integration end to end. (The tab stays hidden until both of
those conditions are met — that's expected.)

## Developer hooks

For custom behavior, the module invites three hooks (see its `.api.php` file):
`hook_mailchimp_transactional_mail_alter()` to modify the outgoing message before it
sends, `hook_mailchimp_transactional_valid_attachment_types_alter()` to allow extra
attachment MIME types, and `hook_mailchimp_transactional_mailsend_result()` to react
to a send's outcome (for example, to handle rejected or bounced recipients).

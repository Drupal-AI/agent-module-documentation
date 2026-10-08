# Configuration

Elastic Email needs two things before it will deliver mail: your account
credentials entered on its settings form, and Mailsystem pointed at its mail
plugin. This page walks through both.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Elastic Email settings**, or navigate directly
   to `/admin/config/system/elastic_email/settings`.

## Enter your credentials

- **API username** — your Elastic Email account username, which is normally the
  email address you signed up with.
- **API Key** — the account API key from your Elastic Email dashboard. This is a
  secret: anyone with it can send mail on your account.

> **Keep the API key out of committed configuration.** The key is stored in the
> `elastic_email.settings` config object in clear text, so any exported
> configuration that includes it should be treated as sensitive. If you use DDEV,
> store the key in an environment variable rather than hard-coding it — for
> example `ddev dotenv set .ddev/.env --elastic-email-api-key=<value>` (keep
> `.ddev/.env` out of version control), then `ddev restart`, and reference the
> value from settings so it never lands in your repo. Rotate the key by updating
> this form if it is ever exposed. Note that the module also needs outbound
> network access (HTTPS/port 443) to reach the Elastic Email API — make sure your
> host's egress rules allow it.

## Optional delivery settings

- **Queue outgoing messages** — when ticked, messages are pushed onto a queue and
  delivered on cron by a queue worker instead of being sent immediately. This keeps
  page requests fast and smooths out bursts of mail, but means mail only goes out
  when cron runs, so keep cron running on a reliable schedule.
- **Log message delivery success** — records successful deliveries in Drupal's log,
  useful for auditing that mail actually went out.
- **Low Credit Threshold (USD)** — a dollar figure below which the module warns
  administrators that the account's credit is running low, so you're not caught out
  by a paused account.

## Channel and reply-to overrides

- **Use a Default Channel / Default Channel** — Elastic Email "channels" let you
  segment and report on sending. Enable this and name a default channel to tag all
  outgoing mail, which makes per-channel reporting in Elastic Email meaningful.
- **Use a Specific Reply To / Reply To Email / Reply To Name** — override the
  reply-to address (and display name) on outgoing mail, so replies land where you
  want them regardless of the from-address.

Click **Save configuration** when you're done.

## Wire up Mailsystem

The module only sends mail once **Mailsystem** points at its plugin — saving the
settings form alone is not enough.

1. Go to **Configuration → System → Mailsystem**
   (`/admin/config/system/mailsystem`).
2. Set the site-wide **Formatter** and **Sender** to **Elastic Email**
   (the `elastic_email_mailsystem` plugin). To route only one module's mail through
   Elastic Email, add a per-module override instead of changing the site-wide
   default.
3. Save.

## Send a test email

Once the credentials validate, a test form becomes available at
`/admin/config/system/elastic_email/test`. Send a probe message from there, then
check the dashboard at `/admin/config/system/elastic_email` for your account and
credit status. If queueing is enabled, run cron (`drush cron`) to flush the queue
so the test message actually goes out.

> **Tip:** Set up a Sender Policy Framework (SPF) record for your domain that
> authorises Elastic Email to send on your behalf — otherwise your mail is more
> likely to be filtered as spam.

# Configuration

Getting Amazon SES sending mail involves four things: connecting your AWS
credentials, setting a verified From address, verifying at least one sending
identity, and telling Drupal to use the SES mailer. All the Amazon SES admin
pages require the **Administer amazon ses** permission (marked
security‑sensitive — grant it only to trusted administrators, because the
identity and test‑email actions make live, billable AWS calls).

## Step 1 — Connect your AWS credentials (the AWS module)

Amazon SES does **not** store AWS keys itself. First configure the **AWS**
module with your AWS credentials and region, as an "AWS profile". Amazon SES
then reads its SES client from that profile.

> **Keep credentials as secrets.** The recommended pattern is to supply the AWS
> access key and secret through environment variables (and, where supported, a
> Key entity) rather than hard‑coding them in exported configuration. On DDEV,
> for example, you can store a value with `ddev dotenv set` and reference it from
> the AWS profile / `settings.php`. Never commit AWS secrets to version control.

## Step 2 — Main settings

Go to **Configuration → System → Amazon SES**
(`/admin/config/system/amazon_ses/settings`). The form has these fields:

- **From address** *(required)* — the verified address mail is sent from. Until
  this is set, the Status report shows an error.
- **From name** — the display name for the From header (defaults to the site
  name).
- **Override from** — when on, forces your configured From name/address on
  **every** message, overriding whatever the sending module set. Off by default.
- **Throttle** — when on, paces sending with a short pause between messages to
  stay under your SES per‑second rate limit. Useful during bulk runs. Off by
  default.
- **Multiplier** — the throttle multiplier; set it to the number of parallel PHP
  workers you run so the combined rate stays within the limit. Default 1.
- **Queue** — when on, outgoing mail is queued and sent in batches when **cron**
  runs (via the `amazon_ses_mail_queue` worker) instead of immediately. This
  smooths out spikes. Off by default.

Save the form.

## Step 3 — Verify a sending identity

SES only sends from verified addresses or domains. Use the sub‑pages under the
settings form:

- **Verified Identities** (`…/settings/identities`) — lists your identities with
  their verification and DKIM status.
- **Verify identity** (`…/settings/verify-identity`) — add a new email or domain
  identity. Verifying a domain lets SES DKIM‑sign all mail from it. You will
  need to complete the verification on AWS's side (confirm the email, or add the
  DNS records for a domain).

## Step 4 — Select SES as your mailer

Nothing is routed through SES until you choose the mailer:

- **Simplest (all mail):** set the `amazon_ses_mail` plugin as the default in
  `settings.php`:

  ```php
  $config['system.mail']['interface']['default'] = 'amazon_ses_mail';
  ```

- **Recommended (per module):** install
  [Mail System](https://www.drupal.org/project/mailsystem) and choose the
  *Amazon SES mailer* globally or for specific modules (for example route only
  `user` or `commerce` mail through SES).

## Step 5 — Send a test and check statistics

- **Test** (`…/settings/test`) — send a test email to confirm SES connectivity
  and that your identity is verified.
- **Statistics** (`…/settings/statistics`) — shows your account's 24‑hour send
  quota, how much you have sent, and your maximum send rate.

## Advanced

The module dispatches a `MailSentEvent` (`amazon_ses.mail_sent`) after each
successful send, so developers can subscribe to log deliveries, store SES message
IDs, or trigger follow‑up actions. See the [`agent/`](../agent/start.md) docs for
that and the rest of the sending internals.

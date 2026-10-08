# Configuration

Discord needs one piece of configuration — the webhook URL — before it can send
anything. The rest is optional cosmetic defaults.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Discord**, or navigate directly to
   `/admin/config/services/discord/config`.

## The settings

- **Webhook URL** — paste the incoming webhook URL you copied from Discord
  (**Server Settings → Integrations → Webhooks**). This is the single required
  field; if it is empty, the module refuses to send and shows an error rather than
  making a request. Keep this value secret — anyone holding it can post to your
  channel.
- **Default bot username** — the name that messages appear to be posted by. Leave
  it blank to use whatever name the webhook itself was given in Discord. Individual
  code calls can override this per message.
- **Default avatar URL** — a URL to an image used as the sender's avatar. Again,
  optional, and overridable per message from code.

Click **Save configuration** when done.

## Keeping the webhook out of exported config

Because the webhook URL is a secret, avoid committing it to version control via
`config:export`. The recommended pattern is to store it in an environment variable
and reference it through a **Key** entity, so the exported configuration holds only
a reference, not the secret itself.

> **DDEV:** save the value as an env var without committing it —
> `ddev dotenv set .ddev/.env --discord-webhook-url=<value>` then `ddev restart`.
> Keep `.ddev/.env` out of version control.

## Send a test message

Two built‑in forms let you confirm the wiring end to end:

- **`/admin/config/services/discord/test_message`** — sends a plain‑text message.
- **`/admin/config/services/discord/test_embed`** — sends a rich embed card (title,
  description, colour, author, link).

Submit either form and watch for the message to arrive in your Discord channel.

## What gets sent

A quick note on how the module treats message content, so nothing surprises you:

- Plain‑text messages have `<a href>` links converted to Discord's
  `<url | text>` syntax; all other HTML tags are stripped before sending.
- Embed descriptions are stripped of HTML and truncated to 1000 characters.
- The embed colour accepts a `#hex` value and is converted to the decimal integer
  Discord expects.
- If Discord returns an error (for example 404 or 500), the failure is caught and
  logged to the `discord` log channel rather than breaking the page.

Remember that every message is **egress to a third party** — whatever text you
pass leaves your site and lands in Discord, so do not send anything you would not
want in that channel.

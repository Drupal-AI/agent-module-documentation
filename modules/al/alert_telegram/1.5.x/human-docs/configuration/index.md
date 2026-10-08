# Configuration

To use Alert Telegram you configure two things — the **bot token** and the
**target chat** — and grant the module's permission to the right roles.

## Grant the permission

Alert Telegram provides its own permission. On **People → Permissions**
(`/admin/people/permissions`), grant it only to trusted administrative roles —
whoever holds it can change where your site's alerts are sent and which bot
posts them.

## Set the bot token — handle it as a secret

The bot token is what lets your site post as the bot. **Anyone who obtains it can
post as your bot**, so treat it exactly like a password:

- Send it only over **HTTPS**.
- Do **not** hard-code it in code or commit it to version control.
- Store the value in an **environment variable** and, where possible, reference
  it through a **Key** entity (Drupal's Key module) rather than typing the raw
  token into a plain settings field.

On this DDEV-based project the recommended flow is:

```bash
# Save the token into DDEV's dotenv file (never committed) and restart:
ddev dotenv set .ddev/.env --telegram-bot-token=<your-token>
ddev restart

# Confirm it is present in the container WITHOUT printing it:
ddev exec 'test -n "$TELEGRAM_BOT_TOKEN"'   # exit status 0 = set
```

Then create a Key from the environment variable (install the Key module first
if needed) so Drupal reads the token from the environment instead of storing it
in configuration.

## Set the target chat

Enter the Telegram **chat or channel ID** that alerts should be delivered to.
Keep the messages you send free of sensitive data — a Telegram chat is not a
place for private information, and the content leaves your site.

## Verify it works

Trigger (or wait for) an alert and confirm the message arrives in the configured
Telegram chat. If nothing arrives, re-check the token, the chat ID, and that the
bot has been added to the target chat/channel.

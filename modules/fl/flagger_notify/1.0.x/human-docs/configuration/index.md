# Configuration

All of Flagger Notify's setup happens on one page. This chapter walks through it.

## Open the settings form

1. Log in as a user with the **Administer flagger notify** permission.
2. Go to **Configuration → System → Flagger Notify**, or navigate directly to
   `/admin/config/system/flagger-notify`.

## General settings

At the top of the page are the module‑wide options:

- **Debug logging** — turn this on to check that emails are being queued
  correctly. It's handy while you're setting the module up; you can switch it off
  once everything is working.
- **Deduplication** — the intelligent "one email per update per user" behaviour is
  enabled by default, so a user who flagged the same content with several flags
  still gets a single email when it changes. You can disable it here if you
  specifically want a separate email per flag.

## Templates

Set the default email that goes out when followed content is updated:

- **Subject** — the email subject line.
- **Body** — the email body. Both fields accept HTML and **tokens**, so you can
  personalize the message with values like `[node:title]` and
  `[user:display-name]`. Use tokens to reference the updated content and the
  recipient.

## Flag configuration

Toward the bottom of the page is the list of the flags available on your site.
Notifications are **opt‑in per flag**: tick **Enable notifications** for each flag
you want to act as a "follow", and leave the rest unticked. Only content flagged
with an enabled flag will generate update emails.

## Save

Click to save the form. Remember that emails are sent on **cron**, not
immediately — so after an editor updates followed content, the notifications are
queued and go out on the next cron run. If you enabled debug logging, check the
logs to confirm messages are being queued as expected.

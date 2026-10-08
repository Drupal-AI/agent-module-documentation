# Configuration

Link Checker Summary Mail adds a handful of options that control the digest
email — when it goes out and to whom. The link *scanning* itself is configured in
Link Checker; this page covers only the summary-email side.

## Open the settings

1. Log in as a user with permission to administer Link Checker (an administrator
   by default).
2. Go to **Configuration → Content authoring → Link checker**. The summary-email
   options this module adds appear alongside Link Checker's own settings.

## The options that matter

The module's job is a scheduled digest, so its settings are about frequency and
audience. Think through each before saving:

- **Whether to send the summary** — turn the periodic email on or off. With it
  off, the module is installed but silent.
- **How often it is sent** — the sending schedule (for example daily or weekly).
  This is the single most important choice. Too frequent and the mail becomes
  noise people learn to ignore; too sparse and broken links sit unaddressed for
  weeks. Match the cadence to how quickly your team can realistically act on
  broken links.
- **Who receives it** — the recipient address(es) for the summary. Resist
  sending it only to a generic "webmaster" mailbox that nobody reads. The people
  who can actually fix a broken link are the ones who own the content it appears
  in, so route the digest to them where you can.

> **Cron:** the summary is sent when cron runs, so make sure your site's cron is
> running on a sensible schedule. If cron never runs, the email never goes out.

## A note on what makes the digest useful

A summary that lists *every* broken link *every* time — including the hundred
that have been broken for a year — buries the few that broke this week. The value
of a digest comes from distinguishing new findings from the standing backlog, so
readers can act on what's actually changed. Keep that in mind when you decide how
often to send and how much detail your team can absorb.

## Save

Click **Save configuration**. The next scheduled cron run will send the summary
according to your settings.

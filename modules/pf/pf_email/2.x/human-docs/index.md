# Push Framework Email — manual setup guide

**Push Framework Email** (`pf_email`) is the **email channel** for the
[Push Framework](https://www.drupal.org/project/push_framework). Push Framework
abstracts the job of sending notifications over pluggable channels; this add‑on is
the one that delivers those notifications as **email**. Enable it, and Push
Framework campaigns and notifications can be sent to users by email alongside any
other channels you run.

There is little to it beyond turning it on: it slots into the Push Framework as a
channel and sends framework notifications through your site's normal mail system.
It has no unusual security surface — the considerations are the ordinary ones for
sending email: make sure the **notification content** and **recipients** are
appropriate, and that your site actually has a working **mail transport**
configured so the messages go out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Push Framework.

This module has **no dedicated settings page** of its own; it is enabled and used
as a channel within the Push Framework, as described below.

## How to set it up

1. **Enable it** alongside the Push Framework (see
   [Installation](installation/index.md)).
2. **Enable the email channel** in the Push Framework's configuration (under
   **Configuration → System → Push framework**) so notifications are routed
   through email.
3. **Confirm your mail transport works.** Because this channel relies on Drupal's
   normal email sending, make sure your site can actually send mail (a configured
   mail transport / SMTP, and correct site email settings). Send a test
   notification and confirm it arrives.
4. **Check content and recipients.** Review that the notification content and the
   recipient list are what you intend before using it in production.

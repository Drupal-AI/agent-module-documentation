# Forum Notifications Subscription — manual setup guide

**Forum Notifications Subscription** (`forum_notifications_subscription`) adds
something core's Forum module never had: the ability for users to *subscribe* to
forum activity and get an email when something new is posted. Core Forum gives you
containers, forums, topics and replies, but no way for a member to say "let me know
when someone answers this thread" — this module fills that gap.

Once enabled, users can subscribe and unsubscribe to whole forums and to individual
forum topics. When a new topic or reply appears, the module emails the people who
asked to be notified. The email subject and body are customizable with token
replacement, and for busy sites the notifications are queued so a flood of activity
doesn't stall page requests. Each user can also choose how often they hear from the
site (their notification frequency), adjusting it right on their own profile edit
form, and a bundled view lets them review those frequency settings.

Two things are worth keeping in mind before you turn it on. Busy forums generate a
lot of email, so confirm the volume is manageable for your audience and mail
infrastructure. And because the module emails people about forum posts, make sure
subscriptions respect whatever access restrictions your forums already have — people
should only ever be notified about content they are allowed to see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Forum.
2. [Configuration](configuration/index.md) — the notification settings form (email
   subject/body and tokens, the daily digest) and the per‑user frequency options.

## Where it lives in the admin menu

The module does not register a one‑click *Configure* link, so it has no fixed spot
in the admin menu shortcut. Its notification settings are edited on the module's
own settings form under **Administration → Configuration** (see
[Configuration](configuration/index.md)), while each user manages their personal
notification frequency from their **profile edit** form.

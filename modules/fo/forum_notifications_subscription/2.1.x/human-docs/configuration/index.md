# Configuration

Forum Notifications Subscription has two configuration surfaces: an
administrator‑facing **settings form** that controls the notification emails
themselves, and a per‑user **frequency** setting each member manages on their own
profile.

## The notification settings form (administrators)

Open the module's settings form under **Administration → Configuration** and save
it once after installing — version 2.x adds new fields, so an explicit save is what
migrates configuration from a 1.x install.

The form lets you tailor the emails members receive:

- **Email subject** — the subject line used for notification messages. It supports
  **token replacement**, so you can weave in dynamic values (for example the topic
  title or the site name) rather than hard‑coding a single fixed subject.
- **Email body** — the message body, again with **token replacement** so each
  notification can name the relevant forum, topic, or author and link back to the
  content. Write this in plain, friendly language; it's what your community sees in
  their inbox.
- **Daily digest behaviour** — in version 2.x, activity destined for a user's daily
  digest is gathered together and sent as a **single summarized email** rather than
  many separate ones. This keeps busy forums from filling up inboxes.

Because notifications are **queued**, large subscription lists are processed in the
background (typically on cron) instead of blocking the request that triggered
them — no extra configuration is required for that, but it does mean cron needs to
run regularly for queued mail to go out.

## Per‑user notification frequency (each member)

Individual members control how often they hear from the site:

- On the **profile edit** form, each user can update the **notification frequency**
  of their subscriptions — for example immediate notifications versus a daily
  digest.
- The module also ships a **Frequency settings view** that lists a user's current
  notification frequencies. You can add this view to the **user profile display**
  so members have a clear, readable summary of what they're subscribed to and how
  often they'll be emailed.

## A note on access and volume

Notifications should never leak content a recipient can't see, so confirm your forum
access settings and the subscription behaviour line up before opening this to a wide
audience. And on active communities, consider steering members toward the daily
digest to keep email volume comfortable.

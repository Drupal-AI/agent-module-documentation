# Configuration

DANSE has three places you'll interact with: the **framework settings**, the
**prune form** for housekeeping, and the per‑user **subscriptions** page. What's
configurable depends on which source submodules you enabled (see
[Installation](../installation/index.md)).

## Framework settings

1. Go to **Configuration → System → DANSE** (`/admin/config/system/danse`).
2. Configure the framework and the enabled event sources. For **content** events,
   for instance, you decide — **per content type and bundle** — which events
   (create, update, delete, publish, unpublish) are recognized, and **which user
   roles are allowed to subscribe** to them (subscriptions are ideally
   role‑based). Other source submodules add their own options (for example, the
   log source lets you set a severity threshold).
3. Save.

The idea is to enable notifications only where they add value: turn on the events
that matter for each bundle, and grant subscription rights to the roles who should
be able to follow them.

## The prune form (retention)

Go to `/admin/config/system/danse/prune`. Because DANSE stores an **event entity
per occurrence** and notifications alongside them, these tables grow continuously.
The prune form is how you remove old records. Decide a retention policy up front —
this is both an operational concern (table size) and a **privacy** one, since the
audit data records who did what and when. Someone has to set the policy; the prune
form is the mechanism for enforcing it.

## Per‑user subscriptions

Each user manages what they follow at **`/user/{user}/subscriptions`**. Depending
on your configuration, users (or editors) also get per‑entity "follow" controls so
they can subscribe to a single node or other entity directly. Notifications then
appear in the user's notifications inbox (DANSE ships a notifications block and
Views‑based lists for this).

## Optional integrations

- **ECA** (via the `eca_danse` submodule) — drive ECA workflows from subscription
  events.
- **Push Framework** — deliver notifications through push channels.

Both are optional; install and enable them only if you need those delivery or
automation paths.

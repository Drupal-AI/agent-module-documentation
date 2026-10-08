# Configuration

Advanced Notifications is administered through a few screens — push/VAPID
settings, a subscriptions list, and campaign management — and each is protected by
its own permission. Set the permissions first, then the keys, then you can start
sending.

## Set the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and decide which
roles get each of the module's permissions:

- **`access list subscriptions`** — lets a role view the list of push
  subscriptions.
- **`administer web push subscriptions`** — lets a role manage (add/remove)
  subscriptions.
- **`administer web push settings`** — lets a role change the general push
  settings.
- **`administer web push sensitive settings`** — the most powerful permission: it
  controls the **VAPID push keys**. Treat this like a credential and grant it only
  to fully trusted administrators.
- **`administer web push campaigns`** — lets a role create and send campaigns.

## Enter the VAPID keys (sensitive settings)

Web push authorises your site to a browser using a pair of **VAPID keys** — a
public key and a private key. On the module's settings screen (reachable by a user
with `administer web push sensitive settings`), enter the key pair.

Because the private key is a secret, do not paste it into anything that gets
committed to version control. Prefer storing it in an environment variable and
referencing that from Drupal, so the raw key never lands in exported
configuration.

## Manage subscriptions

The subscriptions screen lists the browsers/devices that have opted in, each
represented by its push endpoint and keys. Use it to review who is subscribed and
to remove stale entries. Viewing requires `access list subscriptions`; changing
requires `administer web push subscriptions`.

## Create and send campaigns

Campaign management (permission `administer web push campaigns`) is where you
compose a push message and choose its audience, including **targeting by role**,
then broadcast it to matching subscribers. Grouping sends into campaigns lets you
organise repeat engagement/re-marketing pushes rather than firing one-off
messages.

## Save

Save each screen after editing. Subscriptions can only be collected from visitors
once the keys are in place and the subscribe prompt is active on an HTTPS site, so
confirm the VAPID keys are configured before expecting the subscription list to
populate.

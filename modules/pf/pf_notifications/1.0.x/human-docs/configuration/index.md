# Configuration

Getting web‑push working takes four steps: generate the server keys, grant the
subscription permission, make sure DANSE is set up for the content you care about,
and then have users subscribe. There is a built‑in test notification to confirm
the plumbing before you rely on it.

## 1. Generate the VAPID keys

1. Log in as a user with **Administer push notifications**.
2. Go to **Configuration → System → Push framework → Notifications**
   (`/admin/config/system/push_framework/pf_notifications`).
3. **Generate (or enter) the VAPID key pair** — a public key and a private key —
   and set a **subject**, which is a contact for the push service, given as a
   `mailto:` address or your site URL.
4. Save. The keys are stored server‑side and used both to register the service
   worker and to sign outgoing push messages.

> **Resetting keys is destructive.** The *reset keys* action
> (`/admin/pf_notifications/reset-keys`) clears the keys **and every existing
> subscription** — all current subscriptions become invalid and users must
> subscribe again. Use it deliberately.

## 2. Grant the subscription permission

For users to be able to subscribe, give their role(s) the REST permission
**"Access POST on Push notification subscription resource"** (the
`restful post pf_notifications_subscription` permission) at **People → Permissions**
(`/admin/people/permissions`). Administration of the module itself (the settings
form, resetting keys, removing subscriptions) is gated separately by **Administer
push notifications**.

## 3. Configure DANSE for your content

Web‑push here rides on DANSE subscriptions, so configure **DANSE content**
settings for the content and comment types you want notifications on. Users then
subscribe to those DANSE subscriptions and receive the pushes.

## 4. Send a test notification

Back on the settings form there is a **test notification** feature. Tick the
**Subscribe** checkbox there first, then click **Send** — you should receive a
browser/device notification, confirming the service worker, keys, and delivery all
work.

## 5. How users subscribe and receive notifications

- A user opens their **DANSE notification settings** and subscribes; their
  browser's push subscription (endpoint and keys) is saved against their own
  account. Subscriptions are always scoped to the **logged‑in user** — no one can
  subscribe on another user's behalf.
- Each user has a notifications tab at **`/user/{user}/danse/pf_notifications`**,
  visible only to that user (or to someone with *Administer notifications*).
- When a DANSE event fires, delivery happens through Push Framework's queue. In
  practice that means either cron processing the queue, or running the jobs
  manually:

  ```bash
  drush danse:notifications:create
  drush pf:sources:collect
  drush pf:queue:process
  ```

  Failed or expired push endpoints are pruned automatically from delivery reports.

## Operational note on the private key

The server **VAPID private key** is stored in a dedicated database table and is
**not encrypted** (this is standard for WebPush). Bear that in mind for database
access controls and backups. Beyond that the module uses parameterized queries and
flood control, and push delivery uses the WebPush library's default TLS.

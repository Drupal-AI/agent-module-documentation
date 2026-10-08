# iContact Integration — manual setup guide

**iContact Integration** (`icontact_integration`) connects a Drupal 10 or 11
site to the **iContact** email‑marketing platform through the iContact REST API
v2.2. Drop the module's *iContact Subscribe* field onto your user account form,
map your Drupal user fields to iContact contact fields, define per‑role
subscription rules, and contacts are created, deduplicated, and subscribed
automatically.

The syncing happens **asynchronously** — subscription API calls are queued and
processed on cron, so registering an account is never slowed down by an outbound
call to iContact. Before creating a contact, the module looks up the email
address in iContact and reuses any existing record, so you don't accumulate
duplicates. Failed queue items are retried on later cron runs, and you can drain
the queue on demand with `drush queue:run icontact_subscription_queue`.

Beyond the account‑form flow, the module exposes the full iContact CRUD surface
(contacts, lists, subscriptions, messages, campaigns, segments, sends,
statistics, bulk uploads) through an injectable service, a custom JSON REST API,
optional Drupal REST resources, and three developer hooks — useful for decoupled
front ends or Webform‑driven sign‑ups. Its only dependency is core's **User**
module.

Because it talks to a third‑party API, it needs iContact **API credentials**.
Treat those as secrets: store them in an environment variable, never in
version‑controlled configuration. The [Configuration](configuration/index.md)
page walks through the secure setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — store your API credentials
   securely, set up field mapping and per‑role subscription rules, and use the
   built‑in dashboard.

## Where it lives in the admin menu

The module provides an admin dashboard that shows your live iContact mailing
lists and the current queue status, a *User Subscription Configuration* form for
per‑role rules and field mapping, and its credential/connection settings — all
under **Configuration**. See [Configuration](configuration/index.md) for how to
find and fill each one.

## How to use it

1. Store your iContact API credentials securely and confirm the module can
   connect (see [Configuration](configuration/index.md)).
2. Add the **iContact Subscribe** field to the user account form via
   **Configuration → People → Account settings → Manage fields**, and set its
   label (for example "Subscribe to our newsletter").
3. In *User Subscription Configuration*, map Drupal user fields to iContact
   contact fields and set a rule per role — which mailing list to target, whether
   to subscribe on account creation or only when the opt‑in box is checked, and
   whether to unsubscribe on account deletion.
4. Leave the queue option on (the default) so registrations stay fast; cron
   processes the subscriptions in the background.

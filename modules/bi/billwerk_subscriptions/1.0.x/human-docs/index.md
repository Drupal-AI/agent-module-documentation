# Billwerk Subscriptions — manual setup guide

**Billwerk Subscriptions** (`billwerk_subscriptions`) connects Drupal user accounts
to the Billwerk (reepay) subscription-management platform. It keeps each user's
subscription state in sync with Billwerk and maps their active subscription plans
onto Drupal roles — so, for example, an active paid plan can automatically grant a
"member" role, and a lapsed one can remove it.

The module talks to the Billwerk REST API to read contract and subscription details,
and it grants or revokes Drupal roles based on that state. Users can refresh their
own subscription from their profile, privileged staff can manage any user's contract,
and an action can match Billwerk contracts to Drupal accounts. Billwerk also notifies
your site of changes through a **webhook listener**.

Because roles are driven by external subscription state — and because this touches a
payment platform — the API key and the webhook secret are sensitive credentials.
Store them securely and keep them out of logs and version control. The webhook route
is public by design but authenticates each call by matching a secret in the URL with
a strict comparison, and then re-fetches the authoritative subscription details from
Billwerk rather than trusting the incoming request body — a sound, vendor-recommended
pattern. See [Configuration](configuration/index.md) for the full setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Locale).
2. [Configuration](configuration/index.md) — enter the Billwerk API credentials,
   map plans to roles, register the webhook, and set the self-service permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Billwerk Subscriptions**
(`/admin/config/services/billwerk-subscriptions/settings`), gated by the
`administer billwerk_subscriptions configuration` permission. Its other permissions
are set under **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter the Billwerk API key and environment, map subscription plans to roles, and
   register the webhook URL (with its secret) in the Billwerk dashboard (see
   [Configuration](configuration/index.md)).
3. Grant the self-service permissions to the appropriate roles. From then on, roles
   are granted and revoked automatically as contracts become active or lapse, and
   users can refresh their own subscription at `/user/{user}/subscription/refresh`.

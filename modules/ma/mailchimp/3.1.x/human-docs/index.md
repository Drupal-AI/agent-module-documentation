# Mailchimp — manual setup guide

**Mailchimp** (`mailchimp`) connects your Drupal site to the Mailchimp email
marketing platform. The base module is the *connector*: it handles authentication,
caches your audience data, and exposes a webhook endpoint so Mailchimp can tell
the site about subscribes and unsubscribes. The features editors actually touch —
signup forms, campaigns, audience syncing — come from a family of submodules that
build on this foundation.

Under the hood, the base module wraps the `thinkshout/mailchimp-api-php` library,
authenticates with either an API key or OAuth, and can queue subscription
operations to run on cron so you stay within Mailchimp's API limits. On its own it
does little user‑facing work; its value is unlocked by the submodules:

- **Mailchimp Audiences** (`mailchimp_lists`) — adds a subscription field so any
  entity (usually users) can be tied to Mailchimp audiences and merge fields.
- **Mailchimp Campaign** (`mailchimp_campaign`) — author, send, test, and pull
  stats for campaigns from within Drupal.
- **Mailchimp Signup** (`mailchimp_signup`) — configurable signup blocks and
  pages.
- **Mailchimp Events** (`mailchimp_events`) — behavioral‑targeting events.
- **Mailchimp ECA** (`mailchimp_eca`) — exposes events and actions to the ECA
  automation module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the submodules you need.
2. [Configuration](configuration/index.md) — connect your Mailchimp account (API
   key or OAuth) and tune the settings form.

## Where it lives in the admin menu

The base connector's settings live at **Configuration → Web services → Mailchimp**
(`/admin/config/services/mailchimp`), with a separate OAuth setup form at
`/admin/config/services/mailchimp/oauth`. Mailchimp calls back into the site at
the webhook endpoint `/mailchimp/webhook/{hash}`.

## How to use it

The base module is just the plumbing. A typical setup:

1. **Connect the account** on the settings form — via OAuth (recommended, so no
   long‑lived key is stored) or an API key. See
   [Configuration](configuration/index.md).
2. **Enable the submodule(s)** for what you want to do — for example
   `mailchimp_signup` for a newsletter block, or `mailchimp_lists` to sync users
   into an audience.
3. **Build the feature** in that submodule's own UI (a signup form, a campaign, a
   subscription field, and so on).

Subscription and batch operations can be queued and processed on cron to respect
API limits — run them manually with `drush mailchimp:cron`. Developers can hook
into the flow with alter hooks for merge variables, interest groups, campaign
content, and webhook processing (see the [`agent/`](../agent/start.md) docs).

> **Keep secrets out of config.** Store your Mailchimp API key or OAuth
> credentials in an environment variable or a Key entity rather than committing
> them to exported configuration.

# Salesforce Push Queue UI — manual setup guide

**Salesforce Push Queue UI** (`salesforce_push_queue_ui`) gives the Salesforce
Suite's normally-invisible **push queue** a real admin screen. The Salesforce
Suite queues each entity that needs pushing to Salesforce in a plain database
table (`salesforce_push_queue`); when an item fails repeatedly it simply stops
being processed and disappears from view unless you query the database directly.
This module surfaces that queue as a **View**, so you can see every pending push,
read exactly why a specific item failed, and act on it.

It exposes all of the queue's columns to Views (item id, mapping name, entity id,
operation, failure count, last failure message, claim expiry, created/updated
times) and ships a ready-made admin view listing them. Each row gets **operations
links** — and Views Bulk Operations-style bulk actions — to **reset an item's
failure count** (so it's retried on the next cron run) or **reset its claim
expiration** (so a stuck, still-"leased" item becomes claimable again). A colored
red/green indicator shows at a glance whether an item's lease has lapsed.

It's built for Salesforce administrators to triage stuck syncs without database
access: bulk-reset failures after fixing a bad field mapping, clear expirations
after a Salesforce outage so the backlog reprocesses, or filter the queue by
mapping or operation to isolate a problem. The module itself defines no permissions
of its own — everything is gated by the Salesforce Suite's **administer salesforce**
permission — and it doesn't drain the queue; the Salesforce Suite still does that
on cron.

This guide is written for a **human** using the queue screen through the admin UI.
If you want terse, token-cheap references for an AI coding agent (the Views data
definition, the four Views plugins, and the reset routes), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and the Salesforce Suite dependency.
2. [Configuration](configuration/index.md) — the queue screen, its filters and
   operations, and the one gotcha that can make the default view fail to install.

## Where it lives in the admin menu

The queue screen is at **Content → Salesforce Push Queue**
(`/admin/content/salesforce-push-queue`). Access is controlled by the Salesforce
Suite's **administer salesforce** permission.

> Note: some older documentation points at `/admin/config/salesforce/push-queue` —
> that path is stale. The screen the module actually generates lives under
> `/admin/content/…`.

## How to use it

Open the queue screen, filter or sort to find the problem items, then use the
per-row operations (or select several rows and use the bulk actions) to reset
failures or expirations. See [Configuration](configuration/index.md) for the
details, including what each reset does and how to rebuild the screen if it's
missing.

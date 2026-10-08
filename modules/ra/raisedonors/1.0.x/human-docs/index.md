# RaiseDonors — manual setup guide

**RaiseDonors** (`raisedonors`) connects Drupal 11 to the **RaiseDonors** fundraising
platform using the RaiseDonors 2.0 API. In this release it provides one‑way
synchronization of donor data *from* RaiseDonors *into* Drupal: when a donor is
created or updated in RaiseDonors, the module creates or updates the matching Drupal
user account. It is aimed at nonprofits that manage supporters in RaiseDonors and want
those donors reflected as Drupal users. More features are planned for later releases.

Synchronization works two ways. You can run a **manual full sync** with the "Sync
Donors Now" button (it pulls all donors in batches and shows a progress bar and a
summary), and you can schedule an **automatic sync** to run on cron — daily, weekly,
or monthly, or never. RaiseDonors can also notify your site in real time through
**webhook endpoints** for donor‑created, donor‑updated, and donor‑deleted events. A
donor management view is available at **`/admin/donors`**, and the module keeps
detailed sync statistics and logs.

Security is built in: the API token is stored via the **Key** module (backed by an
environment variable), administration is gated by a dedicated permission, and the
webhook endpoints are protected by a shared **security token** you configure on both
sides. Donor records are personal data, so treat the sync and its logs accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs the Key
   and Address modules) and enable it.
2. [Configuration](configuration/index.md) — store the API token in a Key, test the
   connection, set the webhook token, and choose your sync schedule.

## Where it lives in the admin menu

The settings form is under **Configuration** at `/admin/config/raisedonors`, the
donor management view is at **`/admin/donors`**, and access is controlled by the
**administer raisedonors module settings** permission.

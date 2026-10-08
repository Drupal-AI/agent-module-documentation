# Collector Systems — manual setup guide

**Collector Systems** (`collector_systems`) connects Drupal to the **Collector
Systems API** — a collections-management platform used by museums, galleries, and
private collectors. With it, collection and artwork data from Collector Systems can
be pulled into Drupal so an institution can publish its collection on its website.

It acts as a bridge between the external Collector Systems database and your Drupal
site: the module fetches records from the API so they can be displayed as Drupal
content. It has no other module dependencies and supports Drupal 9, 10, and 11.

Because it talks to an external service, it needs configuration before it does
anything useful — you supply the Collector Systems API credentials (subscription
key, account GUID and subscription ID) on the module's settings form. The module
imports the remote data into its own database tables and serves your public
collection pages from that local copy, so pages are fast and the API is only hit
during sync. Note that this module is **not covered by Drupal's security advisory
policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

After enabling, configure the connection to the Collector Systems API by entering
your subscription key, account GUID and subscription ID on the module's settings
screen (Configuration → Collector Systems). Then run an initial import from the
sync dashboard, and optionally set an automatic-sync schedule so the local copy
stays current. Choose which fields appear on the list and detail pages from the
field-customization screens.

> **Keeping the credentials out of version control.** The settings form saves the
> subscription key into this module's Drupal configuration
> (`collector_systems.settings`). If you export configuration to Git, either
> exclude that config from the export or override the values per-environment in
> `settings.php` (`$config['collector_systems.settings']['subscription_key'] = …`)
> so the live secret is not committed.

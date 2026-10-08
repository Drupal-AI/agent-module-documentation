# Azure CDN Purger — manual setup guide

**Azure CDN Purger** (`azure_cdn_purge`) plugs into the **Purge** module and teaches
it how to clear cached content on **Azure CDN**. When you edit content in Drupal, the
copy sitting in Azure's content‑delivery network can go stale; this module calls
Azure's purge API so those cached objects are invalidated and visitors get the fresh
version.

It is a **purger plugin** for Purge, which means it doesn't work alone — you set up
Purge's normal queue and processor, and this module becomes one of the "purgers" that
Purge drives. It runs on Drupal 10 and 11 and is meant for sites hosted behind Azure
CDN.

To reach Azure's purge API the module uses Azure service-principal credentials
(tenant id, client id, client secret) entered on its settings form, and calls the
Azure management API over TLS. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Purge and
   enable it.
2. [Configuration](configuration/index.md) — enter the Azure credentials and wire it
   into Purge.

## Where it lives in the admin menu

Its own settings live at the **Azure CDN Purge** admin config form
(`azure_cdn_purge.admin_config_form`). The purger itself is added and driven from the
**Purge** configuration at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`).

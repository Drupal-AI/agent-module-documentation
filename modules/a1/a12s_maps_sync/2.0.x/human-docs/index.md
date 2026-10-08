# A12S MaPS System Sync — manual setup guide

**A12S MaPS System Sync** (`a12s_maps_sync`) connects a Drupal site to a **MaPS
System** instance — a Digital Asset Management (DAM) and Product Information
Management (PIM) platform — and synchronises its digital assets and product data
into Drupal as media and content. If your organisation manages its assets and
product catalogue in MaPS System and wants that information to appear in Drupal
without re-keying it, this module is the bridge.

The sync is **multilingual**: it depends on core's **Content Translation**
module and imports translated data accordingly, with translations following
core's content-translation access rules. It provides its own permissions to
control who can work with the sync, and it belongs to the A12S package of
modules.

Because it talks to the MaPS System **API**, it needs **credentials**. Treat
those as secrets: store them in an environment variable (or a Key entity) rather
than hard-coding or committing them, and make sure the connection uses HTTPS.
The module imports external data — it has no access-control role of its own
beyond its permission, so the security of what it pulls in depends on how you
configure field and translation access on the Drupal side.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on this guide.** The upstream documentation for this module is sparse,
> so the steps below describe the general shape of setting it up — install,
> enable, provide MaPS credentials as secrets, grant the permission — rather than
> naming exact form fields. Confirm the precise settings screen against your
> installed version.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connecting to MaPS System with
   credentials stored as secrets, and the module's permission.

## Where it lives in the admin menu

The module adds its own configuration for the MaPS System connection and a
permission of its own. Look for its settings under **Configuration** and its
permission on **People → Permissions** after enabling it; the exact location
depends on your installed release.

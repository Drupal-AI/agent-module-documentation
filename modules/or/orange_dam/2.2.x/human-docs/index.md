# Orange DAM — manual setup guide

**Orange DAM** (`orange_dam`) provides the foundation for integrating Drupal with
**Orange Logic's Orange DAM** digital‑asset‑management platform. It gives you the
generic tooling and API integration to pull assets and their metadata out of Orange
DAM and into Drupal, where they can be used on your site — while leaving field
mapping flexible enough to fit your own data model.

At a high level the module **monitors Orange DAM for changes**, queues the changes it
finds, prepares the updated data for migrations, lets you map fields in custom
migrations, and manages running those processes on cron or through custom Drush
commands. It builds on core **Node** and **Migrate**, plus the **Migrate Plus**
family and **Pathauto**.

It is important to understand what this module is and isn't. It is a **foundation for
a custom integration**, not a turnkey importer. You will still need to build a data
model in Drupal, write and run the migrations that map your Orange DAM fields to it,
and hook into the events the module offers to customise the integration. In other
words, expect some custom development work alongside it.

Because it talks to the Orange DAM API, this module makes **outbound network calls
(egress) using credentials/an API key**. Those credentials must be treated as
secrets, the calls must go over HTTPS, and you should only import and expose assets
that are appropriate for your site's audience. See
[Configuration](configuration/index.md) for how to store the credentials safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate/Pathauto dependencies.
2. [Configuration](configuration/index.md) — connect to the Orange DAM API, store
   the credentials as secrets, and understand the egress and audience
   considerations.

## Where it lives in the admin menu

Orange DAM adds no single settings page of its own — it is a developer‑oriented
integration foundation. Your work happens in **migration configuration** (with the
Migrate Plus tooling), in the Orange DAM API credentials you supply to those
migrations, and in cron / Drush runs that drive synchronisation. See
[Configuration](configuration/index.md) for the details.

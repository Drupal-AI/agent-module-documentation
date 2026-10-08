# Entity Logger — manual setup guide

**Entity Logger** (`entity_logger`) lets you attach **log messages to specific
entities**, giving each entity its own activity log rather than mixing everything
into Drupal's global watchdog. Once enabled for an entity type, each entity gains a
**Log** tab that shows the messages recorded against it — things like "synced to
CRM", "payment failed", or "imported from feed" — in the context of the entity
they belong to.

It's built for situations where the default Drupal logging interface isn't enough:
when you want log messages to appear *within* an entity rather than in a global
list, when you want those messages stored more persistently, and — importantly —
when you want to let specific roles read these logs **without** giving them access
to the site-wide watchdog UI. Code and integrations write the messages; the module
provides the storage, the per-entity Log tab, and permissions to control who can
see them.

Entity Logger depends on **Dynamic Entity Reference** (so a log entry can point at
any entity type) and Drupal core's **Views** (used to display the logs). It has a
small **settings form** where you choose which entity types get logging, and it
ships its own permissions. Because log entries can contain operational detail that
reveals internal process information, gate who can view them with those
permissions — the module records messages against entities but does not otherwise
change entity access. It runs on Drupal 10.1 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Dynamic
   Entity Reference and Views dependencies, then enable it.
2. [Configuration](configuration/index.md) — choose which entity types get a Log
   tab, and set who can view and add log entries.

## Where it lives in the admin menu

Entity Logger's settings form lives in the **Configuration** area (config object
`entity_logger.settings`), where you pick which entity types have logging enabled.
Once an entity type is enabled, each of its entities shows a **Log** tab (alongside
View / Edit / Delete) for the users you've permitted.

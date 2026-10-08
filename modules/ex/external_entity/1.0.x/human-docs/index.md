# External Entities (Consumer) — manual setup guide

**External Entities** (`external_entity`) — the "Consumer" side of the External
Entity Server / Consumer pair — lets you **display live content from another Drupal
site as if it were part of your own**: fully themed, usable in Views, and rendered
with view modes, without duplicating or migrating that content. It's aimed at site
builders who want a Drupal-native way to share and show content across multiple
Drupal sites.

The classic example is a school district: the district site runs the **External
Entity Server** module to expose its *News* content type, and each school site runs
this **Consumer** module to fetch and render that news, styled and displayed like
local content — no copies, no sync pipeline. You map the remote entity type to a
local one, choose a view mode, and the remote records behave like native entities:
reference them from a field, or list and filter them in Views.

Because the data comes from an external source, treat it as an integration with
security implications: store any credentials the connection needs as secrets (the
Key module or environment variables), prefer HTTPS, make sure the remote site is
trusted, and configure access so sensitive remote content isn't exposed more
broadly than intended. The module requires **PHP 8.3** and provides its own
permission.

> **Prerequisite:** this Consumer module assumes you already have the **External
> Entity Server** module installed on the remote Drupal site, with at least one
> resource configured and exposed.
>
> **Version note:** this is release **1.0.0-rc1** (a release candidate).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a connection to the server and
   define external entity types.

## Where it lives in the admin menu

There are two configuration areas:

- **Connections** — **Configuration → Web services → External Entity → Connection**
  (`/admin/config/services/external-entity/connection`), where you point at a remote
  External Entity Server.
- **External entity types** — **Structure → External entity**
  (`/admin/structure/external-entity/type`), where you map remote entities to local
  types.

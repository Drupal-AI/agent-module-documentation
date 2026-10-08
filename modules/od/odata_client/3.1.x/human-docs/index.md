# OData Client — manual setup guide

**OData Client** (`odata_client`) connects Drupal to an **OData server**. OData is
an open, REST‑like protocol for querying and updating data, used widely by
Microsoft and other enterprise systems — so this module is the bridge that lets
Drupal read (and, where the server allows, write) data from those external business
systems. A common use is integrating Drupal with **Microsoft Dynamics CRM**.

You describe each OData server as a **configuration entity** (endpoint, default
collection, and authentication), and then your code talks to it through the
module's services. It provides two main services: `odata_client.io` for direct
operations (connect, switch collection, find by key, count, create) and
`odata_client.query` for a fluent query builder (select fields, add conditions,
sort, and range/limit) that returns matching records.

This is an **integration / developer library** — it has no content type or
access‑control role of its own. Its job is to give your custom code a clean way to
reach an OData endpoint. Because that endpoint's credentials are sensitive, store
them securely (environment‑backed) rather than in code or version control, as the
[Configuration](configuration/index.md) page describes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   OData/OAuth client libraries) and enable the module.
2. [Configuration](configuration/index.md) — create a server configuration and
   store its credentials securely.

## Where it lives in the admin menu

Server configurations are managed at **Structure → OData server**
(`/admin/structure/odata_server`), where you add and edit each OData server entity.
Once a server (for example one named `default`) exists, your code connects to it by
name — see [Configuration](configuration/index.md) for the setup and a usage
example.

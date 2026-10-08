# JSON:API Entity Operations — manual setup guide

**JSON:API Entity Operations** (`jsonapi_entity_operations`) adds a **"See JSON:API
resource"** link to the operations dropbutton on entity admin listings, taking an
editor straight from an entity to its JSON:API individual-resource URL (opened in
a new tab). It's a convenience for people building or debugging a decoupled site:
instead of hand-constructing the JSON:API path for a node, you click a link and
see the resource output.

Despite the project name, **this version adds no create/update/delete write
operations to JSON:API.** It only surfaces a navigation link to the standard
JSON:API resource that already exists. It does not create any new endpoint and it
does not change who may read or write a resource — all actual JSON:API access
control stays with core JSON:API and Drupal's entity access. Broadening what your
API exposes is done in core JSON:API's own configuration, not here.

Who sees the link, and on which entity types, is under your control:

- A dedicated permission (`view jsonapi_entity_operations`) decides which roles see
  the link at all.
- A settings form decides which entity types show it (the default is content nodes).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the permission and choose which
   entity types show the link.

## Where it lives in the admin menu

The module's settings sit at **Configuration → Web services → JSON:API → Entity
Operation Settings**
(`/admin/config/services/jsonapi/entity_operations/settings`). The link itself
appears in the operations dropbutton on the admin listings of the entity types you
enable — for example on the **Content** page (`/admin/content`) for nodes.

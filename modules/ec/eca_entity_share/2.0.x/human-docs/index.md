# ECA Entity Share — manual setup guide

**ECA Entity Share** (`eca_entity_share`) integrates
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action) with the
[Entity Share](https://www.drupal.org/project/entity_share) module, which
syndicates content between Drupal sites in a client/server arrangement. With this
bridge in place, ECA models can react to Entity Share events, so content
syndication between sites can be orchestrated by no-code automation.

The module ships as two submodules that mirror Entity Share's own split:

- **ECA Entity Share Client** (`eca_entity_share_client`) — exposes the
  *Relationship Field Value* event to ECA on the client (importing) side.
- **ECA Entity Share Server** (`eca_entity_share_server`) — exposes the *Channel
  list prepared* event to ECA on the server (exporting) side.

Enable whichever side matches the role that Drupal site plays. Sharing access and
the sync itself remain governed by **Entity Share** — this module adds ECA
orchestration on top and has **no access-control role of its own**. There is no
settings form; you use the events it adds inside the ECA modeller.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   client and/or server submodule.

There is **no configuration page** for this module — it has no settings form. You
use the events it adds inside the ECA modeller, described in "How to use it" below.

## Where it lives in the admin menu

ECA Entity Share adds no admin page of its own. Entity Share's channels and remotes
are configured on the Entity Share side (under **Configuration → Web services →
Entity Share**), and the ECA models that react to its events are built in the ECA
modeller at **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`).

## How to use it

1. Set up **Entity Share** first — define channels on the server site and remotes
   on the client site so syndication works on its own.
2. Enable the submodule for this site's role: `eca_entity_share_server` on an
   exporting site, `eca_entity_share_client` on an importing site.
3. In the ECA modeller at **Configuration → Workflow → ECA**, build a model that
   listens for the newly available event — *Channel list prepared* on the server,
   or *Relationship Field Value* on the client — and add the conditions and actions
   you want.

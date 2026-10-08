# Entity Holder — manual setup guide

**Entity Holder** (`entity_holder`) solves a recurring headache: content is
dynamic, but some pages need a *stable, permanent* path and route that must exist
on every environment — a home page, a 403/404 page, an essential landing page.
Normally you'd point a setting at something like `/node/1`, which forces that exact
node to exist and survive on dev, staging and production alike. Entity Holder gives
you a durable placeholder instead.

A **holder** is a small configuration entity that reserves a path and route for a
piece of content of a chosen type — even before that content exists in a given
environment. Each holder records an administrative title, a public title, a path,
the target entity type and bundle it will hold, and the **UUID** of the content
entity bound to it. Because holders are configuration, they travel with config
sync; because they match content by UUID, the actual content can be authored
separately in each environment and still line up. You can also give a holder some
**fallback content** (formatted text) to display until the real content is created.

Every holder gets its own argument‑free route named `entity_holder.view`, which
makes it easy to point menu links or custom‑module code at a page that will always
resolve. When someone visits the holder's path and a held entity exists, Entity
Holder renders that entity in place (via an internal sub‑request to its canonical
URL); when nothing is held it shows the fallback text, offers a "create this
content" link to users who may create it, or returns a clean 404.

A note on access and trust: all holder management screens are admin routes gated
by the **Administer entity holders** permission. Viewing a holder defers to the
held entity's own access rules (and is denied for disabled holders); with no held
entity it falls back to the core **Access content** permission. The fallback body
is rendered through a text format, so that format governs the markup it allows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage holders, bind
   content by UUID, and set up the config‑sync deployment pattern.

## Where it lives in the admin menu

Holders are managed at **Structure → Entity holders**
(`/admin/structure/entity-holder`), which is the module's configure route
(`entity.entity_holder.collection`). You need the **Administer entity holders**
permission to reach it.

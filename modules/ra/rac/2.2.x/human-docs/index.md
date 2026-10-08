# Role Access Control — manual setup guide

**Role Access Control** (`rac`) restricts which **roles** may see a piece of content,
turning "only these roles may view this" into a proper Drupal **node access grant**
rather than a hand‑written access module. It was designed around the same idea as
Taxonomy Access Control, but it keys access off **role reference fields** instead of
taxonomy terms — which is simpler when your access rules already mirror your list of
roles.

The 2.x branch documented here is built on top of the **Advanced Access (ADVA)**
module. ADVA provides the reusable grants machinery and a clean settings interface;
RAC is the role‑based policy layer on top of it. Practically, that means you
administer RAC through **ADVA's own settings page** rather than a page of its own,
and you extend access to related entities with the optional **RAC Relations**
(`rac_relations`) submodule.

Because RAC works at the node‑access‑grant level, its restrictions apply everywhere
content is queried — including **Views and search** — not just on the display layer.
That is its main advantage over display‑only protection, which can leak through
listings or APIs.

> **Two things to know about node access grants.** First, grants are **OR‑combined
> across modules**: if another access module grants *view* on the same content, that
> grant wins and RAC's restriction is effectively overridden — so if content is
> visible that should not be, look for a second grants provider before suspecting
> RAC. Second, changing access configuration on an existing site requires a **node
> access rebuild** before listings and search are correct again.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Advanced
   Access and enable it.
2. [Configuration](configuration/index.md) — add a role reference field, enable Role
   Access for the entity type in ADVA, and rebuild node access.

## Where it lives in the admin menu

RAC is administered through Advanced Access at **Configuration → People → Advanced
Access Settings** (`/admin/config/people/adva`). That is where you enable "Role
Access" for each entity type.

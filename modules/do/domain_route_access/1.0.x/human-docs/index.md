# Domain Route Access — manual setup guide

**Domain Route Access** (`domain_route_access`) lets administrators restrict which
domains a given **route** is reachable on. It is part of the **Domain** ecosystem
and depends on the base `domain` module.

The use case is easy to picture: you run `example1.com` and `example2.com` from one
install, and you want visitors to be able to create accounts only on
`example2.com`. With Domain Route Access you add an access rule to the
`user.register` route so it answers only on `example2.com`. More broadly, it is a
tidy way to keep admin pages, API endpoints, or campaign routes answering only on
the domain they are meant for.

It is built on solid foundations. You create a **Domain Route Access** config
entity naming a route and the domains allowed to reach it; a route subscriber then
adds a standard `_domain` access requirement to that route, so enforcement is
delegated to the **Domain module's own audited access check** rather than a
home-grown gate. It restricts *existing* routes only — it never creates new
endpoints or exposes data — and an entry with no allowed domains is skipped, so an
empty selection cannot accidentally lock everyone out. There is one operational
catch: because requirements are baked in when routes are rebuilt, you must **clear
caches after adding or editing an entry** for it to take effect. Take care when
restricting core or system routes, and test, so you don't lock admins out of a
domain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the Domain module.
2. [Configuration](configuration/index.md) — add route-access rules, and the
   alternative `_domain` route requirement for developers.

## Where it lives in the admin menu

Rules are managed at **Configuration → Domain → Route Access**
(`/admin/config/domain/route-access`), gated by the dedicated **`administer domain
route access`** permission.

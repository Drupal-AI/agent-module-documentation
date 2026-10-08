# Domain Microsite by Path — manual setup guide

**Domain Microsite by Path** (`domain_microsite`) lets you create "microsites" at
sub-paths of your existing domains using the **Domain** module. Instead of setting
up a separate hostname, a sub-path such as `example.com/microsite` behaves like a
full Domain-module domain, with its own content and context. It extends the
**Domain** ecosystem and depends on the base `domain` module.

Under the hood, every microsite is simply a Domain record with a little extra
configuration: a *microsite base path* and a *parent domain*. The module detects
when an incoming request matches a microsite's base path, sets that as the active
domain, and rewrites paths so the base path is stripped from incoming requests and
prepended to outgoing links. You manage a microsite the same way you manage any
other domain record. Because it builds on Domain records, **Domain's own access
controls still govern what each microsite shows** — this module maps sub-paths to
domains; it has no access-control role of its own. It is worth verifying that your
microsite mapping matches the content isolation you intend.

Two practical notes. This module is currently marked *seeking a new maintainer*
with no further development planned, so evaluate it against your needs before
adopting. And the Domain module's route caching does not play perfectly with
microsites — the project points to a Domain issue and a patch to make route caches
work correctly; check the project page if you hit caching oddities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the Domain module.
2. [Configuration](configuration/index.md) — turn a Domain record into a
   microsite by giving it a parent domain and a base path.

## Where it lives in the admin menu

Microsites are managed exactly where ordinary domains are: **Configuration →
Domain** (`/admin/config/domain`). There is no separate settings page — the
microsite options appear as extra fields on the domain record add/edit form.

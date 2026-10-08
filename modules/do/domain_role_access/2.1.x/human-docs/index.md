# Domain Role Access — manual setup guide

**Domain Role Access** (`domain_role_access`) lets you grant **domain access by
role** instead of only per user. It extends the **Domain / Domain Access**
ecosystem and depends on the `domain` module and its `domain_config` submodule.

Out of the box, Domain Access decides which domains a user can reach from a field on
each individual user's profile. That is fine until you have many editors and many
domains, at which point assigning domains one account at a time becomes tedious and
error-prone. Domain Role Access adds the missing shortcut: you assign **roles** to
a domain record, and any user holding one of those roles gets the same access to
that domain as if the domain were filled in on their profile.

Crucially, this module is built on the correct foundation. It **decorates** Domain
Access's own access-value logic to include role-derived domains, so role-based
access flows through Domain Access's existing, audited enforcement (the node-grants
system that filters domain-restricted content at the query level). In other words
it **extends** Domain Access rather than bypassing it. The final access is the
union (an *OR*) of the per-user domain field and the role-derived domains — it only
*adds* access, never removes or overrides. It provides no new access restrictions
of its own, so the result is only ever as correct as your underlying Domain Access
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain and Domain Config.
2. [Configuration](configuration/index.md) — map roles to domains from each domain
   record.

## Where it lives in the admin menu

Role-to-domain mappings are managed from the domain records page at
**Configuration → Domain** (`/admin/config/domain`): each domain gains a new
**Roles** action link in its list of actions.

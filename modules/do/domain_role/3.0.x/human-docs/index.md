# Domain Role — manual setup guide

**Domain Role** (`domain_role`) adds **per-domain user roles** on top of Domain
Access, so one account can hold different roles on different domains of the same
site. It extends the **Domain** ecosystem and depends on the `domain` module and
its `domain_config` submodule.

On a standard Domain Access site, roles are global: an "editor" is an editor
everywhere. That is wrong for franchise, brand, or affiliate setups where someone
should be an editor on brand A but an ordinary member on brand B. Domain Role
solves this by partitioning roles per domain. It leverages `domain_config` to give
each domain its own role configuration and provides a UI to manage them. Behind the
scenes it uses a naming convention — a role machine name like `{domain}_{role}` —
and a custom cookie authentication provider that, at request time, negotiates the
active domain and remaps those domain-prefixed roles down to their base role for
whichever domain the visitor is on. Roles that belong to a *different* domain are
dropped, preventing cross-domain role leakage, while global (non-domain) roles
apply everywhere. It also ships Views field and filter plugins for building
per-domain people listings.

Two important cautions. Permissions themselves are still defined **globally** — the
module partitions *roles*, so an account must be given the right role on each
domain where it should have access. And because it overrides both the core User
entity class and the Cookie authentication provider, it may conflict with sites
that use alternative authentication providers or otherwise override the user
entity — the maintainers note this should be used for lower-level staff roles, not
as a substitute for careful admin-access control. The module is *minimally
maintained*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain and Domain Config.
2. [Configuration](configuration/index.md) — define domain roles and assign them
   to users.

## Where it lives in the admin menu

Domain roles are configured at **People → Domain Role**
(`/admin/people/domain_role`), gated by the standard **Administer domains**
permission. You then assign the generated domain-specific roles to users on the
normal user edit screen.

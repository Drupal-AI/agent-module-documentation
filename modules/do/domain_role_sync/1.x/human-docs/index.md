# Domain role synchronization — manual setup guide

**Domain role synchronization** (`domain_role_sync`) keeps a user's Domain
memberships and their Drupal roles aligned: you associate a domain with one or more
roles, and when a user who is affiliated with that domain is created or saved, they
automatically receive the roles mapped to it. It extends the **Domain** ecosystem
and depends on the base `domain` module.

The problem it bridges is a common one. Plenty of Drupal modules provide granular
functionality based on **roles** but know nothing about domains — the classic
example is *Menu admin per menu*, which lets you assign edit rights to a specific
menu by role. If you run a per-domain menu and want each domain's editors to manage
only their own menu, you need a role per domain and a way to keep the right people
in the right role. Domain role synchronization is that glue: affiliate a user with
a domain and the associated role follows automatically, so functionality that only
speaks "roles" starts respecting your domain structure. It typically expects you to
create a role per domain.

A couple of scope notes from the maintainers. At present the sync is oriented
around granting roles from domain affiliation; removing a role when an affiliation
ends, and the reverse direction (adding a domain affiliation when a user gains a
role), are on the roadmap rather than guaranteed in this release — verify the exact
behaviour on your version. The module is also not covered by Drupal's security
advisory policy. A similar module worth comparing is *Domain Role Access*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the Domain module.

The role↔domain mapping is the whole of the configuration; it is described under
"How to set it up" below.

## Where it lives in the admin menu

The module works through Domain and role administration rather than adding a
prominent standalone section — you create the roles you need under **People →
Roles** and manage domain affiliations through the **Domain** module
(`/admin/config/domain` and the user profile's domain field).

## How to set it up

1. **Create a role per domain** you want to synchronise (for example
   `brand_a_editor`, `brand_b_editor`) under **People → Roles**.
2. **Associate each domain with its role(s)** so the module knows which roles to
   grant to users affiliated with that domain. (Consult the module's project page
   for the exact place this mapping is entered on your version.)
3. **Affiliate users with domains** as usual through Domain / Domain Access. When
   such a user is created or saved, the module grants them the roles mapped to the
   domains they belong to.

Because the roles then flow automatically from domain membership, you can point
role-only tools (such as *Menu admin per menu*) at those roles and they will
effectively become domain-aware.

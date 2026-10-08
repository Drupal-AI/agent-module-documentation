# Group Context Domain — manual setup guide

**Group Context Domain** (`group_context_domain`) derives the active
[Group](https://www.drupal.org/project/group) from the **current domain** and
exposes it as a *"Group from domain"* context that blocks, the Group Sites module,
and any other context‑aware code can consume.

A common multi‑tenant shape in Drupal pairs Group (for the tenancy model) with the
Domain module (for the addressing): each tenant is a Group, each has its own
domain, and one Drupal serves them all. The gap this closes is that Group's context
is normally derived from the **route** — you are "in" a group because you are
looking at that group's content — whereas on a tenant site the group is implied by
the **hostname**, whatever page you are on. With this module a block placed with a
Group context condition works on the tenant's homepage, not only on its group
pages.

Configuration is deliberately simple: you grant someone the **set domain group**
permission, then open a domain record's form and assign it a group you are allowed
to edit.

> **Context is presentation plumbing, not access control.** Deriving a group from
> the domain tells blocks and plugins which tenant is active; it does **not** stop
> one tenant's content being reachable on another's domain. On a site where tenants
> must not see each other's data, the boundary is Group's permissions plus whatever
> domain access module is in play — this module makes the UI coherent, not the
> boundary. It is also worth confirming what happens when a domain has **no** group
> assigned, or when **two** groups claim the same domain, since both are states a
> real site can reach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group and Domain.

There is **no dedicated settings form** for this module (`configure` is null). You
assign a group to a domain directly on the domain record's edit form, described
under "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page of its own. Grant the **set domain group**
permission at **People → Permissions**, then assign groups to domains from each
domain record's edit form under the Domain module's administration
(**Configuration → Domains**). The context it produces is then selectable wherever
Drupal contexts are used — for example when placing a block.

## How to use it

1. Grant the **set domain group** permission to the appropriate role at **People →
   Permissions**.
2. Edit a **domain record** and assign it a group you are allowed to edit.
3. Place a block (or use another context‑aware feature) with a **Group** context
   condition — it now resolves the group from the current domain, working even away
   from group routes such as the tenant's homepage.

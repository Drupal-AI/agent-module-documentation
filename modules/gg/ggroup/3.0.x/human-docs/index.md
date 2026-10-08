# Subgroup (ggroup) — manual setup guide

**Subgroup** (`ggroup`) extends the [Group](https://www.drupal.org/project/group)
module so that a group can itself belong to another group. That turns Group's flat
list of groups into a full parent/child hierarchy — and because a group can have
more than one parent, it's really a graph rather than a strict tree. It's the way
you model an *organisation → department → team* structure, a franchise or
multi-tenant hierarchy, or committees nested under an umbrella organisation, where
every level is a real Drupal Group.

Technically, Subgroup adds a group-relation plugin (one variant per group type on
your site) that relates one group to another as a subgroup. When you enable it on
a parent group type, that parent can hold child groups of the chosen type, either
by relating an existing group or by creating a new one through a short wizard.
Every parent/child edge is recorded in a dedicated hierarchy table that
pre-computes all direct *and* implied ancestor/descendant links, so "give me every
descendant group" is a single fast query rather than a recursive walk. A built-in
constraint blocks circular references (you can't make a group a subgroup of its
own descendant), and a Views argument lets a view list group content across a
configurable number of subgroup levels. It depends on the Group module (`^3.0`).

One important expectation to set: this 3.0.x release provides the **hierarchy graph
and the creation UI**. It does *not* itself bake in permission *inheritance*
between parent and child groups — how membership and permissions flow across levels
is handled by the wider Group ecosystem, not by this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.
2. [Configuration](configuration/index.md) — enabling subgroups on a group type,
   the creation wizard, the Views depth argument, tokens and permissions.

## Where it lives in the admin menu

There is no global settings page. You enable and configure subgroups **per group
type** under **Administration → Groups → Group types**
(`/admin/group/types`), on each parent type's *content / manage plugins* screen.
Creating and relating subgroups then happens from the group's own pages
(`/group/{group}/subgroup/…`).

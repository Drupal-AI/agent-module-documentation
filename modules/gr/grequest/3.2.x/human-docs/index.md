# Group Membership Request — manual setup guide

**Group Membership Request** (`grequest`) extends the contrib **Group** module so
that non-members can *ask* to join a group, and group admins can approve or reject
those requests through a simple workflow. It turns a manual, invite-only process
into a self-service "request and approve" flow — a natural fit for communities,
associations, courses/cohorts, or project groups.

Once set up on a group type, users with permission see a **"Request membership"**
link on a group. Each request is tracked through the states *new → pending →
approved / rejected* (managed by the **State Machine** module). Group admins
review pending requests on a per-group page and either **approve** — which turns
the requester into a real member, optionally assigning them group roles — or
**reject** them. There are also bulk approve/reject actions for Views, and a
programmatic API for custom code.

The module builds on Group's "relation plugin" system, so there is **no global
settings form**: you enable the feature by installing the "Group membership
request" relation on each group type where you want it, just as you install the
standard "Group membership" relation. It requires the **Group** (version 3) and
**State Machine** modules and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — install the request relation on a
   group type, set its option, and grant the group permissions.

## Where it lives in the admin menu

There is no site-wide settings page. You configure the feature per group type
under **Administration → Groups → Group types**
(`/admin/group/types`), on each group type's *Set up content* and *Permissions*
pages. Admins moderate requests on each group at
`/group/{group}/members-pending`.

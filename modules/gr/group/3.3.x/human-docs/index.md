# Group — manual setup guide

**Group** (`group`) lets you bundle users, content and other entities into
self‑contained "groups" — think teams, workspaces, communities, clients, or
sections — where each group has its own members, its own roles, and its own
permissions, independent of the sitewide role/permission system. It's the modern
successor to Organic Groups, and it's the go‑to way to build private spaces or
multi‑tenant areas on a single Drupal site.

A **group** is a fielded content entity of a configurable **group type**. Anything a
group "contains" — its members, its nodes, any related entity — is attached through a
**group relationship** record, and which entity types a group type can relate is
decided by installing **relation plugins** onto it (the *Group membership* plugin
relates users; the `gnode` submodule's *Group node* plugin relates nodes). Access is
governed per group by **group roles**, which come in three scopes: **outsider**
(non‑members), **insider** (members), and **individual** (assigned to a specific
membership, e.g. a group admin). Outsider and insider roles synchronize with your
sitewide roles; individual roles are assigned per member.

Permission calculation is delegated to the **Flexible Permissions** module, and Group
also depends on the contrib **Entity** module and core's **Options** module. Two
submodules ship with it: **Group Node** (`gnode`) lets groups relate nodes, and
**Group Revisions** (`group_support_revisions`) adds per‑group revision access.

> **Version 3 renamed some things.** The old `GroupContent` entity is now
> `group_relationship`, `GroupContentType` is now `group_relationship_type`, and the
> `GroupContentEnabler` plugin type is now `GroupRelationType`. If you're following an
> older tutorial written for Group 1.x/2.x, translate those names as you go.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in Entity
   and Flexible Permissions), enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — create group types, choose which content
   they can relate, and set up group roles and permissions.

## Where it lives in the admin menu

Group adds a top‑level **Groups** admin section. The main settings form is at
**Groups → Settings** (`/admin/group/settings`), group types are managed under
`/admin/group/types`, and each group type has its own permissions and "content"
(relation plugin) pages. All of these require the **Administer group** permission.
Actual groups (the content) are created and listed under the Groups menu once at
least one group type exists.

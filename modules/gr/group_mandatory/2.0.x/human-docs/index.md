# Group Mandatory — manual setup guide

**Group Mandatory** (`group_mandatory`) lets you require that content of certain
types can only be created *inside* a group, never as standalone, unaffiliated
content. It extends the [Group](https://www.drupal.org/project/group) module and
is useful when everything of a given kind — say, every project document or every
event — must belong to a team, department, or workspace.

You switch this on per group relationship (group content) type by ticking a
**Mandatory** checkbox on that type's configuration form. Once a bundle is marked
mandatory, Group Mandatory takes over the standard "add content" route for that
bundle. Instead of the normal create form, the user sees a group picker that lists
only the groups they are actually allowed to post that content into — with links
to the per-group create form for each one — or, if they belong to no eligible
group, the message *"You must be member of a group to do this."*

The important part is that this is enforced on the server as a route access check,
not merely by hiding a button. A user who is not a member of a suitable group
simply cannot reach the standalone create form for a mandatory bundle. Group
Mandatory does not make its own access decisions — it defers entirely to Group's
per-plugin create-access handlers — and it adds no permissions or settings pages
of its own beyond the per-type checkbox.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group and Route Override.

There is **no central settings form**. You mark a bundle mandatory on its group
relationship type form, described under "How to use it" below.

## Where it lives in the admin menu

Group Mandatory adds no settings page of its own. Its one control — the
**Mandatory** checkbox — lives in the **Group mandatory** fieldset on a **group
relationship type** configuration form, reached by editing the group content
(relationship) type for the bundle you want to constrain.

## How to use it

Prerequisites: the Group and Route Override modules installed, and a group type
that has a relationship (group content) plugin for the entity bundle you want to
make mandatory.

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the **group relationship type** for the bundle you want to constrain
   (in Group 2.x this is a `group_relationship_type`).
3. In the **Group mandatory** fieldset, tick **Mandatory** ("This content must
   have a group") and save.

From then on, the standalone create form for that bundle is blocked. Anyone trying
to create the content is sent to a group picker showing only the groups they may
post to — or told they must be a member of a group first.

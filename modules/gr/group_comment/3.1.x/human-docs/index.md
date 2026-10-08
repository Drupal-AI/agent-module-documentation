# Group Comment — manual setup guide

**Group Comment** (`group_comment`) brings comments under the
[Group](https://www.drupal.org/project/group) module's access system, so who may
read and post a comment is decided by **group membership** rather than by
site‑wide comment permissions.

Comments are one of the parts of a group site that most obviously want group
scoping and that Drupal core does not scope. A department's discussion, a project
team's notes on a document, a course cohort's questions — each is a conversation
that belongs to a group, yet core's comment permissions are per comment type and
per site, so a member of one group could otherwise read another group's
discussion. This module makes a comment a relationship of its group:

- A comment posted in a commentable group automatically becomes an entity of that
  group.
- A comment posted on a commentable grouped entity automatically becomes an entity
  of every group that entity belongs to.
- Removing a commentable entity's relation from a group automatically detaches its
  comments from that group.
- It supports posting, updating, and deleting any/own comments per comment type,
  and honours a per‑group "skip comment approval" setting per comment type.

> **This branch requires a Drupal core patch.** For the module to work you must
> patch core with the patch in issue [#2879087] — use the appropriate patch for
> your core version (see the module's project page for the exact comment/patch
> numbers per Drupal version). Without the patch, group scoping of comments will
> not function. Note this release is an **alpha** and is not covered by Drupal's
> security advisory policy.

> **Two things worth verifying.** First, confirm that the group scoping here is
> real **entity access** — a comment restricted to a group should be restricted in
> Views, JSON:API, and REST, not merely hidden on the rendered page. Second,
> **comments are indexed and notified**: a search index built before the
> restriction still holds the text, and comment notification emails send content
> to subscribers regardless of group — so check the search index and the
> notification path as well as the access layer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, apply
   the required core patch, and enable it alongside Group and Comment.

There is **no dedicated settings form** for this module (`configure` is null). The
setup is done by making comment fields commentable on grouped entities and by
managing Group's own permissions; developers can further customise which groups a
comment attaches to with the `hook_group_comment_attach_groups_alter` hook.

## Where it lives in the admin menu

Group Comment adds no central admin page. You manage comment scoping through
Group's own administration (**Groups**, group types, and their content plugins)
and through **People → Permissions**. Comment types themselves are managed under
**Structure → Comment types**.

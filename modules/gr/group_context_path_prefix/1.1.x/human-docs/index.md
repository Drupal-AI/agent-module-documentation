# Group context: Path prefix — manual setup guide

**Group context: Path prefix** (`group_context_path_prefix`) resolves the active
[Group](https://www.drupal.org/project/group) from a **URL path prefix**. Once
enabled, every group can be assigned a prefix, and content within a group with a
prefix has its URL rewritten to sit under that prefix — so group‑aware features can
tell which group applies straight from the path.

For example, given a group named *Private* with the prefix `/private`, and an
article with the alias `/my-first-post` placed in that group, the article's path is
rewritten to `/private/my-first-post`. The prefix in the URL then acts as the
"active group" signal for anything that consumes a Group context.

This is especially useful together with the
[Group Sites](https://www.drupal.org/project/group_sites) module, which adds access
controls to support micro‑site‑like behaviour. Continuing the example, an
administrator requesting `/private/admin/content` would see only content within the
*Private* group (or content in no group at all).

> **This module resolves the active group; it does not grant access.** It tells
> group‑aware features which group is in play based on the path, but actual access
> still relies on the Group module's membership and permissions (and, where used,
> Group Sites). It has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.

There is **no central settings form** for this module (`configure` is null). You
assign a path prefix per group, on the group itself, described under "How to use
it" below.

## Where it lives in the admin menu

The module adds no settings page of its own. You set a path prefix on each **group**
through Group's own group add/edit forms under **Groups**. Its behaviour is most
visible on group content URLs, which get rewritten to include the prefix.

## How to use it

1. Enable the module alongside the Group module.
2. Assign a **path prefix** (for example `/private`) to a group.
3. Place content in that group — its URL is rewritten to sit under the prefix (for
   example `/private/my-first-post`).
4. Group‑aware features now resolve the active group from the prefix in the URL.
   Combine with **Group Sites** for the micro‑site access behaviour described
   above.

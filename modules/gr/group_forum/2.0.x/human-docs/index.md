# Group Forum — manual setup guide

**Group Forum** (`group_forum`) brings Drupal's core **Forum** together with the
[Group](https://www.drupal.org/project/group) module, so that forum containers
and the topics posted in them can belong to a group and follow that group's
access rules. It lets you build community sub-sites where each group runs its own
private (or shared) discussion forum, and non-members simply never see it.

Under the hood it adds a group content plugin that relates the *forums* taxonomy
terms to groups, and it provides routes for adding or creating a forum inside a
group (`group/{group}/forum/add` and `.../create`), guarded by the group
permission **create group_forum content**. The real work is access enforcement:
forum terms and forum nodes are checked against the owning group's
*view/update/delete group_forum* permissions (walking up the forum hierarchy so
child forums inherit access), forbidden forums are hidden from term and
vocabulary listings, and Drupal's node access grants make the same rules apply to
views and node lists too. Anonymous and non-member ("outsider") access is derived
from the group type's roles.

Access is therefore always decided by Group's own permission system plus Drupal's
node grants — a user only sees or edits a group's forum content where their group
membership and role allow it. Users who hold the site-wide **bypass group access**
permission get a bypass realm that lets trusted staff see everything.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Forum and Group.

There is **no central settings form**. You configure Group Forum on a group type
and through group permissions, described under "How to use it" below.

## Where it lives in the admin menu

Group Forum adds no settings page of its own. You set it up on a **group type**
(**Groups → Group types → *(your group type)* → Content**, where you install the
*Group forum* plugin) and through that group type's **permissions**. It also
provides a *group forum overview* report, gated by the **access group_forum
overview** permission, and ships a bundled `group_forum` overview view.

## How to use it

1. Enable the module (this also enables core Forum and Group — see
   [Installation](installation/index.md)).
2. On the group type you want forums for, go to its **Content** tab and
   **install** the *Group forum* content plugin.
3. Configure that group type's / group's permissions so the right roles hold:
   **create group_forum content**, **view group_forum content**, **update any
   group_forum entity**, **delete any group_forum entity**, and the
   view-unpublished variant.
4. Relate an existing forum container to a group, or create a new one inside a
   group, using `group/{group}/forum/add` or `group/{group}/forum/create`.

From then on, forum visibility and editing follow each group's membership and
roles: members see and post in their group's forum, non-members do not, and the
rules apply consistently across forum pages, term listings, and views.

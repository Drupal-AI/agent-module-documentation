# Group Join Link — manual setup guide

**Group Join Link** (`group_join_link`) adds a **join / leave link** for a group,
so members of your community can join or leave a group themselves rather than
waiting for an administrator to add them. It is part of the
[Group](https://www.drupal.org/project/group) module ecosystem and works as a
**Views field**, which you can place in any listing of groups — a directory of
groups, a group teaser, and so on.

The link is deliberately not a way around Group's rules. Whether a given user can
actually join is still governed by the group type's membership settings and
permissions, so the link only surfaces an action the user is already allowed to
take. If a user cannot join, the join action is not offered.

Because joining a group can grant access to that group's content, it is worth
confirming your groups' join settings match your intent before you expose the
link. In particular, an **open-join** group means anyone can join and immediately
gain whatever access membership carries — that is a feature, but only if it is the
one you want. The link respects Group's access; the real control is how you
configure who may join.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views and Group.

There is **no central settings form**. You add the join/leave link as a field in a
View, described under "How to use it" below.

## Where it lives in the admin menu

Group Join Link adds no settings page of its own. It provides a **Views field**
that you add through the Views UI (**Structure → Views**). The behavior of the
link — who may join and what that grants — is controlled by your group type's
membership settings and permissions.

## How to use it

1. Enable the module (this needs Views and Group — see
   [Installation](installation/index.md)).
2. Edit or create a View that lists groups (**Structure → Views**).
3. Add the group **join / leave link** field to that View and save.
4. Review your group type's **join settings** so the link only invites the joins
   you intend — remember an open-join group lets anyone join and gain that
   group's content access.

The link then appears in the listing, offering *join* or *leave* to each user
according to what Group's rules permit for them.

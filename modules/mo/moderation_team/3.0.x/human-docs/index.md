# Moderation Team — manual setup guide

**Moderation Team** (`moderation_team`) adds team-based functionality to content
moderation. It is built for sites that receive an overwhelming number of
submissions and want a team of trusted users to share the moderation effort
rather than everyone working from a single, undifferentiated queue.

The idea is simple and powerful: users designated as moderators each get **their
own list of submissions** to work through, so the team can aim for "inbox zero"
in individual queues without two people accidentally reviewing the same item. When
the number of moderators changes — because you add or remove a moderator role —
the module **re-shares the submissions evenly** so the queue lengths stay
balanced. Today it handles **nodes**; other entity types (comments, user
accounts, webforms, custom entities) are on the roadmap.

The module works on Drupal 9, 10, and 11 and has no contrib dependencies. It
provides its own permissions, so setup centers on assigning the moderator role
and permissions to the right people rather than on a settings form. This guide
folds that setup into this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A note on release status:** at the time of writing this branch is a
> development release (3.0.x-dev) and is **not covered by Drupal's security
> advisory policy**. Test on a non-production environment before relying on it.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. You set it up by
assigning the moderator role and the module's permissions, as described in "How
to use it" below.

## Where it lives in the admin menu

Moderation Team does not add a central settings page. You work with it through
**People → Permissions** (`/admin/people/permissions`) and **People → Roles**
(`/admin/people/roles`) to designate moderators, and through moderators' own
submission queues to process content.

## How to use it

1. Make sure your site already uses content moderation for the content you want a
   team to review.
2. Decide which **role** identifies your moderators (create one under **People →
   Roles** if needed).
3. Go to **People → Permissions** (`/admin/people/permissions`) and grant that
   role the permissions provided by Moderation Team.
4. Assign the moderator role to each team member. The module distributes
   submissions across the current set of moderators; each moderator then works
   through their own queue.
5. As your team grows or shrinks, add or remove the moderator role on users — the
   module re-balances the queues so the workload is shared evenly.

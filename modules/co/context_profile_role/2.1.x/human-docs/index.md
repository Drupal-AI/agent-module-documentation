# Context Profile Role — manual setup guide

**Context Profile Role** (`context_profile_role`) adds a new block‑visibility
condition that looks at the roles of the *user whose profile is being viewed*,
rather than the roles of the person doing the viewing. When someone lands on a
user profile page (for example `/user/42`), this condition can check whether that
account — the profile owner — has one of the roles you selected, and show or hide
a block accordingly.

The classic use case is displaying different blocks on profile pages depending on
who the profile belongs to: a "premium member" call‑to‑action only on premium
members' profiles, editor or author bio widgets only on staff profiles, or
admin‑only tools only on admin profiles. Because it reads the profile owner's
account off the route, it works on any route that exposes a `user` parameter, not
just canonical profile pages.

It is important to understand that this is a **display‑time visibility test only**.
It decides whether a block is *shown*; it does not grant, change, or check any
permissions, and it evaluates the profile owner's roles, never the current
viewer's. The module is small — a context provider, a condition plugin, and a
config schema — depends only on core's **User** module, and has no settings page
of its own: you configure it directly on each block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. You use it as a
visibility condition on individual blocks, described in "How to use it" below.

## Where it lives in the admin menu

Context Profile Role adds no admin page of its own. Its condition appears inside
the block configuration form — either the core **Block layout**
(**Structure → Block layout**) when you place or configure a block, or the
condition list of the contributed **Context** module if you use that.

## How to use it

1. Place or edit a block — for example at **Structure → Block layout**
   (`/admin/structure/block`), or through the Context module if you manage
   visibility there.
2. In the block's **Visibility** settings, find the **User Profile Role**
   condition.
3. Tick the roles you want to match. The block will show on a profile page when
   the profile owner has *any* of the roles you selected (any‑of logic). Leaving
   every role unticked matches all profiles.
4. Optionally tick **Negate the condition** to invert the rule — for example, to
   hide the block on profiles that belong to a given role.
5. Save the block. Visibility is cached correctly per route, so the right block
   appears on the right profile.

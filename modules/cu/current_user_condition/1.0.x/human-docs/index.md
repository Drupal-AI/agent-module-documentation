# Current User Profile Condition — manual setup guide

**Current User Profile Condition** (`current_user_condition`) provides a Drupal
**condition plugin** that evaluates against the current authenticated user's own
profile page — the user canonical page (`/user/{id}`). Because it plugs into
Drupal's condition system, it works anywhere conditions are used: block
visibility, and any other component that consumes condition plugins.

In plain terms, it lets you show or apply something **when the logged‑in user is
looking at their own profile page**. A common use is placing a block that should
only appear to a user on their own profile — a "welcome back", an account‑related
shortcut, or profile‑specific content.

It depends on core **User** and works on Drupal 9, 10, and 11. It's a
**display/visibility** feature: it governs *where* things appear based on the user,
not access to content — the content's own access rules still apply. There's **no
settings page of its own**; you configure the condition inline wherever conditions
appear (most commonly a block's visibility settings).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no standalone configuration page** — you use the condition inside other
features' visibility settings, as described in "How to use it" below.

## How to use it

The most common case is block visibility:

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place (or edit) a block.
3. In the block's configuration, open the **Visibility** tab. You'll find the
   condition provided by this module among the visibility conditions.
4. Enable it so the block only shows on the current user's profile page, and save.

The same condition is available to any other feature built on Drupal's condition
plugin system.

# Entity Role View Mode Switcher — manual setup guide

**Entity Role View Mode Switcher** (`entity_role_view_mode_switcher`) renders an
entity in a **different view mode depending on the current user's role**. Editors
might see a full display of a node while anonymous visitors see a trimmed one — all
from the same URL, chosen per entity. A common use is a lightweight paywall: users
with a "premium" role see the full article, while everyone else sees a teased
version.

You set it up by defining **View Mode Switcher Rules** and then attaching them to
entities. A rule describes how the display should switch by role; you reference a
rule from an entity through an entity reference field, and when a visitor views
that entity, the rule may swap the original view mode for the one appropriate to
their role. It works across Drupal 8 through 11 and has no module dependencies.

One expectation to be clear about before you rely on it: this module controls
**presentation, not access**. It changes *which view mode renders*, not what a user
is *allowed* to reach. A role shown a trimmed view mode can still get at the entity
through other routes and displays, so any genuinely sensitive field must be
protected with real field‑ or entity‑access controls — not merely hidden inside a
view mode. Treat this as a display convenience, not a security boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has no central settings form. Setup is a matter of creating rules and
adding a reference field, described below.

## How to use it

1. **Define at least one View Mode Switcher Rule** describing how the display
   should switch by role.
2. **Add an entity reference field** to your content type (or other bundle) that
   references these rules.
3. When you **edit an entity**, select the rule you want to apply to it.
4. Now, whenever a visitor views that entity in the original view mode, the view
   mode may be switched based on their role — for example showing premium members
   the full article and everyone else a teaser.

> **Remember:** this only changes the display. Protect sensitive data with real
> field/entity access, not by hiding it in a view mode.

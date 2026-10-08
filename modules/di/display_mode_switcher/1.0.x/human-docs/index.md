# Display Mode Switcher — manual setup guide

**Display Mode Switcher** (`display_mode_switcher`) shows different field layouts to
different audiences — no templates, no custom code, just configuration. You define
**rules** that say "when this entity is about to render in this view mode, and these
conditions are true, switch it to that other view mode instead." At render time the
module evaluates your rules in weight order, picks the first match, and swaps the
display mode transparently. If nothing matches, the original view mode is used
unchanged.

The classic use case is a **paywall**: anonymous visitors see a teaser or locked
version of an article, while subscribers see the full thing — all by pointing the
same content at a different view mode based on the visitor. But it works for any
scenario where different users or contexts should see a different arrangement of
fields.

It builds on Drupal's condition plugin system, so it works with all the standard
core conditions (user role, node type, language, request path, current theme) and
any conditions contrib modules provide — automatically, with no extra wiring. It
ships a **"User has role"** condition out of the box. Conditions receive the entity
being rendered directly, so field‑level checks (for example "is this node marked as
paywalled?") need no Context API setup. Drupal's render cache is fully respected:
cache tags, contexts, and max‑age from every evaluated condition are merged into the
output. Rules are configuration entities, so they export and deploy like any other
config. A single permission, **administer display mode switcher**, controls rule
management. It requires Drupal 11.3+ and has no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create the target view mode and add
   switcher rules.

## Where it lives in the admin menu

Switcher rules are managed at **Structure → Display modes → View modes → Switcher
rules** (`/admin/structure/display-modes/view/switcher`), gated by the **administer
display mode switcher** permission. See [Configuration](configuration/index.md) for
the full workflow.

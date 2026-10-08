# Animate Fields AOS — manual setup guide

**Animate Fields AOS** (`animate_fields_aos`) adds scroll-triggered entrance animations
to the output of your content fields, using the popular **AOS (Animate On Scroll)**
JavaScript library. As a visitor scrolls a field into view, it can fade, slide, or
otherwise animate into place, giving pages a more dynamic feel.

The animation is purely presentational: it changes how a field is displayed, not the
value stored behind it, and the module has no access-control role. Animation options are
configured per field on the field's display, so you choose exactly which fields animate
and how.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

Once the module is enabled, go to **Structure → Content types → [your type] → Manage
display** (or the equivalent Manage display screen for any entity). For a field you want
to animate, open its display formatter settings and choose the AOS animation options —
the effect (fade, slide, and so on) and its timing. Save the display, then view a node of
that type and scroll the field into view to see the entrance animation.

The module provides its own permissions, so you can restrict who is allowed to configure
field animations.

### Accessibility note

Scroll animations are one of the motion effects most likely to trouble people with
vestibular disorders. Prefer effects that respect the visitor's `prefers-reduced-motion`
setting, and use entrance animations sparingly on public sites.

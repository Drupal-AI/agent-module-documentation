# EcoIndex — manual setup guide

**EcoIndex** (`ecoindex`) helps you measure and report the **environmental impact
of your pages**. It implements the EcoIndex service — an open‑source algorithm
from the French Green IT association — which grades a page from 0 to 100 (and to a
letter grade from G to A) based on its complexity and weight, as a proxy for its
carbon and environmental footprint. The goal is to help content contributors
understand the impact of what they publish and improve their practices toward
more eco‑friendly content.

You use it through a dedicated **ecoindex** field type that displays a page's
EcoIndex score and grade. On the content edit form you click **Refresh EcoIndex
score** to fetch the current score/grade, then save. You can also surface the
score in a **View** so it appears in content listings. Beyond measurement, the
module lets you set a **target EcoIndex score** for your pages: if a page doesn't
reach it, an alert message is shown, and you can even **block publication** until
the score is met.

This is an administration and reporting feature — it's informational and has no
access‑control role beyond its own permission. It has an optional dependency on
the [Diff](https://www.drupal.org/project/diff) module, which lets you compare
EcoIndex scores between content revisions. Note that this is an unofficial module
from the Green IT association, currently a beta release, and supports Drupal 9.4,
10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional Diff module).
2. [Configuration](configuration/index.md) — the EcoIndex settings, including the
   target score and whether to block publication when it isn't reached.

## Where it lives in the admin menu

EcoIndex provides a settings form at the `ecoindex.settings` route, reachable
under **Administration → Configuration**. The scores themselves are shown wherever
you add the **ecoindex** field to a content type's form and display, and
optionally in Views listings.

## How to use it

1. Add an **ecoindex** field to a content type (via **Structure → Content types →
   *(type)* → Manage fields**) and enable it on the form and display.
2. When editing a piece of content, click **Refresh EcoIndex score** to fetch the
   current score and grade, then save the content.
3. Optionally add the EcoIndex field to a View to show scores across a content
   listing.
4. Set a target score and publication behavior on the settings page — see
   [Configuration](configuration/index.md).

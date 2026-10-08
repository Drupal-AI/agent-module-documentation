# OH (Opening Hours) — manual setup guide

**OH** (`oh`) is an alternative opening‑hours / office‑hours solution for Drupal. It
lets you define a location's business opening times, display them, and answer
"open now?"‑style queries in code. It is **API‑first**: a location is just a Drupal
entity (a node, for example), and OH generates opening hours for it — scaling from a
single location up to many thousands.

The distinctive part is how it handles recurring schedules. Instead of a fixed
week‑grid, OH builds on the [Date Recur](https://www.drupal.org/project/date_recur)
module, so you can express regular opening hours *and* exceptions (holidays, special
days) as recurring date rules by adding a Recurring Date field to an entity bundle.
That makes it a good fit when opening times are complex or vary across many
locations.

Opening hours are treated as editor/administrator content — OH has no
access‑control role of its own. It ships several submodules that add pieces on top:

- **`date_recur_oh_field`** — the field integration that turns a Recurring Date field
  into opening hours.
- **`oh_regular`** — regular (weekly) hours support.
- **`oh_review`** — a review/overview of the computed hours.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and its
   Date Recur dependency, and choose the submodules you need.

OH has no central settings form; you set it up per entity bundle by adding a field
and configuring its display, described in "How to use it" below.

## How to use it

1. Enable `oh` and the submodule(s) you need — usually `date_recur_oh_field` for the
   field integration, plus `oh_regular` and/or `oh_review` (see
   [Installation](installation/index.md)).
2. On the entity bundle that represents a location (for example a "Location" content
   type), add a **Recurring Date** field for the opening hours under **Manage
   fields**.
3. Configure how that field is displayed under **Manage display** to render the
   opening times on the entity.
4. Enter each location's regular hours and any exceptions as recurring date rules
   when editing the entity.
5. In custom code, use OH's API to generate the hours for a location and answer
   queries such as whether it is currently open — see the module's documentation for
   the API details.

> **Tip:** because OH is API‑first and built on Date Recur, it rewards a little
> planning of how you model "regular hours" versus "exceptions" up front, especially
> if you have many locations.

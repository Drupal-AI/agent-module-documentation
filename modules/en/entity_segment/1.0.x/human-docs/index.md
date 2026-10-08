# Entity Segment — manual setup guide

**Entity Segment** (`entity_segment`) lets you define named, reusable **segments** —
saved audiences of any content entity type, described by a visual AND/OR tree of
conditions. You describe an audience once, by its rules, and any feature that needs
it asks the resolver and gets the entities that match *right now*. If you have met
CiviCRM's Smart Groups, Mailchimp's Segments, or Constant Contact's Segments, this
is the same idea generalised to the whole Drupal entity system.

What makes a segment generic is its **target entity type**. A segment does not
select contacts, users, or nodes specifically — it selects entities of whichever
content entity type its *segment type* (its bundle) names. The condition‑building
plugins, the resolver, and the IDs that come back are all parameterised by that
target type, so one engine serves every audience: users, nodes, taxonomy terms,
commerce entities, or your own custom entities. The module was created as part of
the Member Platform Initiative to help send emails to Drupal CRM contacts.

You build a segment with a **visual condition builder** — nested AND/OR groups,
each condition shown as a plain‑language summary. The shipped *Field value*
condition compares any field of the target entity with operators appropriate to the
field's data type (string contains/starts‑with, numeric or date greater‑than or
between, and so on), and you can traverse entity reference fields to compare fields
on referenced entities to any depth (an order's customer's country, for example).
Resolution is live — a segment always reflects current data, with no stale
materialised list to rebuild. Segments are revisionable, can be global or personal,
and carry granular per‑segment‑type permissions. It requires **Drupal 11.1+** and
depends on core's **Options**, **User** and **Views** modules plus the contributed
**Entity** (`entity`) module.

A note on exposing an audience safely: a segment's resolved *membership* is more
sensitive than its *definition*, and the raw resolver is deliberately not
access‑filtered. The module funnels reads through a single access chokepoint — use
the viewer‑safe accessible‑resolution path when rendering or exporting an audience
to a user, and reserve the raw resolver for trusted server‑side work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — defining segment types and building
   segments, plus the permissions.

## Where it lives in the admin menu

Segment types are defined under **Structure → Segment types**
(`/admin/structure/segment-type`), and each segment type gets its own listing and
"Add segment" flow. Permissions are under **People → Permissions**.

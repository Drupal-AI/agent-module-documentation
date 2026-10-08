# Paragraphs Sets — manual setup guide

**Paragraphs Sets** (`paragraphs_sets`) lets editors drop a whole pre-configured
group of paragraphs into a Paragraphs field with a single click, instead of adding
each paragraph one at a time. It is ideal for repeatable page patterns — a hero plus
two columns plus a call-to-action, an FAQ block, a "two column with image" starter —
so your team can assemble structured pages quickly and consistently from approved
building blocks.

A *set* is a named, ordered list of paragraphs, each with a paragraph type and
optional default field values. Sets are defined as configuration entities and
managed centrally at **Structure → Paragraphs sets**, which means they export and
deploy with the rest of your site config — you can ship an approved component library
as part of a distribution. When an editor picks a set on a Paragraphs field, its
paragraphs are appended, pre-filled with the set's default data, ready to tweak.

You switch sets on per field via three settings that Paragraphs Sets adds to the
**Paragraphs (stable)** widget: *Enable Paragraphs Sets* turns the set selector on,
*Limit sets to* restricts which sets are offered on that field, and *Default set*
can seed the field's default value with a set. Simple default values work out of the
box; for complex or dynamic defaults, developers can supply data through a handful of
alter hooks. A management UI, gated by the *Administer Paragraphs sets* permission,
covers creating and editing sets. The module depends on the **Paragraphs** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — defining sets and enabling them on a
   Paragraphs field.

## Where it lives in the admin menu

- **Structure → Paragraphs sets** (`/admin/structure/paragraphs_set`) — where you
  create, edit and delete the sets themselves. Gated by the **Administer Paragraphs
  sets** permission.
- **Manage form display** (on any entity with a Paragraphs field) — where you turn
  sets on for a specific field, by opening the cog on the **Paragraphs** widget.

See [Configuration](configuration/index.md) for a walkthrough of both.

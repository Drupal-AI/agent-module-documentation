# Microcontent Revision UI — manual setup guide

**Microcontent Revision UI** (`microcontent_revision_ui`) adds the revision-history
user interface that the [Microcontent](https://www.drupal.org/project/microcontent)
module lacks: a version-history page, the ability to view a specific past revision,
and a revert form to roll a Microcontent item back to an earlier version. It brings
the familiar "Revisions" tab experience to Microcontent entities without patching
the Microcontent module itself.

It works by attaching core's revision route provider and revision-revert form to the
`microcontent` entity type, exposing the routes under
`/admin/content/microcontent/{microcontent}/…`. Each revision operation is gated by
its own dedicated permission — **view any microcontent history**, **view any
microcontent revisions**, **revert any microcontent revisions**, and **delete any
microcontent revisions** — so the revision routes are properly access-controlled with
no anonymous exposure. It depends on the Microcontent module.

> **Important — this module is obsolete.** Its functionality has been folded into the
> Microcontent project itself (see the
> [Microcontent issue #3396780](https://www.drupal.org/project/microcontent/issues/3396780)),
> and this module is marked **Unsupported / Obsolete**. On a current site, prefer the
> revision support built into Microcontent rather than installing this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Microcontent dependency (note the obsolete status above).

There is **no configuration page** — you grant the revision permissions and use the
revision tabs, described in "How to use it".

## Where it lives in the admin menu

The module adds no settings page. The revision UI lives on Microcontent entities
under **Content** (routes at `/admin/content/microcontent/{microcontent}/…`), and
you grant its permissions at **People → Permissions**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — subject to the
   obsolete-status note above.
2. At **People → Permissions**, grant the roles that should manage revisions the
   permissions they need: **view any microcontent history**, **view any microcontent
   revisions**, **revert any microcontent revisions**, and/or **delete any
   microcontent revisions**.
3. Open a Microcontent item. A **Revisions** / version-history view is now available,
   where authorized users can view a past revision or revert to it.

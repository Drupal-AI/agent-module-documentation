# Curated entity block — manual setup guide

**Curated entity block** (`curated_entity_block`) provides blocks in which an
editor **hand‑picks and orders specific existing entities**, and the block renders
them in one chosen view mode (typically a teaser variant). It's built for
editorially‑curated lists — "featured articles", "editor's picks", a hand‑sorted
spotlight — where automatic Views sorting isn't enough and a person needs to
decide exactly what appears and in what order.

A site builder sets the rules with a **View**: the View defines the selectable
pool of entities and the allowed view modes, and can constrain minimum/maximum
counts and allowed steps (e.g. 3‑6‑9). The same block type can then be reused for
many curation scenarios by configuring multiple Views. The blocks work nicely with
**Drupal Canvas**, bringing flexible entity‑reference selection to Canvas pages,
and if the Custom Elements module is installed, picked entities can be rendered
through it.

The module depends on core **Views** and requires **Drupal 10.3+ or 11**. It
carries no access role of its own — rendered entities still respect their own
access, so an editor picking an unpublished node does not expose it to users who
can't see it. There is no central settings page; you configure the pool in Views
and then place and curate blocks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Views dependency.

There is **no single settings page** for this module. Setup happens in Views and
on the block itself, described in "How to use it" below. (See the "Site‑builder
setup" section in the project's README for the full worked example.)

## How to use it

The workflow has two roles — a site builder defines what can be curated, and an
editor does the curating:

1. **Site builder:** create or configure a **View** that defines the pool of
   entities editors may pick from and the view mode(s) they're allowed to render
   in. Here you can also restrict the allowed view modes and set min/max limits
   and allowed steps (for example, "between 3 and 9 items, in steps of 3").
2. **Editor:** place the curated block (through **Structure → Block layout**, or
   on a Drupal Canvas page). In the block's configuration, hand‑pick the specific
   entities you want, drag them into the order you want, and choose the view mode.
3. Save. The block renders exactly those entities, in that order, in the chosen
   view mode — and each entity still obeys its own access rules.

# Entity Reference Field Override — manual setup guide

**Entity Reference Field Override** (`entity_reference_field_override`, shipped by
the `erfo` project) lets you override specific field values on a referenced
entity *per reference instance* — without changing the original entity. The same
shared entity (a block, a media item, a node) can therefore display different
field values in each place that references it, because the overrides are stored
on the reference rather than on the source.

The problem it solves is reuse without duplication. You want to point several
pages at one shared entity but tweak a heading, a caption, or a link on each
one. Copying the entity defeats the point of sharing it; editing the original
changes it everywhere. This module keeps a single source entity and records the
local, per-reference differences alongside the reference — so the source stays
untouched and each placement shows its own variant.

It depends on Drupal core's Field module and provides its own permissions to
control who may set overrides. There is no site-wide settings screen;
overrides are applied per reference instance on the content itself. It supports
Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site-wide configuration page** for this module. Overrides are set
per reference instance where the reference is edited; grant the module's
permissions to the roles that should be allowed to set them.

## Where it lives in the admin menu

The module adds no central admin page. Because it provides its own permissions,
review them at **People → Permissions** (`/admin/people/permissions`) and grant
the override capability to the appropriate roles. The overrides themselves are
edited alongside the reference on the host content.

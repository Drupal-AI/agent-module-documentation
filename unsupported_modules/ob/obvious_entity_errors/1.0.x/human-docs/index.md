# Obvious Entity Errors — manual setup guide

**Obvious Entity Errors** (`obvious_entity_errors`) does exactly what its name
says: it makes it **obvious** when your site has entity data‑integrity problems.
Drupal quietly tracks mismatches between an entity type's definition and the data
or schema actually stored — the kind of thing that shows up as an "entity/field
definitions have changed" warning — but these problems are easy to overlook when
they only surface deep in a status report or a log. This module surfaces those
mismatches prominently in the admin so that site builders notice them and fix the
broken entity definitions or data **before** they cause a failure.

It is a lightweight diagnostics aid for developers and site builders. There is
nothing to configure — once enabled, it simply raises the visibility of entity
integrity issues. It supports Drupal 9, 10, and 11 and ships under the `oee`
project.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. It
starts surfacing entity errors as soon as it is enabled.

## How to use it

There is nothing to switch on beyond enabling the module. Keep it enabled on
development and staging (and optionally production) so that whenever an entity
definition or schema mismatch appears — for example after a module update or a
field change — it is shown clearly instead of hiding in the logs. When you see one
reported, resolve it the usual way: apply the pending entity/field definition
updates or correct the mismatched data, then confirm the warning has cleared.

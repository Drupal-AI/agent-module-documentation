# Entity Admin Handlers — manual setup guide

**Entity Admin Handlers** (`entity_admin_handlers`) is a **developer tool**. It
provides ready-made admin UI plumbing for custom entity types whose structure
doesn't fit the assumptions baked into Drupal core's admin UI code. Normally, giving
a custom entity type a usable "manage fields / manage display" administration
interface means writing a fair amount of boilerplate — route providers, entity
link handlers, and sometimes a controller. This module supplies those handlers so
you don't have to.

It covers two cases that core handles awkwardly. For a **single-bundle entity
type** (an entity type with no separate bundles, much like core's User entity), it
defines a dummy route that Field UI can hang its field-management routes off. For a
**plain bundle entity type** (multiple bundles, but no config entity type defining
those bundles — for example bundles declared in `hook_entity_bundle_info()` or
derived from Entity API's bundle plugins), it defines a route that lists the bundles
plus a dummy route per bundle for Field UI to attach to. In both cases the module
provides a route provider handler, an entity links handler, and a controller where
one is needed.

This is not a click-and-configure module and it has **no settings page**. You use
it by referencing its handlers from your entity type's annotation/definition in
code. It depends on core's **Field UI** module. Note one requirement: to get proper
menu, task, and action links, the module expects the core patch from
[drupal.org issue #2976861](https://www.drupal.org/project/drupal/issues/2976861)
to be applied — the routes themselves work without it, but the links do not.

Because the interfaces it generates expose entity management (viewing, editing,
deleting entities and their fields), access to them is governed by the underlying
**entity access** and administration permissions. The module itself has no
access-control role — make sure the entity types you expose this way are gated by
appropriate permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it is wired up in code by
developers, as described above.

## Where it lives in the admin menu

The module adds no admin page of its own. The admin UIs it enables appear wherever
your custom entity type's routes place them (typically under **Structure**),
alongside the Field UI *Manage fields* and *Manage display* tabs it makes possible.

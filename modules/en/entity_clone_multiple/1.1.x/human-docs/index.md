# Entity Clone Multiple — manual setup guide

**Entity Clone Multiple** (`entity_clone_multiple`) extends entity cloning so an
editor can produce **several copies of an entity at once**, rather than a single
duplicate. It is aimed at time-bounded and batch duplication workflows — for
example creating many short-lived copies of an event or campaign entity spaced out
over time.

The cloning is governed by per-entity-type **"clone settings"**, which the module
stores as configuration entities (so they are exportable with your site config).
Cloning is driven by a date field: the module produces copies at a chosen interval
until a specified end date, where the interval can be any interval PHP's
`DateInterval` supports. It also generates a per-entity-type clone permission, so you
can control which roles may clone which entity types.

You manage the clone settings from an admin UI at **Configuration → Content
authoring → Entity clone** (`/admin/config/content/entity-clone`). Creating and
editing those settings requires the restricted **administer entity clone settings**
permission, and a general settings form requires **administer site configuration**.
All of the module's routes are permission-gated — there are no anonymous-facing or
unauthenticated mutation endpoints. It requires **Drupal 9.4 or 10**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permissions.
2. [Configuration](configuration/index.md) — manage the per-entity-type clone
   settings and the general settings form.

## Where it lives in the admin menu

Clone settings live at **Configuration → Content authoring → Entity clone**
(`/admin/config/content/entity-clone`):

- the list of clone settings at `/admin/config/content/entity-clone`,
- **Add** a setting at `/admin/config/content/entity-clone/add`,
- **General settings** at `/admin/config/content/entity-clone/settings`.

# Entity — manual setup guide

**Entity** (`entity`, the "Entity API" module) is a developer-facing toolkit that
supplies reusable building blocks for custom content entity types — things like
generic permissions, access control, query-level access filtering, code-defined
bundles, a revision UI, and route providers — that a custom entity type would
otherwise have to reimplement by hand. Its tagline is that these are APIs "which
will be moved to Drupal core one day."

This is a **framework module with no UI or settings of its own**. You don't
configure it through the admin interface; instead, developers wire its handlers and
route providers into a custom entity type's definition. Enabling the module simply
makes those APIs available. In practice you'll most often find it installed
automatically as a dependency of larger projects — notably **Drupal Commerce** and
**Profile** — rather than turned on by hand.

What it provides, in plain terms: automatic generation of the full
view/create/update/duplicate/delete permission matrix (with per-bundle and
"own vs any" granularity), a matching access control handler so you don't write
boilerplate access logic, a **Query Access** API that extends that enforcement to
entity queries, Views, and list builders, route/local-task providers that wire up
canonical/add/edit/delete/revision/duplicate pages from an entity's link
templates, a revisionable base class with a revision overview/revert/delete UI, and
**bundle plugins** that let a module define entity bundles and their fields
entirely in code. It has **no dependencies** of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it exposes no settings form
and adds no admin pages. Everything it offers is consumed programmatically by other
modules and custom code.

## Where it lives in the admin menu

Entity adds no admin menu items. The permissions it *generates* for a custom entity
type appear on the standard **People → Permissions** page
(`/admin/people/permissions`) once a module defines an entity type that uses
Entity's permission provider — but the module itself has no landing page.

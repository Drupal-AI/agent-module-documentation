# Entity — manual setup guide

**Entity** (`entity`), sometimes called *Entity API*, supplies a set of reusable,
developer‑facing building blocks for custom content entity types — the kind of
plumbing that Drupal core doesn't yet provide and that you'd otherwise have to
write by hand. Its own description sums it up: these are "expanded entity APIs,
which will be moved to Drupal core one day." If you are building a custom entity
type, or you install a module (such as Drupal Commerce or Profile) that depends
on it, this module is what provides the shared machinery underneath.

Concretely, it gives you: generic permission providers that auto‑generate the
whole view/create/update/duplicate/delete permission matrix (with own/any and
per‑bundle granularity) plus a matching access control handler that enforces
them; a **QueryAccess** API that extends that enforcement to entity queries,
Views, and list builders so users never see rows they shouldn't; route, local
task, and local action providers that wire up canonical, add, edit, delete,
revision, and duplicate pages from your entity's link templates; a
`RevisionableContentEntityBase` base class with a revision overview / revert /
delete UI; **bundle plugins** that let you define an entity's bundles and their
fields entirely in code; and a duplicator service for cloning entities.

This is a **framework module with no UI or configuration of its own**. There is
nothing to set up after enabling it — you consume its handlers and providers by
referencing them in your custom entity type's annotation, and you call its
services and subscribe to its events from code. It requires Drupal 10.1+ or 11
and has no other module dependencies. It does provide permissions, but those are
generated on behalf of *your* entity types rather than shown as a fixed list.

This guide is written for a **human** installing the module. Because everything
of substance here is a developer API, the deep references — access handlers,
query access, bundle plugins, revision routing, and the duplicate event — live in
the sibling [`agent/`](../agent/start.md) docs, which are the terse,
token‑cheap counterpart aimed at an AI coding agent.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Entity has **no configuration page** (`configure` is null) and adds no admin
menu items. It surfaces only indirectly: the permissions it generates for a
custom entity type appear on the standard **People → Permissions**
(`/admin/people/permissions`) page, and the revision, duplicate, and delete pages
it wires up appear on your entity's own routes.

## How to use it

You use Entity from code when defining a custom content entity type:

- **Auto‑generate permissions** — set
  `permission_provider = EntityPermissionProvider` (or
  `UncacheableEntityPermissionProvider` when you need "view own" permissions) in
  your entity annotation to get the full view/create/update/delete matrix without
  writing permission strings by hand.
- **Enforce access** — set `access = EntityAccessControlHandler` so those
  permissions are applied without custom access logic, and use the QueryAccess
  API (and its `QueryAccessEvent`) to filter query, Views, and list‑builder
  results.
- **Wire up routes** — reference the provided route providers
  (`DefaultHtmlRouteProvider`, `AdminHtmlRouteProvider`, `RevisionRouteProvider`,
  `DeleteMultipleRouteProvider`) to generate canonical, add, edit, delete,
  revision, and duplicate pages from your link templates.
- **Add revisions** — extend `RevisionableContentEntityBase` to get correct
  revision URLs and a revision overview / revert / delete UI.
- **Define bundles in code** — implement `BundlePluginInterface` and use
  `BundleFieldDefinition` to declare bundles and their fields programmatically.
- **Duplicate entities** — call the `BundleEntityDuplicator` service (or react
  to `EntityDuplicateEvent`) to clone an entity and its configuration.

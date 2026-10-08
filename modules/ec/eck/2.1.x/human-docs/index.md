# Entity Construction Kit — manual setup guide

**Entity Construction Kit** (`eck`) lets site builders create brand-new
**content entity types** — and the bundles inside them — entirely through the
admin UI, without writing a custom module. If you have ever needed something
that behaves like a node (fieldable, listable in Views, translatable,
referenceable) but *isn't* a node — an "Event", a "Speaker", a "Sponsor", a
"Location" — ECK is the tool for that. Each entity type you define becomes a
real, first-class content entity with its own database tables, Field UI, Views
integration, and permissions.

Under the hood, defining a type in the UI drives Drupal's own
entity-definition-update system to install a genuine content entity type,
complete with its base table, data table, entity keys, routes, and access
handling. You don't see any of that machinery — you just fill in a form. Each
type has a small menu of optional **base fields** you can switch on: a title, an
author/owner, created and changed timestamps, and a published status flag.
Anything beyond that you add as ordinary configurable fields through the standard
Field UI, exactly like you would on a node content type.

Bundles let you have several variants under one type — for example an "Event"
type with "Conference" and "Webinar" bundles, each with its own field set. ECK
also generates fine-grained per-type permissions (create / edit any / edit own /
delete / view) so you can control who does what. Deleting a type cleanly
reverses everything, dropping its tables and cleaning up reference fields.

Because ECK entities are standard content entities, they work out of the box with
Views, tokens, translation, entity reference fields, and exportable
configuration — so you can prototype a data model quickly and then deploy it like
any other config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create entity types and bundles,
   choose base fields, add fields, and manage the permissions ECK generates.

## Where it lives in the admin menu

ECK splits its work across two familiar areas:

- **Structure → Entity Construction Kit** (`/admin/structure/eck`) — where you
  create and manage entity types and their bundles.
- **Content → (your entity type)** (`/admin/content/{type}`) — where editors
  create and manage the actual content entities of a type.

## How to use it

1. Go to **Structure → Entity Construction Kit** and add a new entity type,
   choosing which base fields it should have.
2. Add one or more bundles to the type, then attach fields to each bundle with
   the normal Field UI.
3. Grant the relevant per-type permissions to your roles.
4. Editors then create content under **Content → (your entity type)**.

See [Configuration](configuration/index.md) for the step-by-step detail.

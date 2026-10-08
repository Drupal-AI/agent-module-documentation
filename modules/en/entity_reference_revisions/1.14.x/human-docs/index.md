# Entity Reference Revisions — manual setup guide

**Entity Reference Revisions** (`entity_reference_revisions`), often shortened to
**ERR**, adds a new field type that references a specific *revision* of a target
entity rather than just its current ID. A normal core Entity Reference field stores
only the target's entity ID, so it always resolves to that entity's latest
revision. ERR stores both the target ID **and** a target revision ID, so a host
entity can point at the exact revision of a child that existed when the host was
saved.

The problem this solves is keeping composite, revisionable content in sync. When a
node references child entities through an ERR field and you create a new revision
of the node, ERR creates new revisions of the children too — and rolling the node
back rolls the children back with it. This is exactly what makes revisionable,
non-reusable "composite" entities possible, which is why ERR is the foundation the
**Paragraphs** module is built on. Most sites never add an ERR field by hand; they
get the module as a dependency of Paragraphs.

The module gives you a field type, an autocomplete widget, label and
rendered-entity formatters, and Views and Migrate integration — so once enabled it
works through Drupal's normal Field UI. There is **no module settings page** to
configure. It does add one permission (*Delete orphan revisions*) that gates an
admin cleanup form, described below.

ERR depends on core's **Field** module (enabled automatically). It ships no
submodules. It can optionally integrate with the **Diff** module, so that changes
to referenced revisions show up in entity revision comparisons — install Diff
separately if you want that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

ERR has no central settings page. Instead it surfaces as a field type and a small
set of tools you reach through the normal admin UI:

- **Add the field.** Go to any fieldable entity type's *Manage fields* screen (for
  example **Structure → Content types → [your type] → Manage fields**) and add a
  field of type **Entity reference revisions**. Because it extends core's entity
  reference, you configure the target entity type, allowed bundles, and sort order
  just as you would for a normal reference field.

- **Choose a widget.** On **Manage form display**, the field uses the *Entity
  reference revisions autocomplete* widget: you type to find the referenced entity,
  and on save ERR records the current revision ID alongside the target ID.

- **Choose a formatter.** On **Manage display**, pick either *Rendered entity*
  (renders the referenced revision in a view mode you choose) or *Label* (shows the
  target's label, optionally linked).

- **List references in Views.** ERR adds Views row, style, and display plugins so
  you can list referenced revisions in a View.

- **Clean up orphans.** When a parent stops referencing a child, that child
  revision becomes an "orphan." Users with the **Delete orphan revisions**
  permission can remove them through the module's orphan-deletion admin form, and
  developers can run the same cleanup from the command line with
  `drush err:purge` (alias `errp`).

The deeper building blocks — the field-item API, the "needs save" interface for
composite children, and the Migrate destination — are developer concerns covered
in the sibling [`agent/`](../agent/start.md) docs.

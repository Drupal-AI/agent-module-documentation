# Entity Bundle Field — manual setup guide

**Entity Bundle Field** (`entity_bundle_field`) is a lightweight module that
provides a new field type — **Entity Bundle Reference** — for referencing a
**content type or vocabulary** (that is, an entity *bundle*) from a field. Rather
than referencing an individual node or term, the field lets you store a reference to
a bundle itself.

The problem it solves is a narrow one: sometimes you need to render the identity of
a content type or vocabulary on screen, or send that value to the front end of a
decoupled Drupal site. This simple field type gives you a clean way to store and
expose that bundle reference. It has no content or access-control role — it is a
site-building and developer aid for working with bundle-level references.

There are no dependencies beyond Drupal core, and there is no central settings page.
You configure it, like any field, on the entity where you add it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Setup happens on the field you
add, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it through the standard **Field UI** when
adding fields to an entity (for example **Structure → Content types → *(type)* →
Manage fields**).

## How to use it

1. On the entity you want to add the field to (a node, taxonomy term, and so on), go
   to **Manage fields → Add field**.
2. Choose the **Entity Bundle Reference** field type.
3. Configure which entity type's bundles the field will offer (for example content
   types, or vocabularies).
4. Save the field. When you create or edit content of that entity, you can now
   reference the bundle you configured, and its value is available for rendering or
   for a decoupled front end.

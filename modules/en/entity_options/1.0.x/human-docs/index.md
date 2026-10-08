# Entity Options — manual setup guide

**Entity Options** (`entity_options`) is a **developer API** for defining and using
third-party **options** on entities through Drupal's Plugin system. Rather than
adding fields to an entity just to carry a few extra settings, a developer defines
those settings as **plugins**, and Entity Options takes care of the rest: it builds
the form interface, places the options on the relevant entity or entity-type edit
pages, and stores and retrieves their values. At runtime the values are attached to
the entity automatically and are available as `$entity->entity_options`.

The options can be as simple as an on/off **flag** or as rich as a **multi-field**
group, so it scales from a single toggle to a small structured settings set. It's
meant as a foundation other modules build on to attach configurable options to
content without each one reinventing the form-and-storage plumbing.

Two things to note. First, at the time of writing **only the Node entity is
supported**. Second, it depends on the **FormAlter as Plugin** (`pluginformalter`)
module, which supplies the form-alter mechanism it uses. Entity Options runs on
Drupal 10 and 11, provides its own permissions, and — being a developer API — has
no content or access role of its own beyond the options it helps define. Note that
it is an **alpha** release and is **not** covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its FormAlter as
   Plugin dependency, then enable it.

There is **no standalone settings form** — options are defined in code as plugins,
and the module then renders them on the relevant entity edit pages, as described in
"How to use it" below.

## Where it lives in the admin menu

Entity Options adds no page of its own. The options a developer defines appear on
the **entity or entity-type edit pages** they target (currently nodes), and the
module provides permissions to control access.

## How to use it

1. In a custom module, define your options as an Entity Options **plugin** —
   choosing a simple flag or a multi-field option set.
2. The API renders the option form on the relevant node (entity) or node-type edit
   pages and stores the submitted values.
3. Read the values in code from `$entity->entity_options`.
4. Grant the module's permissions to the appropriate roles.

# Entity Hierarchy Group Support — manual setup guide

**Entity Hierarchy Group Support** (`entity_hierarchy_group`) is a small bridge
module that teaches [Entity Hierarchy](https://www.drupal.org/project/entity_hierarchy)
to play nicely with the [Group](https://www.drupal.org/project/group) module. If
you build tree‑structured content with Entity Hierarchy *and* organize that
content into groups, this module aligns the two so hierarchies respect the group
each piece of content belongs to.

Concretely, it adds a few group‑aware options to Entity Hierarchy's parent
reference: you can restrict the choice of parent entities to the current group
context, restrict selection of parents *outside* the group context when you are
not inside a group, and allow only one similar hierarchy per group. The result is
that editors building hierarchies inside a group can't accidentally reach across
into another group's tree.

This is an integration layer with no page of its own — it depends on both
**Entity Hierarchy** (5.x / the Entity Reference Hierarchy field) and **Group**
(3.x), and its behavior surfaces on the entity‑reference‑hierarchy field settings
where you tune the group restrictions. After enabling it, review your Entity
Hierarchy field settings to switch on the group options you want.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Entity Hierarchy and Group.

There is no dedicated settings page for this module. Its group options appear on
the Entity Reference Hierarchy field's own settings once the module is enabled —
see "How to use it" below.

## How to use it

1. Make sure both **Entity Hierarchy** and **Group** are installed and that you
   already have an Entity Reference Hierarchy field on the entities you organize
   into groups.
2. Enable this module (see [Installation](installation/index.md)).
3. Edit the Entity Reference Hierarchy field's settings and turn on the group
   restrictions you want — limit parent selection to the current group context,
   forbid parents outside a group when you are not in one, and/or allow only one
   similar hierarchy per group.
4. Save the field settings. From then on, parent selection in that field honors
   the group boundaries you chose.

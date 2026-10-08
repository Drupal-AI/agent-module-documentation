# Group Computed Field — manual setup guide

**Group Computed Field** (`group_computed_field`) adds a **computed field** on
entities that can be related to Groups, exposing the group(s) an entity belongs to
as a field value. On a site built with the
[Group](https://www.drupal.org/project/group) module, this lets content surface its
owning group(s) — computed at runtime from Group's relationships — so that group
membership becomes something you can display, filter, and index like any other
field.

The main reason to use it is **Search API**: because the group relationship is
exposed as a field, entities can be indexed by their groups and then filtered by
group in search indexes and Views. It is equally useful anywhere you simply want
to show which group(s) a piece of content belongs to.

The field is **computed** — it reflects the entity's existing group memberships
and is not stored or edited directly. Importantly, it does **not** grant or change
access: Group's own access controls still govern who can see what. This field only
*reports* the relationships that already exist.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.

There is **no settings form** for this module (`configure` is null). The computed
field becomes available on relatable entities once the module is enabled; you use
it from **Manage display**, Views, and your Search API index configuration, as
described under "How to use it" below.

## Where it lives in the admin menu

Group Computed Field adds no admin page of its own. You work with the computed
field through **Structure → Content types → *(type)* → Manage display** (to show
it), through the **Views** UI (to filter or display by group), and through your
**Search API** index configuration (to index entities by their groups).

## How to use it

1. Make sure the entities you care about are relatable to groups via the Group
   module (a group content / group relationship plugin is enabled for them).
2. The computed group field is then available on those entities. Add it to a
   display via **Manage display** if you want it shown.
3. In **Views**, use the field to display or filter content by the group(s) it
   belongs to.
4. For search, add the field to your **Search API** index so content can be
   filtered and faceted by group.

Remember this field is informational — it reflects group membership but does not
itself control access. Keep relying on Group's permissions for that.

# Views Entity Reference Filter — manual setup guide

**Views Entity Reference Filter** (`verf`) makes entity-reference fields much friendlier
to filter on in Views. Out of the box, Views only lets you filter a reference field by
its numeric entity ID — not something you'd ever expose to a visitor. VERF adds a
companion filter that presents the referenced entities by their **labels** in a
select or checkbox list instead, so both site builders and end users pick items by name.

Enable the module and, in the Views UI, every entity-reference field gains a matching
**"(VERF selector)"** filter. Add that filter to a view and its value control becomes a
list of entity labels — category names, author names, tag titles, product names,
whatever the field points at — rather than raw IDs. It respects content-language
translations (showing the label in the current language) and access control (an entity
the user can't view its label for shows as "- Restricted access -" rather than leaking
its name), and it sorts the options in natural, case-insensitive order.

Two handler options let you fine-tune it: restrict the selectable options to specific
**bundles** of the target type, and optionally **ignore access control** to include
unpublished or restricted entities. It works with both configurable reference fields and
base fields (such as a node's author), emits proper cache metadata, and — via a small
alter hook — lets other modules add or remove entities from the option list.

VERF has **no configuration screen, no permissions, and no Drush commands**. Its only
dependency is core's **Views** module. You set everything up inside the Views UI.

This guide is written for a **human** building views in the admin UI. If you want
terse, token-cheap references for an AI coding agent — the `verf` filter plugin and the
option-list alter hook — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it; that's
   the whole setup.

## How to use it

There's nothing to configure globally — just enable the module and use the new filter in
any view:

1. **Edit a view** whose base entity has an entity-reference field. (To filter on a
   *referenced* entity's own fields, add an entity-reference relationship first.)
2. Under **Filter criteria**, click **Add** and search for your field's label followed
   by **"(VERF selector)"**. Add it.
3. Configure the filter as usual — expose it to visitors, set its label and operator.
   The value control is now a **list of entity labels**, not IDs. Use a checkbox list
   with the "is one of" operator to let users filter by several referenced items at
   once.

### Filter options

When you configure the VERF filter, two extra options appear:

- **Target entity bundles to filter by** — shown only when the referenced type has
  bundles. Tick the bundles whose entities should appear in the list (for example, only
  *Article* and *Page* nodes). Leave all unticked to include every bundle.
- **Ignore access control** — off by default, so only entities the current user may
  view are listed. Turn it on to include unpublished or access-restricted entities
  (useful for curation/admin-facing views).

Developers can add virtual entities to, or remove specific entities from, a VERF
filter's option list with a single alter hook — see the [`agent/`](../agent/start.md)
docs.

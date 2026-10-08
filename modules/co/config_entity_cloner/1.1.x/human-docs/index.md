# Config Entity Cloner — manual setup guide

**Config Entity Cloner** (`config_entity_cloner`) adds a **clone** action to every
configuration entity on your site — views, content types, image styles, field
configs, and so on. Instead of recreating a similar config entity from scratch,
you clone an existing one as a starting point and adjust it. It's a site-building
and developer convenience: the clone button appears in each config entity's
operations list, and clicking it opens a clone form that duplicates the entity.

Cloning isn't a shallow copy of a single record. The module runs the new entity
through a **succession of clone processes**, each responsible for a type of related
configuration — fields, form display, view display, translations, and Simple
Sitemap settings. Some of those won't apply to every entity type, which is fine:
the module only duplicates configuration that actually exists, so it never
fabricates settings an entity type doesn't have. Developers can extend the system
with their own **process** plugins (add a new kind of thing to duplicate) or
**processor** plugins (restrict which processes run for a given entity type),
generated with `drush generate config-entity-cloner-process` and
`drush generate config-entity-cloner-processor`.

The module requires no modules outside Drupal core, provides its own permissions,
and provides Drush commands. Because cloning **creates new configuration**, keep
the clone permission with trusted site builders and review each clone afterwards —
a cloned config entity may carry over references or settings that need adjusting
for its new purpose. It operates entirely in the configuration layer and has no
runtime access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings form** for this module — you use it directly from
each config entity's operations list, described below.

## Where it lives in the admin menu

Config Entity Cloner adds no admin page of its own. Instead it adds a **Clone**
link to the operations (the dropdown of actions) beside each item on any
configuration entity listing — for example the Views list, the content types list,
or the image styles list.

## How to use it

1. Go to any configuration entity list, such as **Structure → Content types** or
   **Configuration → Media → Image styles**.
2. Open the **operations** dropdown for the item you want to duplicate and choose
   **Clone**.
3. On the clone form, confirm the duplication. The module runs its clone processes
   and creates the new config entity (copying fields, displays, translations, and
   Simple Sitemap config where they exist).
4. Open the new entity and adjust its label, machine name, and any settings that
   should differ from the original.

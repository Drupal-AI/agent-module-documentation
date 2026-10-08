# Menu Entity Index — manual setup guide

**Menu Entity Index** (`menu_entity_index`) builds and maintains a behind-the-scenes
database index of which menu links point at which entities, so you can instantly
answer the question "what menus link to this node (or term, or…)?" — without
scanning every menu by hand. It's invaluable for content governance: before you
delete, unpublish, or change the URL of a piece of content, you can see exactly
which navigation links reference it.

You choose which **menus** and which **entity types** to track on a settings form.
Saving kicks off a background scan that fills the index, and from then on the module
keeps it current automatically as menu links and content are added, edited, or
deleted — no cron job required. The index records rich detail per link: the menu,
the level (top-level vs nested), the host link and its parent, the target entity,
and language codes for multilingual sites.

Two things surface the data for you. A **"Menu Links"** field can be switched on per
content type (on *Manage form display*) that shows editors, right on an entity's
edit form, a "Referenced by N menu links" table. And there's **Views integration**
for Menu Link Content — extra fields, filters (by menu, by referenced entity type),
and a menu argument default — so you can build reports and listings. A Drush command
rebuilds the index on demand, and two permissions gate the settings form and the
edit-form field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which menus and entity types to
   track, enable the edit-form field, set the permissions, and rebuild the index.

## Where it lives in the admin menu

The settings form sits at **Configuration → Search and metadata → Menu Entity
Index** (`/admin/config/search/menu_entity_index`). Opening it requires the
**Administer Menu Entity Index settings** permission.

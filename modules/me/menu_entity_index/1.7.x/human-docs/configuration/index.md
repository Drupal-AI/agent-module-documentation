# Configuration

Out of the box Menu Entity Index tracks nothing. You tell it which menus and entity
types to watch, and it builds and maintains the index from there.

## Choose what to track

1. Log in as a user with the **Administer Menu Entity Index settings** permission.
2. Go to **Configuration → Search and metadata → Menu Entity Index**, or navigate
   directly to `/admin/config/search/menu_entity_index`.
3. Select:
   - **Entity types** — the content entity types whose references you want to track
     (for example *Content* and *Taxonomy term*). Only entity types with a
     canonical/edit route are offered.
   - **Menus** — the specific menus to track (for example *Main navigation* and
     *Footer*). Only menus that can hold `menu_link_content` links are offered.
   - **Track all menus** — an all-in-one option that tracks every menu, ignoring the
     specific menu list above.
4. **Save**. Saving triggers a **batch rescan** of the selected menus that fills the
   index. After that first scan, the module keeps the index current automatically as
   links and content change — no cron needed.

If you later remove a menu or entity type from the selection, its index rows are
deleted; adding one triggers a rescan of just that addition.

## Show "Menu Links" on the edit form

The module can display, on an entity's edit form, a collapsible **"Referenced by N
menu links"** table listing every menu link that points at it. This field is hidden
by default; enable it per content type:

1. Go to the bundle's **Manage form display** page (for example *Structure →
   Content types → Article → Manage form display*).
2. Find the **Menu Links** field in the *Disabled* region and drag it up into the
   visible area, then **Save**.

Editors then see the table (menu, level, label, language) on that type's edit form —
provided they also have the permission below.

## Permissions

Menu Entity Index defines two permissions (at **People → Permissions**):

| Permission | Controls |
|------------|----------|
| **Administer Menu Entity Index settings** (`administer menu_entity_index`) | Access to the settings form. Restricted. |
| **View entity edit form field** (`view menu_entity_index form field`) | Whether a user sees the "Menu Links" table on edit forms. |

## Rebuilding the index from Drush

Normal editing keeps the index up to date automatically, so you rarely need this.
But after a bulk import of menu links, a change to what you track, or if you suspect
the index has drifted, rebuild it:

```bash
# Rebuild for ALL tracked menus:
drush menu-entity-index:rebuild-index
drush mei-r                          # short alias

# Rebuild a single tracked menu:
drush mei-r main
```

The command errors if you name a menu that is not in the tracked list, or if
nothing is configured for tracking.

## Using the index in Views (for site builders)

The module adds Views data for Menu Link Content: **fields** for the menu and the
target entity type, **filters** to narrow by menu or by referenced entity type, and
a menu **argument default**. Use these to build reports such as "all menu links in
the main menu that point at nodes." See the [`agent/`](../agent/start.md) docs for
the Tracker service, the index table columns, and querying it directly.

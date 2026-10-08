# Configuration

Configuring Content Autogrid has two parts: choosing which entity types get a grid,
and granting the permission that lets people view the grids. Access is enforced at
both steps — one permission to configure, another to view — so nothing is exposed
by accident.

## Choose which entity types get a grid

1. Log in as a user with the **Administer autogrid settings**
   (`administer autogrid settings`) permission — an administrator by default.
2. Go to **Configuration → Content authoring → Content Autogrid**, or navigate
   directly to `/admin/config/content/autogrid/settings`.
3. Tick the entity types that should have an auto‑generated grid, and click **Save**.
   For bundled entity types (content types, taxonomy vocabularies, media types, and
   so on) the grid is attached at the bundle level.

## Where the grid appears

For each entity type you enable, the module adds a **grid** tab to that type's
management pages. It hangs the tab off the type's edit‑form link (falling back to
the canonical link) — so, for example, a node type gets a grid at
`…/manage/<type>/grid`. The tab shows up alongside the other Field UI tabs
(*Manage fields*, *Manage display*, and so on).

## What the grid shows

- One **column per field**, taken from the bundle's field definitions, with each
  cell rendered using the field's configured display formatter (default view mode,
  labels hidden).
- An **ID** column and an **Operations** column (edit/delete links).
- **Sortable** column headers and a standard core **pager** for large result sets.

Use **Field UI** on the bundle's *Manage display* screen if you want to influence
how individual field values render inside the grid.

## Grant the viewing permission

The grids are protected by their own permission, separate from the settings form:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **View autogrid** (`view autogrid`) to the roles that should be able to
   open the grid tabs.
3. Save permissions.

Both permissions are marked as *restricted access*, meaning Drupal warns you they
are security‑sensitive. Grant **Administer autogrid settings** only to trusted
administrators who should decide which types have grids, and **View autogrid** to
the editors who need the overview.

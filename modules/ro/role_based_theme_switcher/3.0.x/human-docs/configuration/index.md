# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Role Based Theme Switcher → Settings**, or
   navigate directly to
   `/admin/config/system/role_based_theme_switcher/settings`.

## The per-role theme table

The form shows a drag-and-drop table with **one row per user role** on your site.
Each row has:

- **Select Theme** — a dropdown of every installed theme. Choose the theme that
  members of this role should see. Leave it unset (empty) to give this role **no
  override**, so it falls back to the site's normal default theme.
- **Weight** — a numeric weight, also controlled by dragging the row up or down.
  This only matters for users who belong to more than one role (see below).

> **Pick real themes.** The form ships with hard-coded example rows that mention
> `seven` and `bartik`. Those themes do not exist on Drupal 10/11, so always select
> a theme that is actually installed on your site.

Each weight value must be unique — the form rejects the save if two rows share the
same weight.

## How multiple roles are resolved

When a user has several roles that each map to a theme, the module picks the
role with the **highest weight** — which, in the drag-and-drop table, is the row
dragged **furthest down**. So arrange the table so that the role whose theme should
win for multi-role users sits at the bottom.

Example: if "Editor" is below "Authenticated" in the table, an editor (who is also
authenticated) gets the Editor theme.

## What happens on admin pages

On administration routes, the module deliberately **steps aside** for any user who
has the **View the administration theme** permission — those users keep seeing
Drupal's configured admin theme while working in the back end. On all other routes
(and on admin routes for users who lack that permission), the role-based theme is
applied. This keeps the standard admin experience intact while still theming the
front end per role.

## Save

Click **Save configuration**. The module runs a full cache flush on save, so the
new theme assignments take effect right away — including for anonymous visitors
served from the page cache.

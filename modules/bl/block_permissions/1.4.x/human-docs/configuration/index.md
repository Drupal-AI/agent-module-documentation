# Configuration

Block Permissions has no settings form — you configure it entirely by granting
permissions on **People → Permissions** (`/admin/people/permissions`). This page
explains the two permission families, how they combine, and the one gotcha that
trips everyone up.

## The two permission families

The module generates permissions automatically, so what you see depends on which
themes and modules are installed on your site.

### Per theme — "Administer block settings for the theme …"

For every enabled, visible theme you get one permission, for example:

- **Administer block settings for the theme Olivero**
- **Administer block settings for the theme Claro**

This controls whether a role can open and manage the **Block layout** page *for that
theme*. Grant a role the Olivero permission and it can manage the front-end theme's
blocks; withhold the Claro (admin theme) permission and it can't touch the admin
theme's block layout.

### Per provider — "Manage blocks provided by …"

For every source of block plugins you get one permission, for example:

- **Manage blocks provided by Custom block** (`block_content`)
- **Manage blocks provided by Views**
- **Manage blocks provided by System**

This controls which *families* of blocks a role may place, edit, or delete. Give a
marketing role only "Manage blocks provided by Custom block" and it can place your
custom blocks but not, say, the "Powered by Drupal" system block or a Views block.

## How the permissions combine

Because these permissions are layered on top of core's **Administer blocks**, a user
needs the core permission *plus* the relevant new ones. Here's what each action
requires:

| Action | Permissions needed |
|--------|--------------------|
| Open Block layout for the **default** theme (`/admin/structure/block`) | The theme permission for your default theme |
| Open Block layout for a specific theme | The theme permission for *that* theme |
| Open the "Place block" library for a theme | The theme permission for that theme (rows are then filtered by provider) |
| Add a block to a theme | The provider permission for that block **and** the theme permission for that theme |
| Edit or delete an existing block | The provider permission for that block |
| Drag/reorder a row on Block layout | The provider permission for that block — otherwise the row is frozen in place |

Remember that core's **Administer blocks** is still checked on top of all of these,
so every role that manages blocks needs it as a baseline.

## The common gotcha — a 403 on Block layout

The single most frequent surprise: a role has **Administer blocks** and a *provider*
permission (say, "Manage blocks provided by Custom block") but still gets a **403**
on `/admin/structure/block`. The reason is that opening the Block layout page is
gated by the **default theme's** permission, not by any provider permission. The
fix is to also grant **Administer block settings for the theme *(your default
theme)***.

## A worked example — a site editor for the front end

To let a `site_editor` role manage custom blocks on the Olivero front-end theme,
without touching the admin theme:

1. Go to **People → Permissions**.
2. Tick, for the Site editor role:
   - **Administer blocks** (core baseline)
   - **Administer block settings for the theme Olivero**
   - **Manage blocks provided by Custom block**
3. Leave the admin-theme permission and other providers unticked.
4. Save permissions.

The same, from the command line:

```bash
drush role:perm:add site_editor 'administer blocks'
drush role:perm:add site_editor 'administer block settings for theme olivero'
drush role:perm:add site_editor 'administer blocks provided by block_content'
```

Now that role can open Olivero's Block layout, place and edit custom blocks there,
and sees only placeable blocks in the "Place block" library — while system blocks
and the admin theme stay read-only or out of reach.

## What the editor experiences

With a partial grant, the Block layout page stays usable but safe: blocks the role
can't manage still appear in the list, but their rows are frozen — no drag handle,
no region selector, no operations links — so nothing can be accidentally moved or
removed. The "Place block" modal only lists blocks the role is actually allowed to
add.

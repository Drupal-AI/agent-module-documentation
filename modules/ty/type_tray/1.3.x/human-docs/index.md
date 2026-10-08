# Type Tray — manual setup guide

**Type Tray** (`type_tray`) replaces Drupal's plain **Add content** list (the bare
`/node/add` page) with a friendly, illustrated "tray": your content types organised
into categories, each with an icon, a thumbnail, a rich description, a sort order,
and a per-user favorites list. On a site with many content types it turns a
confusing wall of links into a self-documenting page where authors can quickly find
the right type to create.

You define the categories once, globally, on the module's settings page — for
example "Editorial", "Marketing", and "Landing pages". Then, on each content type's
edit form, a **Type Tray** tab lets you assign that type to a category and give it an
icon, a thumbnail image, an extended (formatted) description, an ordering weight, and
the text of a handy "View existing … content" link. The page offers two layouts a
visitor can switch between — a compact **grid** (icon + short description) and a
roomier **list** (thumbnail + the full extended description). Logged-in editors can
star the types they use most, which float to the top in a personal *Favorites* group.

Type Tray respects Drupal's normal access rules: a content type a user isn't allowed
to create never appears on their tray. It replaces the controller behind the
existing `/node/add` route, so there's no new URL to remember. It depends on core's
**Node** and **Filter** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — defining categories, styling each
   content type, layouts, favorites, and the permission that gates the settings.

## Where it lives in the admin menu

- The tray itself is the standard **Content → Add content** page (`/node/add`).
- Global settings live at **Configuration → Content authoring → Type Tray Settings**
  (`/admin/config/content/type-tray/settings`).
- Per-type settings are a **Type Tray** tab on each content type's edit form
  (**Structure → Content types → *(type)* → Edit**).

## How to use it

After enabling the module, define at least one category on the settings page, then
open each content type and assign it to a category (adding an icon, thumbnail, and
description as you like). Visit `/node/add` and you'll see your types grouped and
illustrated. Full step-by-step details are in
[Configuration](configuration/index.md).

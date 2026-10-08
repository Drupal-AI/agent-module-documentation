# Configuration

Simple Mega Menu has no single settings form. Setting it up is a short workflow:
create a mega-menu **type** and point it at a menu, add **fields** to that type,
create the mega-menu **entities**, then **attach** an entity to a menu link. This
page walks through each step.

## 1. Create a mega-menu type and target a menu

A mega-menu type is a bundle, managed much like a content type.

1. Go to **Structure → Simple mega menu type**
   (`/admin/structure/simple_mega_menu_type`) and click **Add Simple mega menu
   type**.
2. Give it a label (for example "Mega menu" or "Products").
3. Set its **target menus** — the list of menus this type applies to. This is the
   key setting: the mega-menu autocomplete will only appear on links that belong to
   a targeted menu (for example your Main navigation).
4. Save.

Managing types uses core's **Administer site configuration** permission.

## 2. Add fields and arrange the display

Because a mega-menu type is fieldable, it exposes the usual **Manage fields**,
**Manage form display**, and **Manage display** tabs. Add whatever fields your
panel needs — link fields for the columns of links, an image or media field for a
banner, text fields for headings — exactly as you would on a content type.

The module ships two extra view modes for mega-menu entities, **before** and
**after**, which the default template renders in different positions. You can add
your own view modes for custom layouts.

## 3. Create mega-menu entities

Create the actual content at **Content → Simple mega menu**
(`/admin/content/simple_mega_menu`) — click **Add** and choose your type, then fill
in the fields. These entities are revisionable and translatable, and can be
published or unpublished. You can reuse one entity across several menu links.

## 4. Attach a mega menu to a menu link

1. Edit a menu link in one of your targeted menus (under **Structure → Menus**).
   The link must be a **menu link content** item — the module deliberately does not
   support module-defined menu links, because core does not let those store the
   needed options.
2. The link's edit form now has a **Simple Mega Menu** autocomplete, listing the
   mega-menu entities whose type targets this menu. Select one.
3. Save. (Clearing the field later detaches the mega menu.)

Attaching is governed by core's menu permissions (**Administer menus and menu
links**), since the control lives on the menu link form.

## 5. Theme the output

Your theme renders the panel using the module's default
`menu--simple-megamenu.html.twig` template, which you can override, and the two
Twig helper functions `has_megamenu(url)` and `view_megamenu(url, view_mode)` for
rendering an attached mega menu wherever you need it. See the
[`agent/`](../agent/start.md) docs for the theming hooks and function signatures.

## Permissions

The module provides a full set of permissions for controlling who can work with
mega-menu entities. Grant them at **People → Permissions**
(`/admin/people/permissions`):

- **Administer simple mega menu entities** — full administrative control
  (restricted; grant with care).
- **Add / Edit / Delete simple mega menu entities** — the individual create, edit,
  and delete rights, for delegating to content authors.
- **Access simple mega menu overview** — see the admin listing at
  `/admin/content/simple_mega_menu`.
- **View published / View unpublished simple mega menu entities** — control who can
  see published versus unpublished mega menus.
- **Access simple mega menu entities canonical page** — access an entity's own
  page.
- **View all / Revert all / Delete all simple mega menu revisions** — manage the
  revision history (revert and delete also require the matching view/edit/delete
  rights).

Note that managing the mega-menu **types** (bundles) uses core's Administer site
configuration permission, and attaching a mega menu to a link uses core's menu
permissions.

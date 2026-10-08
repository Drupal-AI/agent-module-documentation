<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Add Content Page overrides `/node/add` so the list of content types becomes an editable menu that can be ordered, grouped, described and pruned.

---

Core's `/node/add` lists every content type a user may create, alphabetically, each with its description. On a site with two or three types that is fine; on a site with twenty-five it is a wall, and the handful editors actually use are lost among migration types, legacy types and team-specific types that carry the same visual weight.

This module replaces that page. On install it creates a menu called *Custom add content page* (machine name `custom-add-content-page`) and populates it with one link per existing content type (`internal:/node/add/<type>`). From then on the menu is edited like any other Drupal menu — reorder links, nest them under headings, rewrite the titles, and remove the ones you do not want shown. The overridden `/node/add` page renders that menu instead of the core list. A configuration form lets you pick the renderer: Drupal's core menu renderer, or the module's own Twig template (`custom-add-content-page-add.html.twig`, overridable from your theme), which is the default. When a content type is added or deleted through the admin UI, the module keeps the menu in sync automatically.

One distinction matters and the module does not blur it: **ordering or hiding a link is presentation, not permission.** Removing a type from the menu does not stop anyone from creating it — `/node/add/<type>` still works for whoever holds the create permission. If a role genuinely should not create a type, that is a permissions change; this module is a usability layer on top of permissions, not a replacement for them. The menu tree is still access-checked at render, so a link to a type the current user cannot create is not shown to them.

Used well it is a small change with a real editorial effect: content lands in the right type more often when the right type is obvious.

---

- Reorder the add-content list so common types appear first.
- Group content types under non-linking headings by team or purpose.
- Hide rarely used or migration-only types from the add page.
- Rewrite link titles to say when to use a type, not just its name.
- Reduce a wall of twenty-plus content types to a scannable menu.
- Improve which content type editors choose.
- Onboard new editors faster with a curated creation menu.
- Keep the add page in sync automatically as content types come and go.
- Choose the core menu renderer for standard menu markup.
- Choose the module's custom Twig renderer for a themeable `admin-list`.
- Override `custom-add-content-page-add.html.twig` in your theme to restyle the page.
- Nest creation links into a hierarchy that mirrors your editorial workflow.
- Add unlinkable / separator entries with the Special Menu Items module.
- Show or hide individual links by role with Menu Item Visibility.
- Rely on the menu tree's access check so users only see types they can create.
- Recognise that hiding a link is a usability choice, not an access restriction.
- Use core permissions when a type must genuinely be off-limits to a role.
- Keep `/node/add/<type>` working for anyone who holds the create permission.
- Document the site's add-content menu as part of an editorial style guide.
- Audit which content types are actually offered to editors.
- Retire a legacy content type from the menu without deleting the type.
- Review the menu after adding content types via a migration or feature.
- Configure the renderer at Configuration → User Interface → Custom Add Content.
- Restore the standard page simply by uninstalling the module.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OG Menu gives each Organic Group its own menu — a menu that lives as a content entity attached to the group, so group content types can carry navigation without touching Drupal's global site menus.

---

Organic Groups turns one Drupal site into many small sites — a department, a project, a club — each with its own members, roles and content. The gap it leaves is navigation: core menus are global config, and `administer menu` is a site-wide permission you cannot hand to a group lead. OG Menu closes this by defining two entity types. `ogmenu` is a config bundle (created by an admin at `admin/structure/menu/ogmenu/add`); `ogmenu_instance` is a **content** entity — one instance per group per `ogmenu`, referencing its group through OG's audience field. Behind the scenes each instance drives a real Drupal menu named `ogmenu-{instance_id}`, and its links are ordinary `menu_link_content` entities, so link add/edit/reorder/delete reuse core's menu UI wholesale (a duplicated menu-overview table on the instance edit form). Version **2.0.0-alpha4**, core `^10 || ^11`, requiring `menu_ui` and `og` (Composer requires `drupal/og:^1.0 || ^2.0`). When `og_menu.settings:autocreate` is on, a group's instance is created automatically on group insert; the module also cleans up instances on group delete (unless OG's own orphan handling is active). Two blocks are derived per `ogmenu`, context-aware on the active group via `OgContext`, and a settings toggle lives at `admin/config/group/og_menu`. Read the access model carefully rather than trusting its shape: routes do use `_entity_access`, but the `ogmenu_instance` access handler resolves those checks against **global** site-wide permissions (`view/edit/delete og menu instance entities`), not against OG group membership — only the *add-link* operation actually consults the group's OG role. This is an **alpha** and self-describes as feature-incomplete (several `@todo`s in access code); OG itself has had a long, interrupted road to Drupal 10/11, so verify the OG release you build against.

---

- Give each Organic Group its own editable menu.
- Delegate a group's navigation to that group without granting `administer menu` site-wide.
- Build per-department navigation on an intranet where each department is a group.
- Give a project workspace group its own link structure.
- Auto-create a menu for every new group (via the `autocreate` setting).
- Add menu links to a group's menu directly, using the core menu-link UI.
- Reorder, enable, disable, and delete a group's menu links from the instance edit form.
- Render a group's menu in a block that follows the active group context.
- Place the "OG Menu" block per `ogmenu` type so different groups show different navigation.
- Let a group's members propose or manage links where OG roles permit the add-link operation.
- Model many small community sites within one Drupal install, each with its own menu.
- Keep a course/cohort group's navigation separate from other cohorts.
- Support a club or chapter site structure with self-contained menus.
- Attach navigation to group content types alongside their content.
- Manage group menus either from inside the group or from a global admin listing at `admin/structure/menu/ogmenu`.
- Clean up a group's menu automatically when the group is deleted.
- Seed new group menus with default links (via the separate OG Menu Default Links submodule/project).
- Provide breadcrumb-aware editing of OG menu links (custom breadcrumb handling replaces core menu_ui's).
- Vary rendered menus by group using the `og_group_context` cache context.
- Offer a first-available-group menu block and an all-groups menu block pattern for group pages.

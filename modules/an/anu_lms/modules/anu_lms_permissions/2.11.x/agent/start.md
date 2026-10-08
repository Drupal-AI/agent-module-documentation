<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Permissions (anu_lms_permissions) — agent index

Submodule of **anu_lms**. Scopes courses/members to organisations via the **Group** module.
Package `Anu LMS`. Core `^10 || ^11`. Version 2.11.2. Depends on `anu_lms`, `group:gnode`,
`group:group`, `groupmedia:groupmedia`. No own permissions or config schema; ships feature-exported
config (`config/install` + `config/optional`) including the `anu_organization` group type.

## What it provides

- **Route subscriber** `Routing\RouteSubscriber` — overrides `entity.group.canonical` `_controller`
  (removes `_entity_view`) → `Controller\AnulmsGroupViewController::view`.
- **`AnulmsGroupViewController::view($group)`** — for bundle `anu_organization` renders a
  `#theme => admin_page` dashboard: **Content** block (`view.group_nodes.page_1`,
  `entity.group_content.create_form` for `group_node:course`) and **Membership** block
  (`view.group_members.page_1`, add `group_membership` create/add forms). Each link is added only if
  `$link['url']->access()`. Other group bundles fall back to the default group view builder.
- **Route** `anu_lms_permissions.organization_list` — `/organizations`, title "Organizations",
  `_custom_access: OrganizationListController::access`. `build()` lists `anu_organization` groups from
  an `accessCheck(TRUE)` entity query; redirects to the group if the user has exactly one; each
  listed group re-checked with `$group->access('view')`. `access()` allows when the query returns any.
- **Normalizer integration** — base `anu_lms.normalizer` adds the `user.group_permissions` cache
  context to its cache id when this module is enabled (`Normalizer::getCacheId()`).

## Notes

- All access is delegated to Group: the organisation entity query uses `accessCheck(TRUE)`, and dashboard
  links are individually access-filtered — the effective boundary is the site's Group permission config.
- No custom entities, services, hooks or REST here; it is a routing/UI + cache-context adapter over Group.

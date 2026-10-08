<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Organic Groups turns any entity bundle into a "group" and any other bundle into "group content", giving each group its own members, roles and permissions on top of Drupal's global role system.

---

OG is an API module (its UI lives in the bundled `og_ui` submodule). Marking a bundle as a group is a single config change — `Og::groupTypeManager()->addGroup('node', 'my_group')` appends the bundle to `og.settings:groups.<entity_type>` and creates three `OgRole` config entities (`<entity_type>-<bundle>-member`, `-non-member`, `-administrator`, the first two `role_type: required`, the last with `is_admin: true`). Making a bundle group *content* means attaching an OG audience field: `Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, 'node', 'my_content')` creates the `og_audience` field of type `og_standard_reference` with the `og:default` selection handler, and wires it into the default form and view displays. The relationship between a **user** and a group is not a plain reference but the fieldable content entity **`og_membership`** (bundle entity `og_membership_type`, default bundle `default`), which stores `uid`, `entity_type`/`entity_bundle`/`entity_id` of the group, a `state` of `active|pending|blocked`, and a multi-value `roles` reference to `OgRole`s — so a single user can hold different roles and membership types in different groups. Everything else hangs off three services: `og.group_type_manager` (which bundles are groups/group content, default membership type per group bundle), `og.membership_manager` (create/query memberships, group ids for a piece of group content, member counts), and `og.access` (`userAccess()`, `userAccessEntity()`, `userAccessEntityOperation()`, `userAccessGroupContentEntityOperation()` — all returning cacheable `AccessResult`s). Group-level permissions (`administer group`, `update group`, `delete group`, `manage members`, `add user`, `subscribe`, `subscribe without approval`, `approve and deny subscription`, `administer permissions`) and per-bundle CRUD permissions are supplied through the `og.permission` event rather than a `*.permissions.yml`, and can be extended or altered by modules. Site-level behaviour is tuned through `og.settings` (`group_manager_full_access`, `node_access_strict`, `delete_orphans` + `delete_orphans_plugin_id`, `deny_subscribe_without_approval`, `group_resolvers`, `auto_add_group_owner_membership`), and the single global permission `administer organic groups` grants everything in every group. OG also ships subscribe/unsubscribe routes and a `og_group_subscribe` field formatter, blocks (`og_member_count`, `og_recent_group_content`), Views relationships/argument defaults, a `og_group_type` condition plugin, OG-aware cache contexts, and eleven membership actions used by the bundled members overview view.

---

- Turn a "Department" content type into a group and attach staff pages to it.
- Build a multi-tenant intranet where each team only manages its own content.
- Run a community site with user-created groups (clubs, projects, courses).
- Give each group its own administrator without granting site-wide admin rights.
- Let members create content inside a group but not elsewhere.
- Implement open / moderated / closed membership using the `pending` membership state.
- Offer a Subscribe / Leave link on a group page via the `og_group_subscribe` formatter.
- Require approval for new members with `deny_subscribe_without_approval`.
- Block a disruptive member without deleting their membership (`blocked` state).
- Give a group both "member" and "editor" roles with different permissions per group.
- Model premium vs free membership by adding a second `og_membership_type` bundle.
- Add fields (join date, notes, expiry) directly to the membership entity.
- Cross-post one piece of group content to several groups (the audience field is multi-value).
- Make users themselves group content by attaching an audience field to the user entity.
- Make taxonomy terms or media items group content.
- Use the OG members overview view (`og_members_overview`) with bulk role/state actions.
- Add or remove a role for many members at once with the multiple-role actions.
- Show a "member count" block on each group page.
- Show a "recent group content" block scoped to the current group.
- Restrict block visibility to certain group bundles with the `og_group_type` condition.
- Build Views listings of a group's content with the `og_group_to_group_content` relationship.
- Default a Views contextual filter to the current group with the `og_group_context` plugin.
- List the groups the current user belongs to with the `og_group_membership` argument default.
- Delete or orphan group content when its group is deleted (`delete_orphans`, batch/cron/simple).
- Queue orphan deletion for big sites and process it with `drush queue:run og_orphaned_group_content`.
- Resolve the "current group" from the route, the group content, a query argument or the user.
- Grant a group manager full permissions in their own group (`group_manager_full_access`).
- Enforce OG access on node create/update/delete instead of core's global permissions (`node_access_strict`).
- Cache-vary rendered output per group, per membership state, per OG role or per OG permission.
- Add custom group-level permissions from your own module via the `og.permission` event.

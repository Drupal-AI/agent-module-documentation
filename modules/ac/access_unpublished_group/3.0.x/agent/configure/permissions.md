<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Access Unpublished Group

## Prerequisites
- `access_unpublished` and `group` modules installed and configured.
- At least one Group type with a relation plugin (e.g. `group_node:article`).

## Enable token access per group type
1. Go to `admin/group/types`.
2. For the target group type choose **Edit permissions**.
3. Grant **Access unpublished <relation label>** (permission id `access_unpublished_group_<relation_plugin_id>`, e.g. `access_unpublished_group_group_node:article`) to the role that should be able to open token URLs — usually **Anonymous user**, since tokens are shared with people who are not logged in.
4. Save permissions.

## How access is decided (order of checks)
For a `view` request on a Group-related entity `AccessUnpublishedGroupAccessControl::entityAccess()`:
1. Runs the parent Group access handler. If it already allows, that stands.
2. Only if the parent **forbids**, it loads the entity's `group_relationship` records, finds one whose plugin id matches this handler, and checks `$group->hasPermission('access_unpublished_group_<plugin_id>', $account)`.
3. If that group permission is held, it calls `access_unpublished_entity_access($entity, 'view', $account)` — the Access Unpublished token check — and allows **only** if that allows. Cache metadata from both results is merged in.

The `/group/{group}/latest` route is handled by `GroupLatestRevisionCheck`, which `orIf()`s the Group latest-revision check with the token check.

## Notes
- The module adds no config entities and no routes; it is entirely service decoration. If a Group module upgrade changes `GroupServiceProvider::alter()`, revalidate `AccessUnpublishedGroupServiceProvider`.
- Removing the group permission instantly revokes token access for that relation.
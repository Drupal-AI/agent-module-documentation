<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content connected (content_connected) — agent index

info.yml name **"Content connected"**, version **2.1.3**. Description: *"Show how content is connected
with other content."* Builds a read-only table listing which **published nodes** reference a given node,
so an editor/administrator can gauge impact before editing or deleting it. Depends on core `field`.
Core `^8.8 || ^9 || ^10 || ^11`. Package: Other.

Detection is per node only (no users/terms/other entities). The manager scans three node field kinds and
reports a hit when another **published** node points at the target node:
- **entity_reference** fields whose `settings.target_type` is `node` — matched with `condition(field, nid)`.
- **link** fields — matched with `condition(field, 'internal:/node/' . nid, 'LIKE')`.
- **text_with_summary** and **text_long** ("long text") fields — matched with
  `condition(field, 'node/' . nid, 'CONTAINS')` (i.e. body text mentioning `node/N`).

Every scan is a core entity query with `->condition('status', 1)` (published only) and `->accessCheck()`
(access filtering enabled for the current user), so unpublished or inaccessible referencing nodes are
excluded from the results table.

## Surfaces (three, each gated by a distinct permission)

- **Node sub-tab** `entity.node.content_connected` → `node/{node}/content-connected` (`{node}` = `\d+`),
  permission `view content connected page`, `_admin_route: TRUE`. Controller
  `ContentConnectedController::contentConnectedoverview` renders the table; title callback
  `addPageTitle` → "Content connected with @label". Local task defined in `.links.task.yml`
  (base route `entity.node.canonical`).
- **Node delete-form table**: `hook_form_alter` appends a `#markup` element to every `node_<type>_delete_form`,
  `#access` gated by permission `access content connected` (so admins see what still references a node before
  confirming deletion). Multi-node/bulk delete shows nothing.
- **Block** `content_connected_block` ("Content connected block"), `blockAccess` = permission
  `access content connected`, `getCacheMaxAge() = 0`. Needs node context — reads `node` from the request;
  place it on node pages only.

## Configuration

- Route `content_connected.content_connected_admin_settings_form` → `/admin/config/content/content-connected-settings`,
  permission `administer content connected settings` (`configure` link in info.yml; menu link under
  `system.admin_config_content`). Form `Form\AdminSettingsForm`, config object
  **`content_connected.adminsettings`**.
- Keys are checkbox lists of field machine names to **exclude** from scanning:
  `content_connected_exclude_entityreffields`, `content_connected_exclude_linkfields`,
  `content_connected_exclude_longtextfields` (options come from the manager's field getters).

## Key facts / extension

- Service `content_connected.manager` = `Drupal\content_connected\ContentConnectedManager`
  (implements `ContentConnectedManagerInterface`). Public: `getEntityRefrenceFields()`, `getlinkFields()`,
  `getLongTextFields()`, `renderMatches($nid)` (builds+renders the `#theme => 'table'`), and
  `hasContentDependant($nid): bool`. Row titles are output via `Link::fromTextAndUrl($entity->label(), …)`
  (label auto-escaped by the render/table theme).
- Table columns: Entity type, Title (link), Content type, Status (Published / Not published), Type of field
  (`match_type(field_name)`). Empty text: "No content connected available."
- Alter hook `hook_content_connected_alter($nid, array &$matches)` (`content_connected.api.php`) lets other
  modules inject extra matches, keyed `$matches['field_type'] = ['ENTITY_ID' => …]`; keys containing `:` are
  split as `entity_type:field_name` so non-node entity types can be reported.
- Permissions (`content_connected.permissions.yml`): `access content connected` (delete-form table + block),
  `view content connected page` (sub-tab), `administer content connected settings` (settings form).
- No Drush, no config schema file shipped, no templates. Test stub at `Tests/Controller/`.

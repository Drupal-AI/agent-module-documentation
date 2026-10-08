<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Essential Node Protection prevents accidental deletion of the nodes that a site depends on: the configured front page, the 403 (access denied) page and the 404 (not found) page. It swaps in a custom node access control handler that returns "forbidden" for the delete operation on any node whose URL matches one of those site settings (when protection for that slot is enabled).
This guards against an editor or admin deleting the homepage or error pages and breaking the site, without needing a full content-lock or workflow module.
---
Install with `drush en essential_node_protection` (requires `node`). Configure which slots to protect at `/admin/config/system/essential-node-protection` (permission `administer essential_node_protection configuration`): toggle protection for the front page, 403 and 404 pages independently. Defaults protect all three.
Implementation: `hook_entity_type_build` sets the node `access` handler to `Drupal\essential_node_protection\NodeAccessControlHandler`, which extends core's handler. Its `access()` override checks only the `delete` operation: if the node is "essential" (its system path matches `system.site` `page.front`/`403`/`404` and that slot's protection is enabled) it returns `AccessResult::forbidden()`; otherwise it defers to core via `parent::access()`. This is fail-closed (it can only add a deny, never grant), so it cannot open up access. A minor note: the forbidden result does not attach cacheability metadata for the module/site config, so a stale deny could persist in a cached access result until caches clear — but as a delete protection it errs safe.
---
- Install: `composer require drupal/essential_node_protection && drush en essential_node_protection -y`.
- Configure at `/admin/config/system/essential-node-protection` (perm `administer essential_node_protection configuration`).
- Toggle protection for the front page node.
- Toggle protection for the 403 (access denied) page node.
- Toggle protection for the 404 (not found) page node.
- Protected nodes cannot be deleted (delete is forbidden for everyone).
- Prevents editors accidentally deleting the homepage.
- Prevents breaking custom error pages by deletion.
- Only the delete operation is affected; view/edit are unchanged.
- Non-essential nodes fall through to normal core node access.
- Fail-closed design: the handler can only deny, never grant, delete.
- Set which of front/403/404 to guard independently.
- Works by overriding the node entity's access handler.
- Uses the site's path settings to identify essential nodes.
- Clear caches after changing which node is the front/403/404 page.
- Uninstall to restore core node deletion behaviour.

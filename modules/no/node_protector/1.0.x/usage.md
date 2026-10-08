<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Protector stops a specific node — typically your front page — from being deleted.

---

The module implements `hook_ENTITY_TYPE_predelete()` for nodes: when a node whose id matches the configured `node_protector_nid` (or, if "auto" is enabled, the node behind `system.site` `page.front`) is about to be deleted, it shows a warning, redirects to the node's canonical page, and halts execution so the delete never completes. A settings form at `/admin/config/system/node_protector/settings` (`administer site configuration`) sets the protected NID and the auto-front-page toggle; a trivial `/node_protector/home` info page uses `access content`.

Protection is fail-closed for the single configured node (execution stops before the delete), but its scope is deliberately narrow: it guards exactly one NID (plus optionally the front page), not arbitrary sets or content types. It is a safety net against accidental deletion of a critical landing node rather than a general access-control system.

---
- Prevent accidental deletion of the site's front-page node.
- Protect one critical landing node by its NID.
- Auto-protect whatever node is set as the front page.
- Guard a key node from well-meaning editors.
- Show a clear warning when someone tries to delete the protected node.
- Redirect back to the node instead of completing the delete.
- Add a lightweight safety net without workflow modules.
- Switch the protected node by editing one config value.
- Toggle front-page protection on or off.
- Reduce the blast radius of bulk-delete mistakes on the home node.
- Keep the home page stable across editorial churn.
- Complement backups with an active delete guard.
- Avoid rebuilding a front page after an accidental delete.
- Protect a launch/campaign node during a busy period.
- Document which node is protected via the settings form.
- Provide a simple, config-only deletion guard.

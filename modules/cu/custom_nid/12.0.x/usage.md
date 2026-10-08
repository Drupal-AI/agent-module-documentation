<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Nid adds a "Nid" text field to the node creation form so a permitted user can choose the new node's ID instead of letting Drupal assign the next auto-increment value.

---

The module solves one narrow problem: setting a specific node ID when content is (re)created in Drupal, so URLs and ID-based references stay stable. If a legacy system's article 4217 must keep living at `/node/4217`, or a node is being rebuilt by hand to match an ID used elsewhere, the ID has to be set rather than assigned. Custom Nid does this with a single Form-API text field ("Nid") shown only on the node *create* form, only to users holding the `custom_nid access` permission, and only while the node has no ID yet. On submit it checks the value is numeric and not already taken (message "Nid already exists.") and then, in `hook_entity_presave`, applies it to the new node's `nid`. It is four files with no dependencies, no settings page, and no configuration — install it, grant the permission to the role doing the import, and the field appears. For anything repeatable or large-scale, Drupal's Migrate API is the mapped, rollbackable way to set IDs; Custom Nid is the proportionate tool for a handful of nodes. The 12.0.x branch is functionally identical to 11.0.x; the version number tracks the Drupal core major (it runs on core `^10 || ^11 || ^12`), not semantic versioning.

---

- Preserve legacy node IDs when recreating content in Drupal.
- Keep `/node/4217` pointing at the same article after a rebuild.
- Recreate a deleted node with its original ID.
- Match node IDs with an external system that references them.
- Restore a small set of nodes by hand after an accidental deletion.
- Keep inbound links working after moving content between systems.
- Align node IDs across staging and production for a few items.
- Reproduce a specific production node on a staging site.
- Give a permitted migration role the ability to type node IDs.
- Set an ID for content whose ID is baked into business logic.
- Keep references from a legacy database valid without a full migration.
- Preserve IDs that appear in printed or emailed material.
- Test behavior at a specific, known node ID.
- Fill an intended ID gap during a phased content import.
- Recreate content at an ID an API consumer already caches.
- Add the field only for trusted roles by scoping the permission.
- Verify an ID is free at submit time via the built-in uniqueness check.
- Hide the field automatically on edit forms (it only shows on create).
- Fall back to normal auto-increment by leaving the field blank.
- Keep URL and reference continuity during a system replacement.

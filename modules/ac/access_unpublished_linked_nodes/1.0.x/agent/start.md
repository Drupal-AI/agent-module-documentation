<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Unpublished Linked Nodes (access_unpublished_linked_nodes) — agent index
**Rewrites body links to unpublished nodes so they carry the visitor's access_unpublished token, keeping draft-to-draft preview working.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Depends on:** access_unpublished, linkit
- **Configure:** `/admin/config/content/access-unpublished-linked-nodes` (`access_unpublished_linked_nodes.settings`, permission `administer site configuration`) — selects processed content types.
- **Filter:** `access_unpublished_linked_nodes` (TYPE_TRANSFORM_REVERSIBLE, weight 199).
- **Hook:** `hook_preprocess_html()` adds a marker class + library on authorized preview pages.
- **Helper:** `AccessUnpublishedHelper` (`validateAuHash`, `getHashTag`, `roleChecks`, `modifyLinks`, `processEmbeddedBlocks`).

**Security:** Does not grant access itself — authorization defers to the `access_unpublished` token (`validateAuHash`) and, for minting links, the `access_unpublished node <type>` permission. Rewriting only runs for low-privilege roles (`roleChecks`). Draft/latest-revision content is only surfaced when a valid `auHash` token is supplied. See [configure/setup.md](configure/setup.md).

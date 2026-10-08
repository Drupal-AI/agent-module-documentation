<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges the Access Unpublished module with the Group module so unpublished Group content can be shared via time-limited access tokens.
---
Access Unpublished lets an editor mint a temporary token URL that grants anonymous view access to a single unpublished entity. On its own it does not understand Group's relationship-based access system, so unpublished content held inside a Group stays hidden even with a valid token. This module closes that gap.

It works entirely through Drupal's service/decorator layer. `AccessUnpublishedGroupServiceProvider::alter()` decorates every `group.relation_handler.access_control.*` service with `AccessUnpublishedGroupAccessControl`, and decorates `access_check.group_latest_revision` with `GroupLatestRevisionCheck`. The access-control decorator only ever *adds* access: it runs the parent handler first, and only when the parent result is `view`-forbidden does it look for a group that (a) relates the entity through the matching plugin and (b) grants the dynamic `access_unpublished_group_<plugin_id>` permission to the account, and then only allows if `access_unpublished_entity_access()` (the token check) also allows. There is no way for it to open content that the token itself does not authorise.

Setup is permission-only: install alongside Access Unpublished and Group, then at `admin/group/types` edit each group type's permissions and grant "Access unpublished <relation label>" (typically to the anonymous role) for the relation plugins you want token-shareable. The permissions are generated dynamically per installed group relation by `AccessUnpublishedGroupPermissions::groupPermissions()`.
---
- Install to make Access Unpublished tokens honour Group-held content.
- Grant the dynamic `access_unpublished_group_group_node:*` permission per group type.
- Let anonymous reviewers preview an unpublished node that lives inside a Group.
- Share a draft article in a members-only Group via a tokenised URL.
- Enable token preview on the `/group/{group}/latest` moderation route.
- Restrict token access to specific group relation plugins only.
- Keep unpublished Group content hidden from users without a valid token.
- Combine per-group-type permissions with Access Unpublished token expiry.
- Preview unpublished Group media or other relation entity types.
- Audit which group types expose unpublished content via permissions UI.
- Revoke sharing by removing the group permission for the relation.
- Support content moderation "latest revision" previews inside Groups.
- Extend an editorial review workflow to external stakeholders.
- Add token preview without granting standing view permission on drafts.
- Layer group-scoped preview on top of an existing Access Unpublished setup.
- Verify the decorator still applies after a Group module upgrade.
- Troubleshoot why a token URL 403s on Group content (missing group permission).
- Give anonymous stakeholders time-boxed access that auto-expires with the token.
- Keep the node-access grants system authoritative while adding token access.
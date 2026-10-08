Content Access adds fine-grained view/edit/delete access control for nodes by role — set once per content type, optionally overridden per individual node, and (with the ACL module) per individual user.

---

Content Access integrates with Drupal's core node grants system (`hook_node_grants()` + `hook_node_access_records()`) to control who can view, edit, or delete content. It adds two new "view" operations — *view any* and *view own* — and surfaces core's existing *edit*/*delete any* and *edit*/*delete own* permissions on the same screen, so all access for a content type is visible in one place. Each content type gets an **Access control** tab (an operation on the content-type edit page, at `/admin/structure/types/manage/{type}/access`) where you tick which roles may perform each operation; these defaults are stored as third-party settings on the node type. Optionally you can enable **per content node** access control for a type, which adds an **Access control** tab to each node (`/node/{node}/access`) so editors with the *grant content access* permission can override the type defaults for a single node (stored in the module's own `content_access` table). With the contributed **ACL** module enabled, the per-node tab also grows a "User access control lists" section for granting view/edit/delete to specific named users. The module writes only the grants that actually differ from what core permissions already provide (grant optimization) to keep the node_access table small, exposes an *Advanced* priority setting for sites running several node access modules, and requires a permissions rebuild after changes take effect. Note: it manages **published** content only — unpublished nodes remain author/`bypass node access` only.

---

- Let only the "editor" role view a "Press release" content type while it is embargoed.
- Restrict an entire content type so anonymous users cannot view it, only authenticated users.
- Give a "member" role view access to premium articles while keeping them hidden from the public.
- Allow authors to view their *own* unpublished-style restricted nodes via the *view own* permission.
- Grant *edit any* and *delete any* on a content type to a "moderator" role from one screen.
- Set per-content-type default access for view/edit/delete by role at the type's Access control tab.
- Override access for one specific node without touching the content type defaults (per-node tab).
- Enable per-node access control on a content type so each node shows its own Access control tab.
- Reset a node's per-node overrides back to the content-type defaults with one button.
- Grant view/edit/delete on a single node to named individual users via the ACL integration.
- Hand editors the *grant content access* permission so they can manage node-level access themselves.
- Limit *grant own content access* so users can only change access on nodes they authored.
- Show a consolidated overview of every role's view/edit/delete access for a content type.
- Rebuild node access grants across a content type after bulk permission changes.
- Raise Content Access's grant priority so its grants win when multiple node access modules run.
- Keep the node_access table lean by writing only grants that differ from core permissions.
- Automatically pick up role additions/removals on a user and prompt a permissions rebuild.
- Programmatically read a content type's access settings with `content_access_get_settings()`.
- Programmatically set a content type's access settings with `content_access_set_settings()`.
- Save custom per-node access settings in code with `content_access_save_per_node_settings()`.
- React to per-node access changes in a custom module via `hook_content_access_per_node()`.
- React to ACL user-grant changes via `hook_content_access_user_acl()`.
- Alter who may reach a node's Access control settings page with `hook_content_access_node_page()`.
- Explain in reports why a node is (or isn't) accessible via `hook_node_access_explain()` output.
- Deploy role-to-grant-id mapping as configuration (`content_access.settings`) between environments.
- Combine role-based type defaults with ACL per-user grants for mixed access models.

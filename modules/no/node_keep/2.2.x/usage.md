Node Keep adds a "Prevent this node from being deleted" checkbox (a `node_keeper` base field) to every node, blocking deletion by anyone who lacks the "administer node_keep per node" permission.

---

Node Keep defines a boolean `node_keeper` base field on all node bundles. When that box is checked, `hook_node_access()` returns *forbidden* for the delete operation for any user without the `administer node_keep per node` permission — the delete action and delete-translation action are also removed from the node edit form, and a "limited access permissions" warning is shown on the edit/delete pages (suppressible with the `hide_warning_messages` setting). If the Pathauto module is present, Node Keep adds a second `alias_keeper` base field that similarly locks the node's URL alias against changes by unauthorized users. The two checkboxes are grouped into a "Node keep" section of the node form's advanced sidebar and are only visible to users with `access node_keep widget`; only users with `administer node_keep per node` may change them. Per content type you can set the default value of each checkbox for newly created nodes from the node type form's "Node keep defaults" section (stored as `node_keep` third-party settings on the `node.type.*` config plus a base-field-override default). The only global configuration is a single settings form (`/admin/config/content/node-keep`) with the `hide_warning_messages` toggle.

---

- Stop editors from accidentally deleting a critical landing page or overview node.
- Protect a "homepage" node that other content references so it can never be removed by mistake.
- Lock the URL alias of a section-root node so child aliases like `/section/child` stay valid (with Pathauto).
- Allow content editors to edit and update a node but reserve deletion for administrators only.
- Set every new node of the "Landing Page" content type to be deletion-protected by default.
- Prevent a legally required page (privacy policy, terms) from being deleted by non-admins.
- Hide the "limited access permissions" warning message from editors via the settings form.
- Grant a trusted role the `administer node_keep per node` permission so only they can toggle protection.
- Reserve visibility of the protection checkboxes to certain roles with `access node_keep widget`.
- Protect key nodes referenced by menus or blocks from removal during content cleanups.
- Keep a node's automatic Pathauto alias from being regenerated/changed by editors.
- Apply per-content-type deletion defaults so campaign pages are protected on creation.
- Combine with translations: the delete-translation action is also blocked for protected nodes.
- Audit which nodes are protected by querying nodes where `node_keeper = 1`.
- Prevent deletion of nodes that serve as anchors for URL structures across the site.
- Let a workflow reserve deletion of published content to administrators.
- Protect demonstration/seed content on a shared or training site from being wiped.
- Turn protection on for a single node from its edit form's "Node keep" advanced section.
- Ensure a node used as a token source (with node_keep_token) is never accidentally deleted.
- Ship deletion-protection defaults for a content type as part of exported configuration.
- Temporarily lift protection by unchecking the box (requires `administer node_keep per node`).

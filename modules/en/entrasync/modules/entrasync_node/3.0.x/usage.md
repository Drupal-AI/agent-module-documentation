Adds the "node" storage option to EntraSync, provisioning each Microsoft Entra user as a Drupal node.

---

EntraSync Node Storage is a submodule of EntraSync that ships the `node` storage plugin. When a sync configuration selects "Node" as its storage type, each Entra user fetched from the tenant is turned into a Drupal node of a chosen content type — useful for building a people or staff directory from directory data rather than user accounts. The node title comes from a chosen Entra property, custom node fields are populated from mapped properties, and published/unpublished state is set from the sync configuration. Nodes are linked to their Entra user through the base module's managed-entities table, so later syncs update the same node instead of creating duplicates; a node can be unpublished when its Entra account is disabled, and optionally a new revision is created whenever the synced data changes. This submodule only provides the plugin and its form; fetching, queueing and scheduling belong to the base module. It uses core Node.

---

- Build a staff or people directory in Drupal from a Microsoft Entra ID / Azure AD tenant.
- Create one node per Entra user in a chosen content type (bundle).
- Set each node's title from a chosen Entra property (e.g. display name).
- Map Entra properties (department, job title, office, phone, etc.) onto custom node fields.
- Publish or unpublish imported nodes by default according to the sync configuration.
- Unpublish a directory node automatically when its Entra account is disabled.
- Keep directory nodes updated on each scheduled sync without creating duplicates.
- Create a new node revision whenever the synced data changes, for an audit trail.
- Maintain directories for several tenants by giving each sync its own Graph key and node mapping.
- Combine with per-property filters to build a directory of only certain departments or roles.
- Present organisation data as regular content that can be themed, listed and searched with Views.
- Avoid provisioning login accounts when you only need to display people information.

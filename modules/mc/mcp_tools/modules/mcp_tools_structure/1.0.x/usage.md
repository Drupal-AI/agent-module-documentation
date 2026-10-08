Adds MCP tools for building site structure — content types, fields, taxonomy vocabularies/terms, and user roles/permissions.

---

mcp_tools_structure is a submodule of MCP Tools exposing ~20 Tool API plugins across four services: `ContentTypeService`, `FieldService`, `TaxonomyManagementService` and `RoleService`. Read tools (List*/Get*) require read scope; every mutating tool is `ToolOperation::Write` gated by the `mcp_tools use structure` permission plus a write scope, and each service re-checks `AccessManager::canWrite()` and audit-logs the change. `GrantPermissions` additionally applies a denylist so an agent cannot grant certain high-risk permissions.

---

- Create a `blog_post` content type with a body field in one call.
- Scaffold a full content type with several custom fields at once (ScaffoldContentType).
- Add an image, entity-reference, boolean or date field to an existing bundle.
- Discover which field types are installed before adding one.
- Remove an obsolete field from a content type.
- List and inspect every content type on the site.
- Create a `tags` and a hierarchical `categories` vocabulary.
- Seed a vocabulary with dozens of terms in a single batch (SetupTaxonomy).
- Add child terms under a parent for a hierarchical taxonomy.
- Enumerate vocabularies and their term counts.
- Create a `content_editor` role with an initial permission set.
- Inspect exactly which permissions a role currently holds.
- Grant additional permissions to an existing role (safely denylisted).
- Revoke permissions from a role to tighten access.
- Delete a role that is no longer needed.
- Stand up a blog information architecture (type + taxonomy + role) from a prompt.
- Audit roles/permissions via read-only tools before making changes.
- Add taxonomy reference fields wiring articles to categories/tags.
- Prototype a new site section's structure without the admin UI.
- Let an AI agent translate 'a docs site with sections and authors' into real config.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Structure — Site-structure tools

Submodule `mcp_tools_structure`. All plugins live in `src/Plugin/tool/Tool/` and extend `Drupal\mcp_tools\Tool\McpToolsToolBase`. Permission for every tool: `mcp_tools use structure`. `operation` sets the required MCP scope (Read->read, Write->write, Trigger->admin); `destructive` tools require explicit client confirmation.

| Tool id | Class | Operation | Notes |
| --- | --- | --- | --- |
| `mcp_structure_list_content_types` | ListContentTypes | Read | List node types. -> ContentTypeService::listContentTypes(). |
| `mcp_structure_get_content_type` | GetContentType | Read | Describe one node type and its fields. -> ContentTypeService::getContentType(). |
| `mcp_structure_create_content_type` | CreateContentType | Write | Create a node type, optionally with a body field. -> ContentTypeService::createContentType(). |
| `mcp_structure_delete_content_type` | DeleteContentType | Write (destructive) | Delete a node type. -> ContentTypeService::deleteContentType(). |
| `mcp_structure_scaffold_content_type` | ScaffoldContentType | Write | Create a node type plus multiple fields in one call (title/body defaults + custom fields). |
| `mcp_structure_list_field_types` | ListFieldTypes | Read | List available field types. -> FieldService::getFieldTypes(). |
| `mcp_structure_add_field` | AddField | Write | Add a field to a bundle (`field_` prefix auto-added). -> FieldService::addField(). |
| `mcp_structure_delete_field` | DeleteField | Write (destructive) | Remove a field from a bundle. -> FieldService::deleteField(). |
| `mcp_structure_list_vocabularies` | ListVocabularies | Read | List taxonomy vocabularies. -> TaxonomyManagementService::listVocabularies(). |
| `mcp_structure_get_vocabulary` | GetVocabulary | Read | Describe a vocabulary. -> TaxonomyManagementService::getVocabulary(). |
| `mcp_structure_create_vocabulary` | CreateVocabulary | Write | Create a vocabulary. -> TaxonomyManagementService::createVocabulary(). |
| `mcp_structure_create_term` | CreateTerm | Write | Create one term (parent/weight/description). -> TaxonomyManagementService::createTerm(). |
| `mcp_structure_create_terms` | CreateTerms | Write | Batch-create terms in a vocabulary. -> TaxonomyManagementService::createTerms(). |
| `mcp_structure_setup_taxonomy` | SetupTaxonomy | Write | Create a vocabulary with initial (hierarchical) terms in one call. |
| `mcp_structure_list_roles` | ListRoles | Read | List user roles. -> RoleService::listRoles(). |
| `mcp_structure_get_role_permissions` | GetRolePermissions | Read | List a role's permissions. -> RoleService::getRolePermissions(). |
| `mcp_structure_create_role` | CreateRole | Write | Create a role with optional initial permissions. -> RoleService::createRole(). |
| `mcp_structure_delete_role` | DeleteRole | Write (destructive) | Delete a role. -> RoleService::deleteRole(). |
| `mcp_structure_grant_permissions` | GrantPermissions | Write | Grant permissions to a role; a denylist blocks some dangerous permissions. -> RoleService::grantPermissions(). |
| `mcp_structure_revoke_permissions` | RevokePermissions | Write (destructive) | Revoke permissions from a role. -> RoleService::revokePermissions(). |

Scope mapping: Read tools are usable by a read-scoped connection; Write tools need a write scope and fail closed under global read-only / config-only mode; Trigger tools need an admin scope. Services re-verify the scope and audit-log each mutation.


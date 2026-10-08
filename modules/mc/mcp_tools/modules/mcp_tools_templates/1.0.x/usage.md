Adds MCP tools to preview and apply pre-built site-configuration templates (blog, portfolio, business, documentation) and export existing config as a template.

---

mcp_tools_templates is a submodule of MCP Tools (package `MCP`) providing five Tool API plugins (`MCP_CATEGORY = 'templates'`). Templates are hardcoded, built-in site blueprints defined inside `TemplateService`; `ComponentFactory` materializes their components (vocabularies, roles, content types + fields, media types, webforms, views) through the entity-type manager. Read tools (list/get/preview) require read scope. `ApplyTemplate` and `ExportAsTemplate` are `ToolOperation::Trigger` and additionally require an admin scope via `AccessManager::canAdmin()`; there is no request-supplied template rendering — only selection of a fixed template by id.

---

- List the built-in site templates available to apply.
- Preview (dry-run) exactly what the 'blog' template would create.
- See which components a template would skip because they already exist.
- Inspect a template's full component definition before applying.
- Apply the 'blog' template to scaffold a blog in one step.
- Apply the 'portfolio' template for a project showcase site.
- Apply the 'business' template for a company site baseline.
- Apply the 'documentation' template for a docs site structure.
- Apply only selected component types (e.g. just content_types + vocabularies).
- Skip existing components so re-applying a template is safe.
- Bootstrap a new site's information architecture from a single prompt.
- Export an existing site's content types/vocabularies/roles as a template.
- Create a reusable custom template from a curated set of config.
- Compare a template's plan against the current site before committing.
- Stand up demo/staging sites quickly from a known template.
- Hand an AI agent a 'make me a blog' request it fulfils with one tool.
- Standardize new-project scaffolding across multiple Drupal sites.
- Audit what a template contains without changing the site.

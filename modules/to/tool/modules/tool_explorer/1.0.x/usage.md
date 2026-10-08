Tool Explorer adds an admin UI to browse every registered Tool plugin, inspect its inputs/outputs and config schema, and execute it through an auto-generated form — a developer/debugging aid for the Tool framework.

---

The submodule registers three routes under `/admin/config/tool/explorer` (all gated by the `administer tool` permission from the parent module) and a menu link under *Configuration → Development*. The list page (`ToolExplorerController::listTools`) shows a table of all `plugin.manager.tool` definitions with label, id, description, provider, and View/Execute operations. The view page (`viewTool`) renders a tool's details, its input and output definition tables, and a **config-schema helper**: it checks whether the provider module ships a `tool.plugin.<id>` config schema entry and, if missing, generates a suggested schema (via the Tool typed-data adapters) for the developer to copy. The execute page (`ToolExecuteForm`) instantiates the tool, builds its `execute` plugin form, runs the tool on submit, and reports success/failure — deliberately **not** printing raw outputs (a source `@todo` notes this is a security precaution, since a user may have entity access but not access to every field). It provides no permissions, config, or Drush of its own and depends only on `tool`.

---

- Browse all installed tools in one admin table with their ids, descriptions, and providers.
- Inspect a tool's input definitions (name, type, required, description) without reading code.
- Inspect a tool's output definitions from the UI.
- Manually execute a tool through an auto-generated form for quick testing.
- See whether a tool ships a `tool.plugin.<id>` config schema, and get a generated suggestion if not.
- Copy a suggested config-schema block for a tool that lacks one, speeding up correct schema authoring.
- Verify a newly written Tool plugin is discovered and runnable before wiring it to AI or Drush.
- Debug a failing tool by running it in the UI and reading the failure message.
- Confirm access control on a tool by executing it as the current admin user.
- Give non-CLI site builders a way to trigger a tool action.
- Check a tool's class, provider, and label at a glance during development.
- Gate all of the above behind the single `administer tool` permission.
- Navigate to a tool's execute form directly from the browse list's dropbutton.
- Review input requiredness/types when designing an AI function or Drush call for a tool.
- Use it as a reference implementation for embedding a tool's execute form in custom UI.

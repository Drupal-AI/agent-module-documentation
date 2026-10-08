# Tool Explorer UI

No settings form. The module is a set of admin pages over `plugin.manager.tool`. All routes require
the parent module's `administer tool` permission (defined in `tool.permissions.yml`, not
`restrict access: true`).

## Routes

| Route | Path | Handler | Purpose |
|---|---|---|---|
| `tool_explorer.list` | `/admin/config/tool/explorer` | `ToolExplorerController::listTools` | Table of all tools (label, id, description, provider, View/Execute dropbutton). Menu link under *Configuration → Development*. |
| `tool_explorer.view` | `/admin/config/tool/explorer/{plugin_id}` | `ToolExplorerController::viewTool` | Tool details + input/output definition tables + config-schema helper. 404 if the tool id is unknown. |
| `tool_explorer.execute` | `/admin/config/tool/explorer/{plugin_id}/execute` | `ToolExecuteForm` | Auto-generated execute form; runs the tool on submit. |

## View page — config-schema helper

`viewTool()` shows Plugin ID / Label / Description / Class, then the input-definition table (Name,
Label, Type, Required, Description) and output-definition table. It then locates the provider
module's `config/schema/<provider>.schema.yml` and checks for a `tool.plugin.<plugin_id>:` key:

- present → prints the actual schema block;
- file exists but key missing, or file missing → prints a **suggested** schema built by
  `buildSuggestedConfigSchema()`, which asks each input's Tool typed-data adapter
  (`getAdapterInstance(...)->getSchemaDefinition()`) for its schema and adds a `FullyValidatable`
  constraint. Copy/paste it into the provider module.

## Execute page

`ToolExecuteForm::buildForm()` instantiates the tool (`toolManager->createInstance($plugin_id)`),
resolves its `execute` plugin form (`$tool->getFormClass('execute')`, default
`Drupal\tool\Form\ExecuteToolPluginForm`), and embeds it as a subform. On submit it runs the plugin
form's `submitConfigurationForm()` (which calls the tool's `access()` then `execute()`), then reads
`$tool->getResult()` and shows an error message on failure.

Note: the form deliberately does **not** render successful outputs — a source `@todo` explains this
is a security precaution (a user may have `view` access to an entity but not to every field on it),
so output display is left unimplemented rather than risk leaking field data. Access to each tool is
still enforced by the tool's own `checkAccess()`, so `administer tool` alone does not bypass a tool's
guarding.

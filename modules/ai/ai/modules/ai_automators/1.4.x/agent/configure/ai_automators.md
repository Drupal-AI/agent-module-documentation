# configure — attach an automator to a field

There is **no dedicated settings form** (no `configure` route in info.yml). You configure an
automator on the **field's own config form** in Field UI: the module adds a section via
`hook_form_field_config_edit_form_alter` (and `hook_form_base_field_override_edit_form_alter`).
So: enable Field UI, edit the field (e.g. `/admin/structure/types/manage/article/fields/…`),
open the "AI Automator" section, pick a **rule** (`AiAutomatorType` matching the field type),
a **worker type**, write a **prompt** (tokens supported), and save. Each such configuration is
stored as an `ai_automator` config entity.

## Admin/list routes (from ai_automators.routing.yml)
| Route | Path | Permission |
|---|---|---|
| `ai_automators.list` | `/admin/config/ai/ai-automators` | `administer ai_automator` |
| `entity.ai_automator.collection` | `/admin/config/ai/ai-automators/ai-automator` | `administer ai_automator` |
| `entity.automators_tool.collection` | `/admin/config/ai/ai-automators/automators-tool` | `administer automators_tool` |
| `entity.automator_chain_type.collection` | (via route subscriber) under `/admin/config/ai/ai-automators` | `administer automator_chain types` |

These list/CRUD screens manage the config entities directly, but the normal way to add a
per-field automator is the Field UI form described above.

## The `ai_automator` config entity (config_prefix `ai_automator`)
Config export keys (schema in `config/schema/ai_automators.schema.yml`):

| Key | Meaning |
|---|---|
| `rule` | the `AiAutomatorType` plugin id that generates the value |
| `worker_type` | the `AiAutomatorProcessRule` plugin id (direct / queue / batch / action / widget) |
| `entity_type`, `bundle`, `field_name` | what this automator targets |
| `base_field` | non-empty when the target is a base field (uses base-field override) |
| `prompt` | the prompt template (tokens allowed) |
| `token` | token/input configuration |
| `input_mode` | how inputs are gathered |
| `edit_mode` | if true, may re-run on edit (not just on create) |
| `guardrail_set_id` | (nullable) AI Core `ai_guardrail_set` applied to generated values |
| `plugin_config` | freeform per-rule settings (`type: ignore` sequence) |
| `weight` | run order when several automators chain on one entity |

## Other config entities
- `automator_chain_type` (config bundle) + `automator_chain` (content entity) — a reusable
  bundle of automated fields you can run standalone; see [../api/ai_automators.md](../api/ai_automators.md).
- `automators_tool` — wraps an automator workflow so it can be offered to AI agents (exposed
  through the `automators_tools` AI Core function group).

## Inspect / script with drush
```bash
drush config:get ai_automator.ai_automator.<id>     # a single automator's config
drush config:list | grep ai_automator               # list all automators
```
Prefer configuring through the Field UI form so the rule list and worker-type options
validate against the field type and installed plugins.

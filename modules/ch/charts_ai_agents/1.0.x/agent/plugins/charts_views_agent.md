<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin: charts_views_agent (ChartsViewsAgent)

`Drupal\charts_ai_agents\Plugin\AiAgent\ChartsViewsAgent` — declared with the `#[AiAgent(id: 'charts_views_agent', label: 'Charts Views Agent')]` attribute. Extends `Drupal\ai_agents_extra\Plugin\AiAgent\ViewsAgent`, so most Views-building machinery (entity/field/plugin discovery, sub-agent runner) is inherited; this class overrides the parts that add the Charts chart style.

## Install / enable
Enable `charts_ai_agents`; also ensure `ai_agents` (with its `ai_agents_extra` sub-module), `charts` + a Charts renderer (e.g. Charts Highcharts), AI core and a configured AI provider are present. `isAvailable()` returns FALSE unless both `views` and `charts` are enabled; `isNotAvailableMessage()` prompts to enable Views, Charts and a Charts sub-module. No config to set on this module itself.

## Access
`hasAccess()` returns `AccessResult::forbidden()` unless the current user has the `administer views` permission, then defers to `parent::hasAccess()`. This is the only access gate the agent adds — all create/edit/delete work is admin-only.

## Capabilities declaration
- `agentsNames()` → `['Charts Views Agent']`.
- `agentsCapabilities()` → describes the `charts_views_agent` capability: creates Drupal Views with a Chart format around an entity type (pages, blocks, and, where plugins exist, maps/CSV/JSON exports). Single input `free_text` (Prompt, string); single output `answers` (string). Only needs a valid entity type to start.

## Task flow
1. `determineSolvability()` calls `determineSolvabilityCharts()` (which runs `agentHelper->setupRunner($this)`), then `determineTypeOfTask()` and stores the result in `$this->data`. Returns `JOB_SOLVABLE` for `create`/`edit`/`delete`, `JOB_SHOULD_ANSWER_QUESTION` for `information`, else `JOB_NOT_SOLVABLE`.
2. `determineTypeOfTask()` runs sub-agent `determineViewsTaskCharts`, passing the possible Views types, Views styles, and entity types/bundles. It validates that `action` is one of create/edit/delete/information/fail, else throws.
3. `solve()` calls `getViewExecCharts()` then switches on `action`:
   - **create** — if `show_mode` is empty or `content`, calls inherited `determineViewType()`; otherwise `determineFieldTypesCharts()`. Then `determineFilterTypes()` (inherited, prompt in this module). Returns a message linking `entity.view.edit_form` for the new view.
   - **edit** — not implemented (`@todo`).
   - **delete** — returns "This agent does not support deleting views."
   - **fail** — returns `data[0]['extra_info']`.
   - **information** — returns `answerQuestion()` (inherited).
4. `approveSolution()` sets `data[0]['action'] = 'create'`.

## View construction — `getViewExecCharts()`
Tries `Views::getView($data[0]['data_name'])`. On `create`, builds a `default` display and a visible display of type `view_type` (default page) and saves a new `View` entity with:
- `base_table` = `<entity_type>_field_data` (there is a `@todo` to load this from config),
- pager type/items-per-page, path (`trim(..., '/')`), title, description,
- when `view_style == 'chart'`: `display_options.style.options.chart_settings` = `data[0]['chart_settings']` (the library/type/fields/display/xaxis/yaxis structure produced by the triage prompt),
- when `permission` is set: `access.type = perm` with that permission.
New views are tracked in `$this->garbage`. Throws if the view cannot be saved or does not exist afterward.

## Field configuration — `determineFieldTypesCharts()`
Runs sub-agent `determineFieldsTaskCharts` with requested/available field types and plugin options. For each returned field with a resolvable storage table (or `entity_operations`), it assembles the Views field options (id/table/field/label/plugin_id/exclude), then runs sub-agent `determineFieldConfig` to optionally merge `new_config` (via `array_merge_recursive`). Special-cases: `image` fields in a table get `thumbnail` style + link to content; `entity_operations` forces `table = 'node'`. Writes the fields back to the `default` display and saves. Field YAML for the prompt is dumped with `Symfony\Component\Yaml\Yaml::dump`.

## Prompt YAMLs (`prompts/charts_views_agent/`)
All use `preferred_model: gpt-4o`, `preferred_llm: openai` by default (overridable by the AI Agents config).
- **determineViewsTaskCharts** (`is_triage: true`) — classifies the action and emits the full view spec incl. the nested `chart_settings` (library default highcharts, type default line, fields/data_providers with per-series color, display, xaxis, yaxis). Defaults view style to `chart`.
- **determineFieldsTaskCharts** — chooses rendered content vs. fields, and which fields/plugins.
- **determineFieldConfig** — per-field config tweaks (trim/alter/make_link, etc.).
- **determineFilterTypes** — infers view filters (title contains, status, date offset, taxonomy_index_tid + vid, content-type `type` filter).

## Operating notes
- The agent only creates *field-based* chart views usefully — chart settings live in the fields/data_providers structure; a rendered-content view has no data providers.
- `edit` is a no-op and `delete` is explicitly unsupported; use the Views UI for those.
- Example prompt (from README): "Please create a view of Chart Usage Statistics nodes using the chart style plugin. Use the title field as the label and the 7.x field as data provider. Make the chart a line chart using the Highcharts library."

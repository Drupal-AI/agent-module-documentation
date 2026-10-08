<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AiFunctionCall tool plugins

Four `#[FunctionCall]` plugins in `src/Plugin/AiFunctionCall/`, all `group: information_tools` and
implementing `ExecutableFunctionCallInterface` + `AiAgentContextInterface`. An `ai_agent` entity
enables a tool by its plugin id; the agent calls it to gather context, and the string set via
`setOutput()` / returned by `getReadableOutput()` is fed back to the model.

| Plugin id | Class | Inputs | Returns |
|---|---|---|---|
| `ai_drush_agents:get_drush_commands` | `GetDrushCommands` | none | Text list of every Drush command (name, description, aliases, help, class). |
| `ai_drush_agents:get_drush_code` | `GetDrushCode` | `class` (string, required) | Full PHP source of a Drush command class. |
| `ai_agent:get_config_entity` | `GetConfigEntity` | `entity_id` (req), `entity_type` (opt) | YAML dump of a config entity, or of a simple config object. |
| `ai_drush_agents:config_diff` | `ConfigDiff` | none | Created/deleted/updated config names + per-file YAML diff (active vs sync). |

## `GetDrushCommands`

`execute()` calls `Drush::getApplication()->all()` and builds a text block listing each command's
name, description, aliases, help and class. Used as the default information tool of
`drush_explain_agent`.

## `GetDrushCode`

`execute()` takes the `class` context, verifies `class_exists()` and that it
`is_subclass_of(DrushCommands::class)`, then `file_get_contents()` on
`ReflectionClass::getFileName()` and returns the source. Lets an agent read the implementation of a
specific Drush command class it was told about by `GetDrushCommands`.

## `GetConfigEntity`

`execute()` takes `entity_id` and optional `entity_type`.
- With `entity_type`: loads `entityTypeManager->getStorage($entity_type)->load($entity_id)` and
  `Yaml::dump($entity->toArray())`.
- Without `entity_type`: reads `configFactory->get($entity_id)`, gated by
  `currentUser->hasPermission('administer users')`, and dumps its values.

Enabled on `config_export_explainer` so it can pull a full config object when the diff alone is
ambiguous.

## `ConfigDiff`

`execute()` compares `config.storage` (active) with `config.storage.sync` (staged): computes
`created` / `deleted` / `common`, normalizes each common file with `normalizeConfigArray()`
(recursive `ksort`) to avoid ordering false-positives, and for changed files builds a
`Drupal\Component\Diff\Diff` + `DiffFormatter` block. Output is CREATED/DELETED/UPDATED lists plus a
YAML dump of the diffs — this is what `config_export_explainer` receives up front to explain a
pending `config:export`.

## Reusing them

Any `ai_agent` entity (in this project or your own) can enable these ids under its `tools:` /
`default_information_tools:` keys — see the two shipped agents in
[../commands/drush.md](../commands/drush.md) for the exact YAML shape.

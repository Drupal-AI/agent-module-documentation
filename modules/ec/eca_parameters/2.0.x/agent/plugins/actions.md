<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action plugins: Get parameter / Set parameter

## `eca_parameter_get` — "Get parameter"

Source: `src/Plugin/Action/ParameterGet.php` (extends ECA `ConfigurableActionBase`,
`type = "entity"`, `eca_version_introduced = 1.0.0`). Injects the `parameters` module's
`ParameterRepository`.

- **Config:** `parameter_name` (textfield; may be `name` or `collection:name` such as
  `global:my_global_param`, `node.article:my_article_param`) and `token_name` (textfield,
  `#eca_token_reference = TRUE`). The form shows a helper list of defined `collection:name`
  parameters.
- **`execute($entity = NULL)`:** token-replaces `parameter_name`, loads
  `parameterRepository->getParameter($name, $entity)`, then
  `tokenService->addTokenData($token_name, $parameter->getProcessedData())` — i.e. stores the
  parameter's processed value into the named ECA token for later steps.
- **`calculateDependencies()`:** if `parameter_name` contains `:`, loads that
  `ParametersCollection` and records it as a config dependency.
- Config schema: `action.configuration.eca_parameter_get` maps to `eca_parameters_action_configuration`
  (`type: ignore`) in `config/schema/eca_parameters.schema.yml`.

## `eca_parameter_set` — "Set parameter"

Source: `src/Plugin/Action/ParameterSet.php` (extends `ConfigurableActionBase`,
`eca_version_introduced = 1.0.0`). Injects the `ParametersCollectionStorage` (via
`entity_type.manager`) and ECA's `eca.service.yaml_parser` (`YamlParser`). Writes to the fixed
collection id **`eca`** (`static::$collectionId`).

- **Config:**
  - `parameter_name` (textfield) — token-replaced to the target parameter's machine name.
  - `parameter_value` (textarea) — the value.
  - `use_yaml` (checkbox) — interpret `parameter_value` as YAML for nested data.
  - `save` (checkbox) — persist the change to configuration, not just for the current request.
- **`execute()`:**
  1. Loads (or creates) the `eca` collection, reusing the statically cached instance
     (`ParametersCollectionStorage::$cachedCollections['eca']`) so the same object is used
     throughout the request.
  2. Merges the parameter entry into the collection's `parameters` array (creating a default
     label/description/weight if new).
  3. If **`use_yaml`**: parses `parameter_value` with `yamlParser->parse()` → `type: yaml`,
     `values: <parsed>`. A `ParseException` is logged (`logger->error(...)`) and the action aborts.
     Otherwise: token-replaces the value, sets `type` to `integer` when `ctype_digit()` else
     `string`, and stores it under `value`.
  4. If **`save`** and the parameters actually changed: loads an *unchanged* copy
     (`loadUnchanged('eca')`) and saves only this one parameter onto it — so concurrent runtime-only
     parameters aren't accidentally persisted — then reloads the collection.
  5. `setParameters(...)` on the in-memory collection and `setLocked()` it (prevents redundant
     re-saves when the parameter is requested later).
- **`calculateDependencies()`:** records the `eca` collection as a config dependency.

### Runtime vs. persisted

Without `save`, the value lives only for the current request (other steps can read it back via the
resolver / *Get parameter*). With `save`, the `eca` parameters collection config entity is written
to storage.

### Notes

- `parameter_value` and `parameter_name` are token-replaced (admin-authored model config); the YAML
  branch parses that same admin-authored string. There is no end-user request input on this path.
- The `eca` collection is seeded empty by `config/install/parameters.collection.eca.yml`
  (`id: eca`, label `ECA`, `parameters: {}`).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Parameters lets ECA (Event–Condition–Action) models read, test and write **Parameters** — the named, typed configuration values provided by the `parameters` module — by adding an event, two conditions and two actions, plus a dedicated `eca` parameters collection that ECA actions can write to at runtime.

---

The module wires the `parameters` module into ECA. It registers an event subscriber (`Drupal\eca_parameters\EventSubscriber\EcaParameters`) on the `parameters` module's `CollectionsPreparationEvent`; that subscriber inserts the module's own `eca` parameters collection into the list of collections available when any parameter is resolved (placed just before the `global` collection so ECA values take precedence over global ones but not over more specific entity-bundle collections), and — when a specific parameter name is being requested — dispatches an `eca_parameters.request` event so ECA models can react. On the ECA side it provides one event plugin **"Requesting parameter"** (`parameters:request`, class `ParametersEvent` with `ParametersEventDeriver`), which exposes `event:parameter_name`, `event:entity` and `event:ENTITY_TYPE` tokens and supports wildcard matching on the requested parameter name so a model can respond to one specific parameter or to all of them. Two conditions are provided: **"Parameter: exists"** (`eca_parameter_exists`, class `ParameterExists`) checks whether a named parameter resolves via `ParameterRepository::getParameter()`, and **"Parameter: compare value"** (`eca_parameter_value`, class `ParameterValue`, extending ECA's `StringComparisonBase`) compares a parameter's processed value against a supplied value. Two actions are provided: **"Get parameter"** (`eca_parameter_get`, class `ParameterGet`) loads a parameter (optionally namespaced as `collection:name`, e.g. `global:x` or `node.article:y`) and stores its processed data into a named ECA token; **"Set parameter"** (`eca_parameter_set`, class `ParameterSet`) writes a value onto the `eca` collection at runtime — the value can be a plain token-replaced string/integer or, with the *use YAML* option, parsed as YAML for nested data, and an optional *save* flag persists it to configuration instead of keeping it only for the current request. Parameter names in every plugin pass through ECA token replacement first, so they can be built dynamically. The optional **ECA Parameters UI** submodule adds an admin screen to manage the `eca` collection's parameters. All model building requires ECA administration rights, and ECA actions execute with real privileges, so this is a trusted, admin-authored capability rather than an end-user-facing one.

---

- Read a configured Parameter into an ECA token with the *Get parameter* action, then reuse it across the rest of the model.
- Load a namespaced parameter such as `global:site_mode` or `node.article:byline` and branch the workflow on it.
- Set a runtime-only parameter with *Set parameter* that later steps in the same request can read back.
- Persist a parameter to configuration by enabling the *save* option, so an ECA model can update a stored setting.
- Store structured/nested parameter data by enabling *use YAML* on *Set parameter* (e.g. `title: "[node:title]"`).
- Use the *Parameter: exists* condition to run a branch only when a given parameter is defined.
- Use the *Parameter: compare value* condition to gate a branch on a parameter equalling, containing or otherwise matching a value.
- React with the *Requesting parameter* event whenever a specific parameter is looked up, and supply/override its value on the fly.
- Match the *Requesting parameter* event against one specific parameter name (wildcard) or against all requests.
- Read `event:parameter_name`, `event:entity` and `event:ENTITY_TYPE` tokens inside a model handling a parameter request.
- Compute a parameter's value lazily in ECA the moment it is requested, instead of storing a static value.
- Give ECA models a shared, named key/value store (the `eca` collection) that survives across a request without custom code.
- Provide default values for parameters from ECA logic while letting more specific entity-bundle collections still override them.
- Feed Parameter values into other ECA actions (send email, set field, HTTP request, etc.) via the token produced by *Get parameter*.
- Drive feature flags or environment switches from Parameters and evaluate them in ECA conditions.
- Populate a Parameter from entity context (the requested entity is available as a token during the request event).
- Build the parameter name dynamically with tokens (all plugins token-replace the *parameter name* field before resolving).
- Manage the ECA-owned parameters visually via the ECA Parameters UI submodule at `/admin/config/workflow/eca/parameters`.
- Keep model logic portable: parameters set by ECA are exported/tracked as configuration when saved permanently.
- Centralise business constants (rates, thresholds, labels) as Parameters and consume them from many ECA models.

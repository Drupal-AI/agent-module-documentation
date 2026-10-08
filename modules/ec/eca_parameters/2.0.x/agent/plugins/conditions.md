<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugins: Parameter exists / compare value

Both resolve parameters through the `parameters` module's `ParameterRepository`
(`ParameterRepository::SERVICE_NAME`, injected via `create()`), and both take an `entity` context
definition so a per-entity/bundle parameter can be resolved against the entity in context. Both
token-replace the configured `parameter_name` before lookup.

## `eca_parameter_exists` — "Parameter: exists"

Source: `src/Plugin/ECA/Condition/ParameterExists.php` (extends ECA `ConditionBase`).

- **Config:** `parameter_name` (textfield). The form also renders a helper list of currently
  defined `collection:name` parameters (read from `ParametersCollectionStorage::get()->loadMultiple()`).
- **`evaluate()`:** gets the `entity` context, token-replaces `parameter_name`, calls
  `$this->parameterRepository->getParameter($name, $entity)`. Catches
  `ParameterNotFoundException` → treats as not found. Returns `negationCheck($parameter !== NULL)`
  (so it honours ECA's negate flag).

Use it to run a branch only when a parameter is defined/resolvable.

## `eca_parameter_value` — "Parameter: compare value"

Source: `src/Plugin/ECA/Condition/ParameterValue.php` (extends ECA `StringComparisonBase`).

- **`$replaceTokens = FALSE`** — the base class does not auto-replace tokens in the operands;
  this plugin does the replacement itself where needed.
- **Config:** `parameter_name` (textfield, same helper list of available parameters) and `value`
  (textarea, supports tokens). Plus the operator/case/negation options inherited from
  `StringComparisonBase`.
- **`getLeftValue()`:** token-replaces `parameter_name`, resolves the parameter via
  `parameterRepository->getParameter($name, $entity)`, and returns
  `->getProcessedData()->getString()`.
- **`getRightValue()`:** returns the token-replaced `value`.
- The comparison itself (equals / contains / starts-with / etc., case sensitivity, negation) is
  handled by `StringComparisonBase`.

Use it to gate a branch on a parameter's value.

## Parameter-name namespacing & dependencies

`parameter_name` may be a bare name or `collection:name` (e.g. `global:x`, `node.article:y`).
`ParameterValue::calculateDependencies()` (and `ParameterGet`'s) detects a `:` in the name, loads
the named `ParametersCollection`, and records it as a config dependency so exported models stay
consistent. `ParameterExists` does not add that dependency.

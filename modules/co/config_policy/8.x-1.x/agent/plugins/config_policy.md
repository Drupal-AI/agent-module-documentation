<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a `ConfigPolicyRule` plugin

Plugin type discovered from `src/Plugin/ConfigPolicyRule/`. Manager
`plugin.manager.config_policy.rule` (`ConfigRulePluginManager`), annotation
`Drupal\config_policy\Annotation\ConfigPolicyRule`, interface `ConfigRuleInterface`, alter hook
`hook_config_rule_info_alter`, cache key `config_rule_plugins`.

## Annotation

```php
/**
 * @ConfigPolicyRule(
 *   id = "my_rule",
 *   label = @Translation("My rule"),
 *   description = @Translation("What it enforces."),
 *   configPatterns = { "field.storage.*.*" },   // '*' → '.*' wildcard match on config name
 *   preventableForms = { "some_form_id" },       // optional; forms this rule may alter
 *   weight = 0                                    // optional int
 * )
 */
```

`configPatterns` is required (may be `{}` for prevent-only rules). Matching is
`preg_quote($pattern)` with `\*` replaced by `.*`, anchored `^…$` — so `*` is the only
wildcard and it is applied per config-object name.

## Base class + capability interfaces

Extend `ConfigRuleBase` (which supplies plugin id/label/uuid/weight, settings handling, and the
standard settings form fields via `submitConfigurationForm`: `label`, `validate_runtime`,
`fix_runtime`, `prevent`, `validate_import`). Or extend `WeightedConfigRuleBase` when only the
top-weighted matching rule across policies should act (`isTopRule()`/`differs()`).

Implement any combination of these markers — the service checks `instanceof` before calling:

- `ValidatableRuleInterface::validate(Config $config, ValidationResultInterface $result)` — add
  `OkResultItem` / `WarningResultItem` / `ErrorResultItem` to `$result`. Runs on the
  validate/fix forms, the Drush command, on config save (when `validate_runtime`), and on config
  import (when `validate_import`).
- `FixableRuleInterface::fix(Config $config, FixResultInterface $result)` — mutate `$config`
  (call `$config->save()` yourself when needed) and record `OkResultItem`s. Runs from `--fix`
  and on config save when `fix_runtime` is on. Fixes can be destructive (built-in
  `module_validation` uninstalls modules; `empty_entity_view_display` clears display content).
- `ConditionalRuleInterface::applies(Config $config): bool` — per-config gate evaluated after
  pattern match, before validate/fix. A throw is caught and recorded as an error.
- `PreventableRuleInterface::prevent(array &$form, FormStateInterface $form_state, string $form_id)`
  — alter an admin form (add `#validate`, disable elements, filter options). Only invoked from
  `hook_form_alter` on admin routes, for form ids in `preventableForms`, when the rule's
  `prevent` setting is on.

Override `buildConfigurationForm()` / `submitConfigurationForm()` (call `parent::`) to add and
persist your own settings, and add a matching schema entry
`config_policy.rule.<plugin_id>` in your module's `config/schema` (see the module's
`config_policy.schema.yml` for the shape — each rule maps under a policy's `rules` sequence).

## Orchestration & result API (`src/Policy`, `src/Result`)

- `ConfigPolicyService` — `validate()`, `fix()`, `validateChangelist()`, `prevent()`,
  `getConfigFiles()`. Iterates enabled policies → their rules, matches `getConfigPatterns()`
  against each config name, checks `applies()`, then calls the rule. Each rule call is wrapped in
  try/catch → `ErrorResultItem`. Fix on an `ImmutableConfig` re-loads an editable copy (from the
  active or, with `$sync`, the sync `ConfigFactory`).
- `ConfigPolicyRepository` — `findAll()` (all `status = TRUE` policies), `findByRule($class)`.
- Results: `ValidationResult` / `FixResult` (both `ResultBase`) collect `ResultItemInterface`
  objects grouped by type `ok|warning|error`; `count()`, `get($type)`, `getAll()`,
  `groupResultsByConfig()`, `isValid()`, plus free-text `addMessage()`/`getMessages()`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `MemoryLimitConstraint` plugin type

The base module defines the plugin type that all condition submodules implement. Write your own
to add a project-specific condition (e.g. "current workspace is X").

- Manager service: `plugin.manager.memory_limit_policy.memory_limit_constraint`
  (`MemoryLimitConstraintPluginManager`, parent `default_plugin_manager`).
- Plugin subdirectory: `src/Plugin/MemoryLimitConstraint/`.
- Annotation: `@MemoryLimitConstraint` (`Drupal\memory_limit_policy\Annotation\MemoryLimitConstraint`)
  with `id`, `title`, `description`.
- Interface: `MemoryLimitConstraintInterface` (extends `PluginInspectionInterface`,
  `ConfigurableInterface`, `PluginFormInterface`).
- Base class: `MemoryLimitConstraintBase` (extends `PluginBase`, adds
  `PluginDependencyTrait`, `StringTranslationTrait`).
- Discovery alter hook: `hook_memory_limit_policy_constraint_info(&$definitions)`.
- Cache: `memory_limit_policy_constraint` cache bin key.

## Methods to implement

`MemoryLimitConstraintBase` provides `getTitle()`, `getDescription()`, `isNegated()`,
`defaultConfiguration()` (`['negate' => FALSE]`), `getConfiguration()` (always prepends
`id`), `setConfiguration()`, and a `buildConfigurationForm()` that renders the `negate`
checkbox. You typically override:

- `buildConfigurationForm()` — call `parent::` then add your fields (store values under
  `$this->configuration[...]`).
- `submitConfigurationForm()` — call `parent::` then persist your form values into
  `$this->configuration`.
- `getSummary()` — **required** (abstract on the interface, no base implementation); a short
  human string shown in the policy UI.
- `evaluate()` — return `TRUE` when the condition matches the current request. The base
  implementation returns `!empty($this->configuration['negate'])`; several plugins fall back to
  `parent::evaluate()` when they cannot decide.
- `calculateDependencies()` — add config/module dependencies (e.g. the role plugin adds
  `user.role.<id>`).

## Skeleton

```php
namespace Drupal\my_module\Plugin\MemoryLimitConstraint;

use Drupal\memory_limit_policy\MemoryLimitConstraintBase;

/**
 * @MemoryLimitConstraint(
 *   id = "my_condition",
 *   title = @Translation("My condition"),
 *   description = @Translation("…"),
 * )
 */
class MyCondition extends MemoryLimitConstraintBase {

  public function getSummary() {
    return $this->t('My condition: @v', ['@v' => $this->configuration['value'] ?? '']);
  }

  public function evaluate() {
    // TRUE means "this constraint matches the current request".
    return $some_test ?: parent::evaluate();
  }

}
```

## How a policy uses the plugin

`MemoryLimitPolicy::evaluate()` walks the policy's constraints; for each it does
`isNegated() ? evaluate() : !evaluate()` and returns `FALSE` on the first that fails. So a
**non-negated** constraint must return `TRUE`, and a **negated** one must return `FALSE`, for
the policy to apply (logical AND across constraints). See
[../api/evaluation.md](../api/evaluation.md). Config for each instance is validated against the
schema `memory_limit_policy.constraint.plugin.<id>` contributed by the submodule.

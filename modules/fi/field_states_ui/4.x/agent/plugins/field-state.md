<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `FieldState` plugin type

Field States UI defines its own plugin type so each States-API state is a plugin.

## Pieces

- **Manager service:** `plugin.manager.field_states_ui.fieldstate`
  (`Drupal\field_states_ui\FieldStateManager`). Also `logger.channel.field_states`.
- **Discovery:** annotation `@FieldState` (`Drupal\field_states_ui\Annotation\FieldState`),
  plugins in `Plugin/FieldState/` of any module.
- **Interface:** `FieldStateInterface` (extends `PluginInspectionInterface`,
  `ConfigurableInterface`). Base class: `FieldStateBase`.

## Built-in plugins (`src/Plugin/FieldState/`)

`Visible`, `Invisible`, `Required`, `Optional`, `Enabled`, `Disabled`, `Checked`, `Unchecked`,
`Expanded`, `Collapsed` — most are thin subclasses of `FieldStateBase` differing only by their
`id`/`label` (the id is the States-API key used in the generated `#states`).

## Interface methods

- `applyState(array &$states, FormStateInterface $form_state, array $context, array $element, ?array $parents = NULL): bool`
  — add this state's entry to the `$states` array (builds the selector for `target` and the
  `comparison => value` condition). Returns whether it applied.
- `getSummary(): array` — human summary for the widget settings summary.
- `label(): string|MarkupInterface`, `getUuid(): string|MarkupInterface`.
- Plus `ConfigurableInterface` (`getConfiguration`/`setConfiguration`/`defaultConfiguration`) and
  the form methods (`buildConfigurationForm`, `validateConfigurationForm`,
  `submitConfigurationForm`) from `FieldStateBase`.

## Implement a custom state

```php
namespace Drupal\my_module\Plugin\FieldState;

use Drupal\field_states_ui\FieldStateBase;

/**
 * @FieldState(
 *   id = "my_state",
 *   label = @Translation("My State"),
 *   description = @Translation("What it does.")
 * )
 */
class MyState extends FieldStateBase {
  // Override applyState() only if you need behaviour beyond the base
  // target/comparison/value handling.
}
```

The `id` becomes the key in the generated `#states` array, so it should be a valid States-API
state (or one your JS understands). Configuration (`target`, `comparison`, `value`) is provided
by `FieldStateBase`; override `defaultConfiguration()` / `buildConfigurationForm()` to add more.

## How states are applied

`hook_field_widget_complete_form_alter()` → `FieldStateManager::apply($widget, $form_state,
$context)` iterates the widget's configured `field_states` third-party setting, instantiates each
plugin, and calls `applyState()` to assemble the `#states` array on the widget element.

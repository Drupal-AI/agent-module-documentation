# `dashboard_block` plugin type

Add a widget to the Content Planner dashboard.

- Manager service: `content_planner.dashboard_block_plugin_manager`
  (`DashboardBlockPluginManager`, discovers `Plugin/DashboardBlock`).
- Annotation: `@DashboardBlock` (`src/Annotation/DashboardBlock.php`) — fields `id`, `name`.
- Interface: `Drupal\content_planner\DashboardBlockInterface`.
- Base class: `Drupal\content_planner\DashboardBlockBase` (implements the interface +
  `ContainerFactoryPluginInterface`; injects `entity_type.manager`, `current_user`, `database`).

## Minimal widget

```php
namespace Drupal\my_module\Plugin\DashboardBlock;

use Drupal\content_planner\DashboardBlockBase;

/**
 * @DashboardBlock(
 *   id = "my_widget",
 *   name = @Translation("My widget"),
 * )
 */
class MyWidget extends DashboardBlockBase {

  public function build() {
    // Optional role gate provided by the base class.
    if (!$this->currentUserHasRole()) {
      return [];
    }
    return ['#markup' => 'Hello'];
  }
}
```

## Interface methods worth overriding

- `build()` — return the render array (base returns `[]`).
- `isConfigurable()` — return TRUE to expose a per-widget config form (reads a `configurable`
  key from the plugin definition; FALSE by default).
- `getConfigSpecificFormFields(&$form_state, &$request, $block_configuration)` — extra form
  elements; store results under `plugin_specific_config`.
- `validateForm()` / `submitSettingsForm()` — validate/persist the config-specific fields.

## Base-class helpers

- `getCustomConfigByKey($block_configuration, $key, $default)` — read one
  `plugin_specific_config` value.
- `buildAllowedRolesSelectBox($block_configuration)` — a "Display for roles" checkboxes element
  (stored as `plugin_specific_config.allowed_roles`).
- `currentUserHasRole()` — TRUE if the current user matches `allowed_roles` (empty = all; user 1
  always TRUE). Call it from `build()` to enforce visibility.
- `getBasicConfigStructure()` — the default block config skeleton
  (`plugin_id`, `title`, `weight`, `configured`, `plugin_specific_config`).

Reference implementations: `ViewBlockBase` (embeds a View), `CustomHTMLBlockBase` (a
`text_format` field), `UserBlock`.

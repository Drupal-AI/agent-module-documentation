# Read the environment in code

Service `environment_indicator.indicator`
(`Drupal\environment_indicator\Service\EnvironmentIndicator`).

```php
$indicator = \Drupal::service('environment_indicator.indicator');
$title    = $indicator->getTitle();          // ?string — active environment name
$release  = $indicator->getCurrentRelease(); // ?string — version/deploy identifier
$links    = $indicator->getLinks();          // array — switcher dropdown links
$tags     = $indicator->getCacheTags();      // array — cache tags for the indicator
```
Inject it instead of `\Drupal::service()` in your own services. Constructor args:
`config.factory`, `entity_type.manager`, `state`, `settings`.

Also available:
- `environment_indicator.toolbar_handler` (`ToolbarHandler`) — builds the toolbar/page-top
  render arrays; wraps the indicator service.
- `environment_indicator_load($environment_id)` (in `.module`) — load a switcher entity by id.

The banner itself is emitted by `hook_page_top()` in `environment_indicator.module`, so it
appears without any code on your part once an environment is active.

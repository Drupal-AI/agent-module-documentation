<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Loader — API & the Throbber plugin type

## The throbber manager service

`ajax_loader.throbber_manager` → `Drupal\ajax_loader\ThrobberManager`
(a `DefaultPluginManager`, also `MapperInterface`). Discovers `@Throbber` plugins in
`Plugin/ajax_loader` of any module. Interface: `ThrobberManagerInterface`.

```php
/** @var \Drupal\ajax_loader\ThrobberManagerInterface $m */
$m = \Drupal::service('ajax_loader.throbber_manager');

$m->getThrobberOptionList();          // ['throbber_pulse' => 'Pulse', ...] for select #options
$m->loadThrobberInstance('throbber_pulse'); // one ThrobberPluginInterface instance
$m->loadAllThrobberInstances();       // every throbber instance
$m->getDefinition('throbber_pulse', FALSE); // definition array or NULL (2nd arg = throw)
$m->RouteIsApplicable();              // bool: should the throbber attach on this request?
```

`RouteIsApplicable()` returns TRUE on non-admin routes; on admin routes it returns TRUE only
when `ajax_loader.settings:show_admin_paths` is TRUE and the current route is not
`ajax_loader.settings`.

## How attachment works (no API call needed)

`ajax_loader_page_attachments()` (in `ajax_loader.module`) reads `ajax_loader.settings`,
and when the `throbber` plugin exists and `RouteIsApplicable()` is TRUE it sets:

```php
$page['#attached']['drupalSettings']['ajaxLoader'] = [
  'markup'          => $throbber->getMarkup(),
  'hideAjaxMessage' => $settings->get('hide_ajax_message'),
  'alwaysFullscreen'=> $settings->get('always_fullscreen'),
  'throbberPosition'=> $settings->get('throbber_position'),
];
$page['#attached']['library'][] = 'ajax_loader/ajax_loader.throbber';
```

`js/ajax-throbber.js` (library `ajax_loader/ajax_loader.throbber`, deps: `core/jquery`,
`core/drupal`, `core/drupalSettings`, `core/drupal.ajax`) reads `drupalSettings.ajaxLoader`
and inserts/removes the markup at the `throbberPosition` selector during Drupal's AJAX
lifecycle. `hook_library_info_alter()` injects the chosen throbber's CSS file into the
library, which is why config changes require a cache clear.

## Define a custom throbber plugin

Drop a class in `your_module/src/Plugin/ajax_loader/`. Annotation-based discovery
(`@Throbber` → `Drupal\ajax_loader\Annotation\Throbber`, keys `id`, `label`). Extend
`ThrobberPluginBase` and implement the two abstract methods.

```php
<?php
namespace Drupal\your_module\Plugin\ajax_loader;

use Drupal\ajax_loader\ThrobberPluginBase;

/**
 * @Throbber(
 *   id = "throbber_my_spinner",
 *   label = @Translation("My spinner")
 * )
 */
class ThrobberMySpinner extends ThrobberPluginBase {

  protected function setMarkup() {
    return '<div class="ajax-throbber my-spinner"><span></span></div>';
  }

  protected function setCssFile() {
    // Path is relative to your module root (ThrobberPluginBase prefixes the module path).
    return $this->path . '/css/my-spinner.css';
  }
}
```

`ThrobberPluginBase` (constructed with `extension.list.module`) gives you `getMarkup()`,
`getCssFile()`, `getLabel()`, and `$this->path` (leading-slash path to the module that owns
the plugin). Return `NULL` from `setCssFile()` if the throbber needs no CSS.

`ThrobberPluginInterface` is the contract; the manager alter hook id is
`ajax_loader_throbber_info` (`hook_ajax_loader_throbber_info_alter`) for altering discovered
definitions. After adding a plugin, `drush cr` so it appears in the settings `<select>`.

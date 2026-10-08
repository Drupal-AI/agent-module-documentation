# TacJS alter hooks

TacJS invites two hooks (see `tacjs.api.php`) so other modules can add tarteaucitron services
that are not in the stock `tarteaucitron.services.js`.

## hook_tacjs_services_alter(array &$services)

Adds raw tarteaucitron service **definitions** (the `tarteaucitron.services.NAME = { … }` JS
blocks). Called from `_tacjs_generate_active_services_file()` when TacJS builds the trimmed
active-services JS file, and merged with the services parsed from the library. Keys are service
names; values are the JS source string.

```php
/**
 * Implements hook_tacjs_services_alter().
 */
function mymodule_tacjs_services_alter(array &$services) {
  $path = \Drupal::service('extension.list.module')->getPath('mymodule');
  $js = file_get_contents($path . '/js/my_custom_services.js');
  // Extract each `tarteaucitron.services.NAME = { … };` block into $services[NAME].
  preg_match_all('/tarteaucitron\.services\.(\w+)\s*=\s*\{\s*\n?([\s\S]*?)\n\};/m', $js, $m, PREG_SET_ORDER);
  foreach ($m as $match) {
    $services[$match[1]] = "tarteaucitron.services.{$match[1]} = {\n{$match[2]}\n};";
  }
}
```

After adding a service here it still has to be enabled (given `status: true`) on the **Add
services** form / in `tacjs.settings.services` for it to load.

## hook_tacjs_content_alter(array &$content)

Adds/edits entries in the parsed service **content** array (grouped by category such as
`analytic`, `ads`, `video`, `social`, …), used by the Add services form when presenting
available services.

```php
/**
 * Implements hook_tacjs_content_alter().
 */
function mymodule_tacjs_content_alter(array &$content) {
  $content['analytic']['my_custom_analytic_service'] = [
    'about' => ['name' => 'My Custom Analytic Service'],
    // Provide code.js / code.html or tarteaucitron logs warnings.
    'code'  => ['js' => '', 'html' => ''],
  ];
}
```

Note: TacJS defines **no plugin types** and no service API of its own — these two alter hooks
are the entire extension surface.

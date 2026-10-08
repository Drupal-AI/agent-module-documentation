# Programmatic API — read values, load pages, add a context

## Read a field value — `config_pages.loader`

Service id `config_pages.loader` (`Drupal\config_pages\ConfigPagesLoaderService`).

```php
/** @var \Drupal\config_pages\ConfigPagesLoaderService $loader */
$loader = \Drupal::service('config_pages.loader');

// Load the singleton entity for a type (current context when $context is NULL):
$page = $loader->load('my_settings');                 // ConfigPages|NULL

// Get a scalar/field value directly:
$value  = $loader->getValue('my_settings', 'field_phone', 0, 'value');   // single delta+key
$values = $loader->getValue('my_settings', 'field_links');               // all deltas (array)

// Get a render array for a field in a view mode:
$build  = $loader->getFieldView('my_settings', 'field_hero', 'full');
```

`getValue($type, $field_name, $deltas = [], $key = NULL)` — `$type` may be a type-name string
or an already-loaded `ConfigPages` object. Pass an int `$delta` to get one value back, an array
(or `[]` = all) to get an array. `$key` extracts a single column (e.g. `'value'`, `'target_id'`).
Returns `[]`/`NULL` gracefully when the page or field is missing.

## Helper function & direct entity load

```php
$page = config_pages_config('my_settings');            // procedural helper (module file)
$page = \Drupal\config_pages\Entity\ConfigPages::config('my_settings', $context);
$value = $page->get('field_phone')->value;             // standard entity field access
```

`ConfigPages::config($type, $context)` resolves the correct singleton for the current (or given)
context, using a static id map plus fallback/empty-context safety nets. In long-running processes
or tests call `ConfigPages::resetConfigCache()` after creating/deleting pages.

## Create / save a config page in code

```php
use Drupal\config_pages\Entity\ConfigPages;
use Drupal\config_pages\Entity\ConfigPagesType;

$type = ConfigPagesType::load('my_settings');
$page = ConfigPages::create([
  'type'    => 'my_settings',
  'label'   => $type->label(),
  'context' => $type->getContextData(),   // serialized current-context hash
]);
$page->set('field_phone', '+1 555 0100');
$page->save();
```

## Add a custom context — `config_pages_context` plugin type

Manager service `plugin.manager.config_pages_context` (`ConfigPagesContextManager`), plugin
namespace `Plugin/ConfigPagesContext`, attribute
`Drupal\config_pages\Attribute\ConfigPagesContext(id, label)` (legacy annotation
`@ConfigPagesContext` also supported). Extend `ConfigPagesContextBase` and implement:

```php
#[ConfigPagesContext(id: "my_context", label: new TranslatableMarkup("My context"))]
class MyContext extends ConfigPagesContextBase {
  public function getValue()  { /* current context value, e.g. a domain id */ }
  public function getLabel()  { /* human label of the current value */ }
  public function getLinks()  { /* array of switch links: title/href/selected/value */ }
}
```

The active value is serialized into each entity's `context` field so a distinct `config_pages`
entity is stored per context value. The bundled **Language** plugin (`id: language`) is the
reference implementation. Alter hooks: `hook_config_pages_contexts_info_alter()`.

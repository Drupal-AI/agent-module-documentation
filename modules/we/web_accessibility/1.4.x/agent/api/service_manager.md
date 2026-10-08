# API: the service manager

Service id `web_accessibility.service_manager` → class
`Drupal\web_accessibility\WebServiceManager`, which implements
`Drupal\web_accessibility\WebServiceInterface`. Constructed with `@database`
(`Drupal\Core\Database\Connection`) and tagged `backend_overridable`.

All persistence is the plain DB table `web_accessibility_services` (`id`, `name`, `url`).
This is a normal service, **not** a plugin manager — there is no plugin type, annotation,
or discovery.

## Interface / methods

| Method | Returns | Notes |
|---|---|---|
| `findAll()` | array of row objects | `SELECT * FROM {web_accessibility_services}` → `fetchAll()`. Each item has `->id`, `->name`, `->url`. |
| `addService($url, $name)` | void | Inserts a row (`->fields(['url' => …, 'name' => …])`). |
| `deleteService($id)` | void | `DELETE … WHERE id = $id`. |
| `findById($service_id)` | assoc array or `FALSE` | Parameterized `WHERE id = :id` → `fetchAssoc()`. |
| `getDefaultServices()` | array | The three seed validators (not on the interface; used by `hook_install`). |

## Constant

`WebServiceInterface::URL_TOKEN` = `'<URL>'` — the placeholder a service URL uses to mark
where the target page URL is substituted at render time.

## Example

```php
/** @var \Drupal\web_accessibility\WebServiceInterface $m */
$m = \Drupal::service('web_accessibility.service_manager');

$m->addService('https://example.org/check?uri=<URL>', 'Example validator');

foreach ($m->findAll() as $service) {
  // $service->id, $service->name, $service->url
}

$row = $m->findById(1);          // ['id' => 1, 'name' => …, 'url' => …] or FALSE
if ($row !== FALSE) {
  $m->deleteService($row['id']);
}
```

Note `addService()` performs no validation of its own — the URL/name checks live in
`AdminForm::validateForm()`, so callers writing directly to the service are responsible
for their own validation.

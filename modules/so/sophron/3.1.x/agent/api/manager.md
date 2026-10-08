# MimeMapManager service

Service id: autowired by interface `Drupal\sophron\MimeMapManagerInterface` (class
`MimeMapManager`). Inject it or `\Drupal::service(MimeMapManagerInterface::class)`.

Key methods:

| Method | Returns | Purpose |
|---|---|---|
| `getType(string $type)` | `Type` | MimeMap Type object for a MIME type (its extensions, aliases, description). |
| `getExtension(string $extension)` | `Extension` | MimeMap Extension object for a file extension (its default type). |
| `listTypes()` | `array` | All known MIME type strings. |
| `listExtensions()` | `array` | All known file extensions. |
| `getMapClass()` / `setMapClass($class)` | string / self | Get or switch the active map class. |
| `isMapClassValid($class)` | bool | Whether a class name is a usable map. |
| `getMappingErrors($class)` | array | Errors found applying map commands to a class. |
| `determineMapGaps($class)` | array | Differences between a map and the active one. |
| `getMimeTypesJson()` | string | JSON dump of all types (backs the `/sophron/mime-types.json` feed). |
| `requirements($phase)` | array | Status-report requirements entries. |

Example:
```php
$manager = \Drupal::service(\Drupal\sophron\MimeMapManagerInterface::class);
$ext = $manager->getExtension('avif');
$type = $ext->getDefaultType();            // "image/avif"
$exts = $manager->getType('image/jpeg')->getExtensions(); // ['jpeg','jpg','jpe',...]
```
Underlying objects (`Type`, `Extension`) come from the `fileeye/mimemap` library.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — maybe

## Create
```php
use Drupal\maybe\Maybe;
$out = (new Maybe($entity))->method1()->method2()->return();
// or the helper:
$out = maybe($entity)->method1()->method2()->return();
```

## Methods handled by Maybe itself
- `->return()` — extract the current wrapped value (call at the end of a chain).
- `->property('name')` — read `$object->name` if `property_exists`, else null.
- `->array($key, [$key2, ...])` — traverse array keys with `isset` guards; multiple args descend into nested arrays.

## Passthrough (`__call`)
Any other method is forwarded to the wrapped value:
- If the value is an **array**, Maybe first `reset()`s to the first element, then calls the method.
- If it is an **object**, the method is called only when `method_exists()`, else the value becomes null.
- Special case: `get('field_name')` on something with `hasField()` returns null (not an exception) when the field is absent.

## Example (concise nested traversal)
```php
$variables['file_url'] = maybe($paragraph)
  ->get('field_media_file')->referencedEntities()
  ->get('field_media_file')->referencedEntities()
  ->url()->return();
```
Equivalent to a multi-level chain of null/`hasField` checks.

## Notes / caveats
- Method names are developer-supplied at call time — never user input — so there is no dynamic-dispatch security concern here.
- When the wrapped value is an array and you don't call `->array(...)`, the next method applies to the **first** element.
- `array()` and `return()` are used as method names; keep in mind these are soft-reserved words but valid as method identifiers.

# Translate Tool — the service API

One service wrapping core `locale.storage`. Use it from update/install hooks (or any code) to
create or remove interface-translation strings without the translation UI.

## Service

```php
/** @var \Drupal\translate_tool\TranslateTool $tt */
$tt = \Drupal::service('translate_tool');       // arg: @locale.storage
```

## Methods

```php
$tt->add(string $source, string $langcode, string $translation, string $context = '');
$tt->delete(string $source, string $context = '');
```

- **`add()`** — `findString(['source' => $source, 'context' => $context])`; if none, creates a
  `SourceString` (`setString`, `setStorage`, `context`, `save`). Then
  `createTranslation(['lid' => …, 'language' => $langcode, 'translation' => $translation])->save()`.
  If a translation already exists it is **replaced**.
- **`delete()`** — `deleteStrings(['source' => $source, 'context' => $context])`.
- `$context` defaults to `''` (Drupal's default/untitled context).

## Procedural wrappers (same behaviour)

```php
translate_tool_add(string $source, string $langcode, string $translation, string $context = '');
translate_tool_delete(string $source, string $context = '');
```

Both just resolve the `translate_tool` service and call the matching method — convenient inside
procedural `hook_update_N()` / `hook_install()`.

## Example (update hook)

```php
function my_module_update_10001(&$sandbox) {
  translate_tool_add('horse', 'da', 'hest');            // default context
  translate_tool_add('horse', 'da', 'hest', 'animals'); // scoped context
  translate_tool_delete('old string');
}
```

Notes: the `$source` must be a string Drupal collects for translation (a `t()`/`@Translation`
string) for the added translation to appear where that string is rendered; `add()` will still
create the source+translation records regardless. No return value.

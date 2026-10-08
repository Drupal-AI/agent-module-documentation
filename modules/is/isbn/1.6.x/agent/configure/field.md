<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add and configure an ISBN field

The module has **no configure route** (`configure: null`). Configuration = adding an ISBN
field to a bundle and choosing its widget and formatter, exactly like any Field API field.

## Add the field (UI)

1. *Structure → Content types → <bundle> → Manage fields → Create a new field*.
2. Field type: **ISBN** (it lives in the *General* field-type category).
3. Give it a label/machine name; save field + storage settings.

The widget defaults to `isbn_widget` (a 20-char text input) and the formatter defaults to
`isbn_default`.

## Add the field (drush php:eval / config)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_isbn',
  'entity_type' => 'node',
  'type' => 'isbn',                 // <-- the field type id
])->save();

FieldConfig::create([
  'field_name' => 'field_isbn',
  'entity_type' => 'node',
  'bundle' => 'book',
  'label' => 'ISBN',
])->save();
```

Storage: a single `value` column, `text` / size `tiny`, nullable (see `IsbnItem::schema()`).

## Choose the display formatter

On *Manage display* pick one of:

| Formatter id | Label | Output |
|---|---|---|
| `isbn_default` | Non formatted value | the stored string, unmodified |
| `isbn_formatted_formatter` | ISBN formatted value | value passed through `IsbnTools::format()` (hyphen-grouped) |

Set it in config:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'book', 'default')
  ->setComponent('field_isbn', ['type' => 'isbn_formatted_formatter'])
  ->save();
```

Read it back: `drush cget core.entity_view_display.node.book.default content.field_isbn`.

## Widget

The only widget is `isbn_widget` (`Format and validate ISBN fields`), a plain textfield of
size 20. There are no widget or formatter settings to configure.

## What happens on save

`IsbnItem::preSave()` calls `isbn.isbn_service` → `cleanup()`, which strips every character
that is not `[0-9a-zA-Z]`. So `978-0-13-468599-1` is stored as `9780134685991`. Validation
(constraint `IsbnValidation`) runs first and blocks invalid ISBNs at form submit.

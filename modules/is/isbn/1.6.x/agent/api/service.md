<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `isbn.isbn_service` service

Service id: **`isbn.isbn_service`** → class `Drupal\isbn\IsbnToolsService`, interface
`Drupal\isbn\IsbnToolsServiceInterface`. A thin wrapper around `Nicebooks\Isbn\IsbnTools`.
The constructor throws `\RuntimeException` if the `nicebooks/isbn` library is missing.

```php
$isbn = \Drupal::service('isbn.isbn_service');
```

## Methods

| Method | Signature | Returns |
|---|---|---|
| `format` | `format(string $isbn): ?string` | hyphen-grouped ISBN, or `NULL` if invalid |
| `isValidIsbn` | `isValidIsbn(string $isbn): bool` | TRUE for a valid ISBN-10 or ISBN-13 |
| `convertIsbn10to13` | `convertIsbn10to13(string $isbn): ?string` | unformatted ISBN-13, or `NULL` if invalid |
| `convertIsbn13to10` | `convertIsbn13to10(string $isbn): ?string` | unformatted ISBN-10, or `NULL` (also `NULL` if the ISBN-13 does not start with 978) |
| `cleanup` | `cleanup(string $isbn): string` | the input with every non-`[0-9a-zA-Z]` char removed (never NULL) |

`format`, `convertIsbn10to13`, and `convertIsbn13to10` swallow the library's
`InvalidIsbnException` internally and return `NULL` instead of throwing.

## Examples

```php
$s = \Drupal::service('isbn.isbn_service');
$s->isValidIsbn('9780134685991');        // TRUE
$s->format('9780134685991');             // "978-0-13-468599-1"
$s->convertIsbn10to13('0-13-468599-9');  // "9780134685991"
$s->convertIsbn13to10('9780134685991');  // "0134685997"
$s->cleanup('978 0 13 468599 1');        // "9780134685991"
```

## Where it is used internally

- `IsbnItem::preSave()` → `cleanup()` (normalises the stored value).
- `IsbnFormattedFormatter::viewElements()` → `format()`.
- `IsbnConstraintValidator::validate()` → `isValidIsbn()`.

There are no hooks, no Drush commands, and no events to subscribe to.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ISBN plugins

The module does **not** define a plugin *type*; it ships several concrete Field API /
Feeds / Validation plugins.

## Field type — `isbn`

`src/Plugin/Field/FieldType/IsbnItem.php`, annotation `@FieldType(id="isbn")`.
- `default_widget = "isbn_widget"`, `default_formatter = "isbn_default"`.
- `constraints = {"IsbnValidation" = {}}` — attached to the field and to its `value` property.
- Schema: one `value` column, type `text`, size `tiny`, `not null` FALSE.
- `preSave()` runs `isbn.isbn_service->cleanup()` so only alphanumerics are stored.

## Widget — `isbn_widget`

`FieldWidget/IsbnWidget.php`, `@FieldWidget(id="isbn_widget")`, field_types `{isbn}`.
A `textfield` of `#size => 20`. No widget settings.

## Formatters

| Class | id | Label | Behavior |
|---|---|---|---|
| `IsbnPlainFormatter` | `isbn_default` | Non formatted value | echoes `$item->value` |
| `IsbnFormattedFormatter` | `isbn_formatted_formatter` | ISBN formatted value | `isbn.isbn_service->format($item->value)` |

`IsbnFormattedFormatter` injects the `isbn.isbn_service` service via `create()`.

## Validation constraint — `IsbnValidation`

`Plugin/Validation/Constraint/IsbnConstraint.php` (`@Constraint(id="IsbnValidation")`) plus
`IsbnConstraintValidator`. The validator calls `isbn.isbn_service->isValidIsbn()`; on a
false result it adds a violation `"%isbn" isn't a valid ISBN number.`. You can attach this
constraint to any string property/field to get ISBN validation, not only the `isbn` field.

## Feeds target — `isbn`

`src/Feeds/Target/Isbn.php`, `@FeedsTarget(id="isbn", field_types={"isbn"})`, extends
`FieldTargetBase` — a trivial mapper letting the [Feeds](https://www.drupal.org/project/feeds)
module import into ISBN fields. Only relevant when Feeds is installed.

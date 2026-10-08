<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ISBN adds a dedicated `isbn` field type to Drupal that stores, validates, and formats 10- and 13-digit ISBNs, backed by the `nicebooks/isbn` PHP library.

---

The module registers a Field API field type (`isbn`) with its own widget (`isbn_widget`, a plain text field) and two formatters: `isbn_default` ("Non formatted value") outputs the stored string as-is, while `isbn_formatted_formatter` ("ISBN formatted value") runs the value through the library's `format()` to insert hyphen grouping. Validation is handled by a Symfony/Typed Data constraint (`IsbnValidation`) whose validator calls `IsbnToolsService::isValidIsbn()`; an invalid ISBN produces a form error. On save the field item's `preSave()` calls `cleanup()` to strip every non-alphanumeric character, so only the bare digits (and a trailing `X` check digit) are stored. All library access goes through the `isbn.isbn_service` service (interface `IsbnToolsServiceInterface`), which wraps `Nicebooks\Isbn\IsbnTools` and exposes `format()`, `isValidIsbn()`, `convertIsbn10to13()`, `convertIsbn13to10()`, and `cleanup()`. The module also ships a Feeds target plugin (`isbn`) so ISBN fields can be mapped during a Feeds import. There is no settings form, no configure route, no permissions, and no config schema of its own — you use it entirely by adding an ISBN field to an entity bundle. The `nicebooks/isbn` library is a hard requirement enforced by `hook_requirements()`.

---

- Add an ISBN field to a "Book" content type to store each book's identifier.
- Validate that editors only enter well-formed ISBN-10 or ISBN-13 numbers.
- Store ISBNs stripped of hyphens/spaces so lookups and de-duplication are consistent.
- Display an ISBN with proper hyphen grouping using the "ISBN formatted value" formatter.
- Display the raw ISBN digits with the "Non formatted value" formatter.
- Reduce catalog record duplication by normalising ISBNs at save time.
- Map an incoming feed column to an ISBN field via the Feeds `isbn` target.
- Convert an ISBN-10 to an ISBN-13 programmatically with `convertIsbn10to13()`.
- Convert a 978-prefixed ISBN-13 back to an ISBN-10 with `convertIsbn13to10()`.
- Format an arbitrary ISBN string in custom code via the `isbn.isbn_service` service.
- Check ISBN validity in a custom form or REST handler with `isValidIsbn()`.
- Clean up user-supplied ISBN input (remove punctuation) with `cleanup()`.
- Build a library catalogue where each item carries a validated ISBN.
- Add ISBN metadata to media entities representing scanned books.
- Attach an ISBN to a Commerce product variation for a bookstore.
- Enforce ISBN validity on a taxonomy term (e.g. a "Series" reference dataset).
- Provide a machine-readable ISBN in a JSON:API/REST resource by exposing the field.
- Reuse the same ISBN field across multiple content types for consistent storage.
- Present ISBNs consistently regardless of how editors typed them (with/without dashes).
- Support both ISBN-10 and ISBN-13 in one field without separate handling.
- Migrate legacy book data into a normalized ISBN field.
- Flag bad ISBNs at data-entry time rather than on export.
- Use the constraint on a custom string property to validate ISBNs outside the field type.

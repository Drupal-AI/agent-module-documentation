<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ISBN — agent index

Adds an `isbn` **field type** that stores, validates and formats ISBN-10 / ISBN-13 numbers,
using the `nicebooks/isbn` library. No settings form, no configure route, no permissions,
no config schema of its own. You use it by adding an ISBN field to a bundle.

- **Add / configure an ISBN field, pick a widget & formatter** →
  [configure/field.md](configure/field.md)
- **Field type, widget, formatters, validation constraint, Feeds target (the plugins)** →
  [plugins/plugins.md](plugins/plugins.md)
- **Call the `isbn.isbn_service` service (format / validate / convert / cleanup)** →
  [api/service.md](api/service.md)

Key facts:
- Field type id `isbn`; default widget `isbn_widget`; formatters `isbn_default`
  ("Non formatted value") and `isbn_formatted_formatter` ("ISBN formatted value").
- Validation constraint id `IsbnValidation`; invalid values are rejected on the form.
- Stored value is cleaned on `preSave()` (all non-alphanumeric characters stripped).
- Requires the `nicebooks/isbn` composer library (enforced by `hook_requirements()`).

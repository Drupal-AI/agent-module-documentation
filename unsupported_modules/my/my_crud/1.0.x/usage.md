<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
my_crud (project `basic_crud_operation_in_drupal_sites`) is a small example module that shows how to build create, read, update and delete screens over a custom `my_crud` table with Drupal's database and Form APIs.

Use it as a learning reference for hand-rolled CRUD - not as a production feature.

---

Install with `composer require drupal/basic_crud_operation_in_drupal_sites` and enable the `my_crud` module (`drush en my_crud`). It creates a `my_crud` table (id, name, age) on install.

Browse records at `/my_crud` (permission `access content`), add/edit at `/my_crud/form/data`, and delete at `/my_crud/form/delete/{cid}`. The add/edit and delete routes declare `_permission: 'TRUE'`, which is not a real permission - so those forms are effectively reachable only by user 1, an unintentional lock-out rather than an open door.

---

- Demonstrate CRUD against a custom database table.
- List stored records in a themed table at `/my_crud`.
- Add new records via a Form API form.
- Edit an existing record by `?id=` query parameter.
- Delete a record with a confirmation form.
- Use the database API `select`/`insert`/`update`/`delete` builders.
- Bind query conditions with placeholders (no string-concatenated SQL).
- Validate that the name field contains letters only.
- Validate that the age field is numeric.
- Create the `my_crud` table via `hook_schema` on install.
- Serve the listing under the `access content` permission.
- Show status messages after each operation.
- Provide Edit/Delete links per row.
- Act as reference/example code for module developers.
- Support Drupal 8, 9 and 10.
- Illustrate redirecting back to a listing route after submit.
- Keep the footprint minimal (one table, one controller, two forms).
<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Autoincrement defines an atomic auto increment field type with prefix and suffix.

---

Field Autoincrement defines an **atomic auto-increment field type** — each new entity gets the next
sequential number (optionally with a configured **prefix/suffix**), generated atomically so concurrent saves
don't collide, useful for invoice/reference/ticket numbers. It depends on core Field, in the Field types
package.

Use it for sequential per-entity numbers. It is a fields feature; it generates and stores a number (its
atomicity avoids duplicate numbers under concurrency) and it has no content or access role. Add the
autoincrement field to a bundle.

---

- Generate atomic auto-increment numbers.
- Add a prefix/suffix.
- Number invoices/references/tickets.
- Avoid collisions under concurrency.
- Depend on core Field.
- Assign sequential numbers.
- Generate atomically.
- Have no content/access role.
- Add the field to a bundle.
- Handle autoincrement.
- Number entities.
- Configure the field.
- Assign numbers.
- Handle the field.
- Generate sequences.
- Configure numbering.
- Handle numbering.
- Add sequential IDs.
- Add the field.
- Provide auto-increment.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allow Only One — configure uniqueness (allow_only_one)

Add an **Allow Only One** field to a node type or vocabulary, then open the field's
settings to declare which field combination must be unique.

## Steps
1. *Structure → Content type → Manage fields → Add field* → **Allow Only One**
   (field type id `allow_only_one`). The field stores nothing meaningful (a dummy
   tiny-int column); it exists only to carry validation config.
2. On the field settings form, under **Unique field combinations**, tick every field
   that together forms the unique key. Checked field machine names are saved as
   third-party settings under the `allow_only_one` namespace.
3. Optional toggles:
   - **Title** — include the node title / term name in the unique key.
   - **Case Sensitive / Case Insensitive** — only applies when Title is ticked
     (`LIKE BINARY` vs `LIKE`).
   - **Limit validation to published entities** — unpublished entities are skipped
     and only published matches count.

## How validation works
`AllowOnlyOneConstraintValidator::validate()` builds an entity query for the same
bundle, adds one `condition()` per selected field value, excludes the current entity
by id, and (optionally) `status = 1`. If a match is found the save is blocked with a
message linking to the existing content. Only `node` and `taxonomy_term` entity types
are supported (`entityTypeAllowed()`).

## Notes
- Validation runs on entity save (create/edit) via the field's `getConstraints()`.
- Empty field values are ignored when composing the key.
- The lookup query uses `accessCheck(FALSE)`, so the violation message can reference a
  matching entity the editor could not otherwise see (URL + title). Low-impact, but be
  aware when the matched content may be unpublished/restricted.

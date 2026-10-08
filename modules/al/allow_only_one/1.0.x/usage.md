<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Allow Only One enforces that a chosen combination of field values (optionally the title) is unique across a node type or vocabulary, blocking duplicate content on save.

---

The module ships an `allow_only_one` field type whose only job is to hold validation config: you add it to a content type or vocabulary, then in the field settings tick the fields that together must be unique. It stores nothing meaningful on the entity (a dummy tiny-int column exists only because Drupal requires one); the checked field machine names are persisted as third-party settings.

On every create/edit, `AllowOnlyOneConstraintValidator` runs an entity query scoped to the same bundle, adds one condition per selected field value, excludes the current entity, and optionally restricts to published entities. If a match exists the save fails with a violation linking to the existing content. Title can be added to the key with case-sensitive (`LIKE BINARY`) or case-insensitive matching. Only `node` and `taxonomy_term` are supported. The lookup uses `accessCheck(FALSE)`, so a violation can reference content the editor cannot otherwise view.

Typical setup is a one-time field-add plus ticking the right boxes; there is no admin settings page, Drush command, or API surface beyond the field settings form.

---

- Add an Allow Only One field to a content type to configure uniqueness
- Add the field to a taxonomy vocabulary to enforce unique terms
- Require a single field (e.g. an SKU) to be unique per bundle
- Require a combination of two or more fields to be unique together
- Include the node title in the unique key
- Include the term name in the unique key
- Enforce case-sensitive title uniqueness
- Enforce case-insensitive title uniqueness
- Limit uniqueness checks to published entities only
- Allow duplicate values among unpublished drafts
- Prevent duplicate email/reference/date field combinations
- Block a second node with the same field values on save
- Show editors a link to the existing conflicting content
- Combine several category/reference fields into a composite key
- Enforce one-node-per-user style constraints via a user reference field
- Keep vocabularies free of duplicate term/field combinations
- Reconfigure the unique key later by editing field settings
- Temporarily relax validation by unchecking fields in settings

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Prefix lets administrators change or remove the `field_` prefix that Drupal's Field UI prepends to new field machine names. This is useful for teams with naming conventions or when migrating content models that expect specific machine names.

---

- Requires core `field_ui`; Drupal 8/9/10.
- Enable with `drush en field_prefix`.
- Configure at `admin/config/field_prefix/setting` (permission: "access administration pages").
- Set a custom prefix, or clear it to create fields with no `field_` prefix.
- The setting applies to subsequently created fields in Field UI.

---

- Replace the default `field_` prefix with a custom one.
- Remove the field prefix entirely for cleaner machine names.
- Align field machine names with a team naming convention.
- Match machine names expected by an existing schema/migration.
- Apply the prefix change site-wide via one setting form.
- Keep using the standard Field UI add-field workflow.
- Reduce verbosity of field machine names.
- Configure via a simple admin settings form.
- Useful when re-creating fields to match another environment.
- Avoid manual machine-name editing on every field.
- Works with any entity type that uses Field UI.
- Applies only to new fields (existing fields unchanged).
- Gate configuration behind an admin permission.
- Simplify config export diffs with predictable names.
- Support headless/data-model consistency requirements.
- Help enforce organizational field-naming standards.

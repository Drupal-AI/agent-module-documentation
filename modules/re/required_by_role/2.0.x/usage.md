Required by role is a Required API plugin that makes a field's "required" property depend on the editing user's roles — the field is required only for the selected roles, effectively exempting all others.

---

The module provides a single `Required` plugin (`RequiredByRole`, id `required_by_role`) for the [Required API](https://www.drupal.org/project/required_api) module (a hard dependency). Required API lets each field instance choose a plugin that decides, at form-build time, whether the field's `#required` flag is set; this module's plugin decides that by comparing the current user's roles against a per-field list of selected roles. On a field's *Manage fields* edit form, Required API renders this plugin's settings as a `tableselect` of roles (the "Authenticated user" pseudo-role is removed); the chosen roles are stored as `required_api` third-party settings (`required_plugin` = `required_by_role`, `required_plugin_options` = list of role IDs). At runtime `isRequired()` returns TRUE when the user has any of the selected roles, so the field is required for those roles and optional for everyone else. This is purely a **form validation / UX** feature: it toggles whether a value must be filled in, it does **not** hide the field or grant/deny access to it or to the entity (a field that is not required is still visible and editable). Two update hooks (`_8001`, `_8002`) repair option data shape from earlier versions. The module ships a config schema for the plugin options but no admin settings page, no permissions, and no Drush commands.

---

- Make a field mandatory for editors in one role but optional for another.
- Exempt administrators from a field that content authors must fill in.
- Require a "legal / compliance" field only for external contributor roles.
- Require an internal metadata field for staff while keeping it optional for partners.
- Enforce a required byline/author field only for the "journalist" role.
- Let a "junior editor" role save drafts without completing fields the "editor" role must complete.
- Make a taxonomy/reference field required for specific workflow roles.
- Apply per-role required rules to any field type on any entity (node, user, term, paragraph, media).
- Combine with Required API's other plugins by choosing the per-field required strategy.
- Store the per-field role list in exportable config (`required_api` third-party settings).
- Gradually roll out a new mandatory field by requiring it for one role at a time.
- Keep a migration-only field optional for the migration role but required for manual editors.
- Reduce form friction for high-trust roles while enforcing completeness for others.
- Require different sets of fields for different editorial teams via their roles.
- Audit which fields are role-conditionally required by reading the field's third-party settings.

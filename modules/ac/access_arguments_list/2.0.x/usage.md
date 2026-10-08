Shows each permission's machine name (the "access argument") under its row on the admin permissions page, with click-to-copy.

---

Access Arguments List is a small developer/site-builder convenience module. When enabled it alters
the core permissions form at `/admin/people/permissions` so that every permission row displays its
machine name — the string you pass as `_permission:` in a `*.routing.yml` requirement or to
`AccountInterface::hasPermission()`. Clicking a machine name copies it straight to the clipboard.
The module has no configuration, no settings page, and no permissions of its own; it depends only
on the core `user` module and works on Drupal 9.3, 10, and 11. All of its logic lives in a single
`.module` file plus a small CSS/JS library, and the whole feature is gated by core's existing
`administer permissions` access on that page.

---

- Look up the exact machine name of any permission without grepping through module `*.permissions.yml` files.
- Copy a permission machine name to paste into a `*.routing.yml` `requirements: _permission:` line.
- Copy a permission string for use in `$account->hasPermission('...')` checks in custom code.
- Reference the correct permission key when writing an `access` callback for a controller or form.
- Grab the machine name to use in a Views access filter ("Permission" access plugin).
- Find the machine name behind a human-readable permission label you see in the UI.
- Confirm the machine name a contrib module actually registered for one of its permissions.
- Teach new developers which permission label maps to which machine name.
- Speed up writing custom access checks by copying permission strings directly from the UI.
- Verify a permission machine name before adding it to a `user.role.*.yml` config export.
- Use the copied string in a `hook_permission`-style dependency check or update hook.
- Identify permission names for use in automated tests (`$this->drupalCreateUser([...])`).
- Look up permission keys when scripting role assignment via Drush (`drush role:perm:add`).
- Cross-check a permission machine name when debugging why an access check fails.
- Copy permission strings for documentation or an access-control matrix spreadsheet.
- Help site builders map business roles to the underlying permission machine names.
- Provide a quick on-page reference during permission audits and access reviews.
- Avoid typos in permission names by copying rather than retyping them.
- Discover machine names for permissions defined dynamically (via a permission callback) that are not in a static YAML file.
- Support module development where you need to reference another module's permission as a dependency.

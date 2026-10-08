<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Json Users Import creates Drupal user accounts in bulk from a block of JSON pasted into an admin form.
---
An admin pastes a JSON array of user objects at `/admin/people/json_users_import`; on submit a batch (`json_users_import_creating_users_batch`) iterates the array, validates each username, skips rows whose email or username already exists, and otherwise calls `JsonUsersImportController::createUser()`. Each created account is set active with a random 7-character password, its email/username taken from the JSON keys configured on the settings form (`/admin/config/people/json_users_import_config`), and any additional user fields mapped from JSON keys. Optionally a welcome email is sent (via the required SMTP module / mail manager) containing either a one-time login link or the generated password, with token-replaced subject/body.

Security review notes (reported, not a finding recorded here): (1) **No roles are assigned** — `createUser()` never calls `addRole()`, so imported accounts get only the authenticated role; there is no privilege escalation path to admin/elevated roles through the import. (2) Both routes require `_permission: 'json import users'`, but the module ships **no `permissions.yml` defining that permission**, so the permission is undefined and the forms are reachable only by user 1 (superuser bypass) — i.e. locked down more tightly than intended, not an anonymous/overbroad exposure. (3) The importer does create active accounts in bulk, so whoever can reach it (uid 1) can mass-create login-enabled users; there is no anonymous or unauthenticated access. Email body is `Html::escape()`d. Neither form implements server-side `validateForm` logic beyond the per-row username checks in the batch.
---
- Paste a JSON array to import many users at once.
- Map the JSON email key to the user mail field.
- Map the JSON username key to the account name.
- Map additional JSON keys to custom user fields.
- Skip users whose email already exists.
- Skip users whose username is already taken.
- Validate usernames (spaces, length, illegal characters).
- Create active accounts with a random password.
- Send a welcome email with a one-time login link.
- Send a welcome email containing the generated password.
- Customise the welcome email subject and body with tokens.
- Toggle whether welcome emails are sent at all.
- Migrate users from another portal delivered as JSON.
- Run the import as a batch to handle large lists.
- Restrict the import to the intended admin permission (define `json import users`).
- Review created-user log entries in the `json_users_import` channel.
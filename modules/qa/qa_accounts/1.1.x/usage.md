QA Accounts creates one dummy user per user role to speed up manual and automated testing, giving each account a username, email and **password all derived from the role machine name** (`qa_<role>`). It is a development-only tool and must never be enabled in production.

---

On install (and on demand via Drush) the module iterates every user role except `anonymous` and creates an active account named `qa_<role_machine_name>` — for example `qa_editor`, `qa_administrator` — with email `qa_<role>@example.com` and the password set to the same string as the username (`$user->setPassword($username)`). Each account is granted its matching role (the `authenticated` account gets no extra role, since all users are authenticated). Accounts are idempotent: creating skips a name that already exists. A settings form (`/admin/config/people/qa-accounts`, config `qa_accounts.settings`) exposes two off-by-default toggles — `auto_create_user_per_new_role` and `auto_delete_user_per_deleted_role` — that hook `hook_user_role_insert`/`hook_user_role_delete` so a QA account is spawned or removed whenever a role is added or deleted. Two Drush commands (`qa_accounts:create` / `qa_accounts:delete`, plus legacy `qa-accounts-test-users-create/-delete` aliases) create or tear down the full set on demand. All creation/deletion runs through the `qa_accounts.create_delete` service (`QaAccountsCreateDelete`). Because the credentials are predictable and the accounts are active with real roles, the module is explicitly documented as unsafe for production; there is no environment guard in code.

---

- Quickly get a login for every role on a development site without hand-creating users.
- Log in as `qa_editor`, `qa_administrator`, etc. using the role name as both username and password.
- Seed test users automatically right after installing the module (via `hook_install`).
- Regenerate the full set of role accounts after adding roles with `drush qa_accounts:create`.
- Tear down all QA accounts before a demo or handoff with `drush qa_accounts:delete`.
- Auto-create a matching QA user whenever a new role is created (enable `auto_create_user_per_new_role`).
- Auto-delete the matching QA user whenever a role is deleted (enable `auto_delete_user_per_deleted_role`).
- Give manual QA testers a consistent, memorable credential scheme across environments.
- Provide fixed logins for browser-automation / behat / cypress smoke tests in CI dev builds.
- Test role-based access control by switching between the per-role accounts.
- Verify a permission change by logging in as the role's QA account.
- Reproduce a role-specific bug by using that role's dedicated account.
- Populate a fresh scratch site with representative users for screenshots or training.
- Confirm which roles exist by listing the generated `qa_*` accounts.
- Clean up leftover QA users for a deleted role automatically.
- Use the `qa_accounts.create_delete` service from custom setup code to create a single role's account.
- Recreate one role's account programmatically with `createQaAccountForRole($role_name)`.
- Delete one role's account programmatically with `deleteQaAccountForRole($role_name)`.
- Standardize test credentials so QA scripts do not need per-environment configuration.
- Bootstrap users for a multi-role workflow test (author → reviewer → publisher).
- Provide throwaway accounts for accessibility or UX testing sessions on a dev copy.

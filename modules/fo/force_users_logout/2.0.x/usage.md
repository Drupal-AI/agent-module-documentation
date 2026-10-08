<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Force Users Logout gives an administrator three small admin forms that destroy other people's sessions — one named user, everyone holding selected roles, or every authenticated user except the administrator role — so they are immediately signed out.

---

The module is UI-only: three `ConfigFormBase` forms plus one JSON autocomplete controller, all mounted under `/admin/config/force-users-logout/*` and all gated by core's `administer users` permission (it defines **no permissions of its own**, ships **no config schema**, no services, no plugins and no Drush commands). Each form ends by calling `\Drupal::service('session_manager')->delete($uid)`, which deletes that user's rows from the `sessions` table, so the next request from that browser is anonymous. *Individual User* takes a username through an autocomplete that returns `name (uid)` strings and parses the uid back out of the parentheses. *Role Based* lists roles and logs out every active (`status = 1`) user holding a checked role. *All Other Users* logs out every active user who is neither in the `administrator` role nor anonymous. The role option lists deliberately exclude `administrator`, `authenticated` and `anonymous`, so a site with no custom roles shows an empty checkbox list. Nothing is stored: despite extending `ConfigFormBase`, the forms are actions, not settings — `force_users_logout.individual_user_form` (the `configure` route) is simply the first tab.

---

- Sign out a single user immediately after revoking their access or offboarding them.
- Kick every non-admin user off the site before switching it into maintenance mode.
- Terminate all sessions for an "editor" role after a shared password leaked.
- Force a re-login so newly granted roles and permissions take effect for a user right away.
- Clear a stuck session for a user who reports being logged in as the wrong account.
- Log out everyone before a database restore or a major content migration.
- Respond to a security incident by dropping all authenticated sessions except administrators.
- Log out a contractor's account at the end of an engagement without deleting the account.
- Force re-authentication after changing the session cookie lifetime or SSO configuration.
- Give a helpdesk role a one-click way to end a suspicious session.
- Empty stale sessions before running a load test so the numbers are clean.
- Log out all members of a "students" role at the end of a term.
- Terminate sessions for a role that is about to be deleted.
- Sign out a user whose account you have just blocked so the block takes effect instantly.
- Push out a forced re-login after enabling two-factor authentication for a role.
- Verify session handling in a staging environment by killing sessions and watching the redirect to login.
- Combine with a deployment script that ends editor sessions before content freeze.
- Log out a user before impersonating them with a masquerade-style workflow.
- Reset a user's session after correcting a wrong role assignment.
- Clear sessions belonging to bot or test accounts created during QA.
- Give an admin an audited, in-UI alternative to `DELETE FROM sessions` in the database.
- Force logout of all users after rotating the site's `hash_salt`-adjacent settings.
- Terminate the sessions of a role that just lost the `access content` permission.
- Log out everyone but yourself before doing risky configuration work in the admin UI.

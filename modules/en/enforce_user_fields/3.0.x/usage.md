<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enforce User Fields forces logged-in users to complete required user-account fields, redirecting them to their own profile edit form until every required field is filled.

---

Install with `composer require drupal/enforce_user_fields` and enable it (`drush en enforce_user_fields`); it needs Drupal core **11.1+** and PHP **8.3+**. It adds no "which fields" setting — instead it uses your existing field configuration: mark any user field **required** on `admin/config/people/accounts/fields`, and from then on any user who logs in with that field empty is caught. Mechanically, at login the module scans the user's fields and stores a flag in the session; on the next non-AJAX page load an event subscriber shows the configured error **message** and redirects the user to `/user/<id>/edit`, and the flag clears automatically once the account form is saved with the fields filled. Configure it at **Administration › Configuration › People › Enforce user fields** (`/admin/config/people/enforce-user-fields-settings`, permission *administer site configuration*): set the **Message** and an optional **Pages to not enforce** whitelist (one path per line, `*` wildcard, `<front>` for the front page). Grant the **`bypass enforce user fields`** permission to roles that should never be redirected (e.g. administrators). Built-in exemptions keep users from being trapped: the edit form, logout, password-reset login, image-style and CSS/JS asset routes are always skipped, AJAX requests are ignored, and anonymous users are never affected. It also integrates with the **Multiple Registration** module so per-role registration fields are only enforced for the relevant roles. Typical uses: backfilling a newly added required field for existing accounts, or forcing users who registered via a third-party/social login (which could not supply the data) to complete their profile before using the site.

---

- Force users to complete required profile fields before browsing.
- Backfill a newly added required user field for existing accounts.
- Require third-party / social-login users to complete missing profile data.
- Redirect users with incomplete profiles to their account edit form.
- Set a custom "please complete your profile" error message.
- Whitelist specific paths that stay accessible during enforcement.
- Exempt the front page from enforcement with `<front>`.
- Use `*` wildcards to whitelist whole path sections (e.g. `/user/*`).
- Grant `bypass enforce user fields` to trusted roles.
- Let administrators skip the enforcement flow entirely.
- Keep users able to log out while enforcement is active.
- Preserve the one-time password-reset login token across the redirect.
- Avoid redirect loops via the built-in skip-route allowlist.
- Leave AJAX requests unaffected so background calls still work.
- Only enforce fields required by your existing field configuration.
- Enforce per-role fields correctly alongside the Multiple Registration module.
- Override the check from code via the alter hook for special cases (e.g. never user 1).
- Improve data quality and profile completeness across the user base.
- Translate the prompt message through the Config Translation UI.
- Configure the message and whitelist from code via `enforce_user_fields.settings`.
- Restrict who can change the settings with *administer site configuration*.
- Test enforcement on staging before enabling it in production.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mass Password Change adds two bulk user operations to the people screen: email selected accounts a one-time password-reset link, or set one new password across every selected account at once.

---

The module is not a single "reset everyone" button; it ships two core Action plugins that appear in the bulk-operations dropdown on `/admin/people` and in Views Bulk Operations (VBO). You tick the accounts you want, choose an action, and confirm. The two actions do quite different things and it matters which you pick. **Password reset** sends each selected user the standard Drupal one-time login link by email (`_user_mail_notify('password_reset')`); it does **not** change or invalidate the stored password — nothing happens to an account until that user actually clicks the link and sets a new password, and if site mail does not deliver, nothing happens at all. **Change password** instead shows a confirmation form with a single password field, and writes that **one** password onto **every** selected account, so all of them end up sharing the same known credential until each user changes it. Both actions are gated by the core **`administer users`** permission (a `restrict access: TRUE` permission) and both exclude user 1 and the acting administrator from the selection; the reset action additionally excludes blocked accounts. There is no batch API — the selected accounts are processed in a single synchronous request, so very large selections can hit PHP time or memory limits. The module has no settings page and defines no permissions of its own; it depends only on core `user`, and `views` is needed for the VBO integration. Version **2.0.0**, core `^10.4 || ^11.1`.

---

- Email a one-time reset link to a group of users after a suspected credential leak.
- Trigger Drupal's standard password-reset email for many accounts at once.
- Force a set of imported/migrated accounts (whose password hashes could not be carried over) to establish a password.
- Send reset links to everyone in a role by selecting them in a View with VBO.
- Set a single temporary password across a batch of newly provisioned accounts.
- Hand a team of testers one shared, known password for a set of QA accounts.
- Reset passwords for a class or cohort of training accounts before a session.
- Push a one-time login link to dormant users as part of a re-activation campaign.
- Invalidate a shared/vendor credential by reset-mailing the accounts that used it.
- Re-issue login links to users after a mail-provider outage previously swallowed them.
- Apply a "please reset your password" prompt to a filtered View of stale accounts.
- Bulk-onboard a supplier list by setting a common initial password and asking them to change it.
- Clear out weak legacy passwords by mailing every affected account a reset link.
- Respond to a phishing wave by reset-mailing the targeted user segment.
- Select users on `/admin/people` and reset them without visiting each profile.
- Give an events/membership team a way to reset attendee accounts in one pass.
- Reset a support queue of locked-out users in a single confirmed action.
- Prepare a staging refresh by setting one known password on all non-admin accounts.
- Reset accounts flagged by an audit as needing new credentials.
- Push a policy-driven credential refresh to a bounded, hand-picked group of users.

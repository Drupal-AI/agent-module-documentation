<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notify User Default flips one checkbox: on the admin *Add user* form, "Notify user of new account" is ticked by default, so accounts created by staff send the welcome email unless someone deliberately opts out.

---

When an administrator creates an account at `/admin/people/create`, Drupal shows a *Notify user of new account* checkbox that is **unchecked** by default. The result is a familiar support problem: an account is created, nobody is told, and the new user waits for an email that was never sent. This module is a single `hook_form_user_register_form_alter()` that sets `$form['account']['notify']['#default_value'] = TRUE` when that element exists (it only exists for users with the permission to create accounts for others, so the alter is a no-op on the public registration form). That is the entire behaviour — no configuration, no permissions, no schema, no services, no Drush. The checkbox remains editable, so an administrator creating a placeholder or service account can still untick it.

---

- Make sure staff-created accounts always get their welcome email.
- Stop new users waiting for a notification that was never sent.
- Reduce helpdesk tickets about missing account emails.
- Keep the default sensible while allowing an opt-out per account.
- Apply the behaviour without training every administrator.
- Ensure onboarding emails are sent during bulk account setup.
- Give contractors their credentials automatically on creation.
- Avoid a custom form alter in a site module.
- Standardise account-creation behaviour across a multisite.
- Keep the public registration form untouched.
- Support a policy that every real account is notified.
- Make the notification the default for a helpdesk workflow.
- Prevent silent account creation during migrations run through the UI.
- Let administrators still untick for service accounts.
- Deploy the change as a module rather than a patch.
- Align Drupal with expectations from other systems.
- Reduce onboarding delays for new starters.
- Ensure password-reset emails follow account creation.
- Keep behaviour consistent after a core upgrade.
- Remove the module to restore core behaviour instantly.

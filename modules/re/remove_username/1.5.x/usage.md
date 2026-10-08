<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remove Username hides the separate "Username" field from Drupal's user register/edit/login/password forms, makes the email address required, and copies the email into the account's `name` (username) field so users identify themselves by email only.

---

The module has no configuration, no admin page, no permissions and no services — it is a set of `hook_form_FORM_ID_alter()` implementations plus a `hook_ENTITY_TYPE_presave()` hook. On the user register and edit forms it hides `account][name` (`#access = FALSE`), makes `account][mail` required, and prepends a validation handler (`remove_username_prepare_form_user_values`) that copies the submitted email into the `name` value, checks it is not already taken with `user_load_by_name()`, and runs it through `user_validate_name()`. On the login and password-reset forms it just relabels the "Username" field to "Email address". A post-validation handler on the register form clears any error attached to the hidden `name` element. The decisive piece is `remove_username_user_presave()`, which on every user save sets the username equal to the email (`$user->setUsername($user->getEmail())`) — so username always tracks email, even for programmatically created accounts. It also alters the Commerce checkout flow (`commerce_checkout_flow`) to relabel the returning-customer field and hide the register username field. On install, `remove_username_install()` walks every existing non-anonymous user and copies their email into their username. Because the username is still stored (just hidden and set to the email), Drupal's uniqueness rules on `name` continue to apply.

---

- Let site visitors register and log in with just an email address, with no separate username to invent or remember.
- Remove the "Username" field from the account registration form entirely.
- Remove the "Username" field from the user account edit form so people cannot change it away from their email.
- Relabel the "Username" prompt to "Email address" on the login form.
- Relabel the "Username" prompt to "Email address" on the forgotten-password (`user/password`) form.
- Force every account's username to equal its email address automatically on save.
- Backfill existing users' usernames to their email addresses at install time.
- Keep programmatically created users (migrations, feeds, custom code) consistent by having `user_presave` copy email into username.
- Simplify Commerce checkout by hiding the register username field and labelling the returning-customer field "Email address".
- Present an email-first identity model without writing custom form alters.
- Avoid duplicate-identity confusion where a user has both a username and an email.
- Reduce registration friction / abandoned sign-ups caused by the extra username field.
- Standardise on email as the single login credential across a membership site.
- Ensure the email is required on registration even if the site previously allowed empty values.
- Prevent users from picking a display username different from their email.
- Provide an email-as-username experience similar to modern SaaS apps.
- Make bulk-imported customer accounts use their email as username without post-processing.
- Keep Drupal core's username uniqueness validation while surfacing it as an email conflict message.
- Give a cleaner sign-up UX for sites that only ever email their users.
- Migrate a legacy site to email-based identity by enabling one module.
- Hide username on both create-by-admin (`/admin/people/create`) and self-registration flows.

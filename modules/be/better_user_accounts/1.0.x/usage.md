Better User Accounts is a small UX module that customizes the user account view/edit local-task tab labels and can hide the obsolete "current password" retype field on the account edit form.

---

Better User Accounts (package "User interface", depends only on core `user`) applies two focused, config-driven improvements to Drupal's stock user account pages. First, it overrides the titles of the two local-task tabs on a user page — the account "View" tab (`entity.user.canonical`) and the account "Edit" tab (`entity.user.edit_form`) — with administrator-supplied labels, via `hook_menu_local_tasks_alter()`. Second, when enabled, it makes the account edit form's "Current password" retype field (`current_pass`) client-side conditional through `#states`, so it only shows when the user is actually changing the email or password — reducing confusion. All behavior is driven by one config object, `better_user_accounts.settings`, edited on a single admin settings form at `/admin/config/people/better-user-accounts`, gated by the `administer better user accounts configuration` permission. There are no entities, services, plugins, or Drush commands. The module does not change who can view or edit which account — it only relabels tabs and toggles field visibility within Drupal core's existing user access system.

---

- Rename the user account "View" tab (e.g. to "My profile" or "User account").
- Rename the user account "Edit" tab (e.g. to "Account settings").
- Present clearer, brand-consistent local-task labels on every user page.
- Localize/translate the tab labels through the config-translation tab on the settings form.
- Hide the "Current password" retype field on the account edit form when it is not needed.
- Reduce confusion for end users editing their own account details.
- Keep the current-password prompt visible only when the email or password is actually being changed.
- Configure both features from one place: Administration » Configuration » People » Better User Accounts settings.
- Grant a non-admin role the `administer better user accounts configuration` permission to delegate only these label/UX settings.
- Leave a label blank to fall back to Drupal's default tab title.
- Standardize account-page wording across a multisite via exported config.
- Improve first-time-user experience on registration-heavy sites.
- Ship a cleaner account edit form without writing a custom form alter.
- Adjust the account UI purely through configuration (no code).
- Provide translatable account-tab labels for multilingual sites.
- Combine with core User permissions to control who edits accounts (this module does not change that).
- Use on Drupal 10.3+ or 11 sites needing lightweight account-page polish.
- Keep the account edit form's default password-verification behavior intact server-side.
- Export the `better_user_accounts.settings` config for repeatable deployment.
- Enable the current-password hide feature per environment via config override.

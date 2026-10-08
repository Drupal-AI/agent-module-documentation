Account Field Split breaks Drupal core's single, monolithic "User name and password" element on the account form into individual pseudo-fields (Username, E-mail address, Password, Current password, Roles, Status, Notify) so each can be reordered, hidden, or grouped independently in the standard Manage form display UI.

---

Out of the box, Drupal renders the user register/edit form's identity fields inside one bundled, draggable "User name and password" row on `admin/config/people/accounts/form-display`, so a site builder cannot move the e-mail above the username, hide the password, or drop individual pieces into a field group. Account Field Split fixes this by declaring the seven inner elements — `name`, `mail`, `pass`, `current_pass`, `roles`, `status`, `notify` — as extra (pseudo) fields via `hook_entity_extra_field_info`, and by removing the combined `account` element from the form-display list via `hook_entity_extra_field_info_alter`. A `hook_form_alter` then lifts the real form widgets out of the core `account` container to the top level of the form so the weights and regions you set in Manage form display actually take effect. The module has no settings form, no permissions, no config schema and no Drush commands of its own — all configuration is the standard `core.entity_form_display.user.user.default` config entity that Field UI already writes. It sets its own module weight to 101 on install so its alters run after other modules. It also cooperates with `simple_pass_reset`: on the anonymous password-reset route it skips splitting to avoid breaking that flow. Because the fields become ordinary form-display components, they play nicely with Field Group, per-field weights, and the disabled/hidden region.

---

- Move the E-mail address field above the Username on the user registration form.
- Hide the "Current password" confirmation field on the account edit form via the disabled region.
- Reorder the Password field to appear last on the profile form.
- Place the Roles and Status admin fields into their own field group (with the Field Group module).
- Drop the "Notify user about new account" checkbox to a specific position for admins creating users.
- Show the username and e-mail at the top and push everything else below a custom field.
- Disable the Status field on the account form so editors cannot block accounts from there.
- Give the account identity fields custom weights interleaved with real profile fields (bio, picture).
- Build a cleaner, reordered registration form without a custom form_alter in a bespoke module.
- Manage each account field's visibility per view mode / form mode independently.
- Let a site builder rearrange the account form entirely through the admin UI, no code.
- Position the user picture field between the username and e-mail fields.
- Keep the password fields together but move them below address or contact fields.
- Hide the Roles field on the default account form while leaving it available elsewhere.
- Order account fields to match a design mockup for the sign-up page.
- Integrate account identity fields with a multi-step or grouped registration layout.
- Remove the clutter of the bundled account element for a simpler editing experience.
- Reposition the "Notify user" checkbox next to the Status field for admin user creation.
- Expose the split fields for theming/weighting alongside contributed profile fields.
- Configure the account form via exported `core.entity_form_display.user.user.default` config in code.
- Standardise account-form field order across environments through config sync.
- Let the e-mail field lead the form for email-first login/registration UX.
- Move password confirmation fields to sit directly under the new-password field.
- Surface only a subset of account fields on the form by disabling the rest.

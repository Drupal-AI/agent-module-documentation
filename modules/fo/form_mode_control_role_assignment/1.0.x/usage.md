<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Mode Control Role Assignment assigns a configured role to users who register via a specific user form mode.

---

Form Mode Control Role Assignment maps user form modes to roles so that a person registering through a particular user-registration form mode is automatically granted a chosen role. It pairs with the Form Mode Control module's ability to expose alternate registration forms.

An admin form at `/admin/config/people/form-mode-role-mapping` (`administer site configuration`) lists every user form mode and lets an admin pick a role for each, stored in `form_mode_control_role_assignment.settings:role_mappings`. At registration the module reads the active form mode from the request `display` query parameter (`hook_form_user_register_form_alter` hides the roles checkboxes and pre-selects the mapped role) and enforces the grant in `hook_user_presave` by calling `$account->addRole()`. An event subscriber additionally adds the role on the `USER_REGISTER` event using the routed `form_mode` parameter.

Setup: enable Form Mode Control, create user form modes, map each to a role here, then link people to `/user/register?display=<form_mode>`. Map roles appropriate for self-registered users.

---
- Grant a role automatically based on registration form mode.
- Map each user form mode to a specific role.
- Create distinct sign-up flows for different member types.
- Hide the roles checkboxes on the registration form.
- Pre-select and lock the assigned role in the UI.
- Enforce the role in `hook_user_presave`.
- Also apply the role on the user-register event.
- Onboard partners/vendors into a dedicated role.
- Separate customer vs contributor registration paths.
- Configure mappings without code.
- Validate that a mapped role exists before save.
- Log role-assignment attempts for debugging.
- Drive form-mode-specific onboarding.
- Assign a "subscriber" role to a marketing sign-up form.
- Keep default registration role-free while special modes grant roles.
- Reuse Form Mode Control's alternate registration forms.
- Audit which form mode granted a given role.
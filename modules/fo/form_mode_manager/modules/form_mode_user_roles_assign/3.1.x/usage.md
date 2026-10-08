<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Mode Manager User Roles Assign automatically pre-assigns one or more user roles when a person registers (or is created) through a specific Form Mode Manager user form mode — so, e.g., anyone signing up via a "partner" registration form mode gets the "partner" role by default.

---

The submodule targets the user register/create routes that Form Mode Manager generates for user form modes. Its `FormAlter` service (bridged from `hook_form_alter`) checks that the current route is a Form Mode Manager route for the `user` entity type and matches the register/create path pattern (`/user/register/…` or `/admin/people/create/…`); it then reads the roles configured for that form mode from `form_mode_user_roles_assign.settings` at `form_modes.user_<form_mode>.assign_roles` and sets them as the default value of the register form's roles element. Configuration is edited at `/admin/config/content/form_mode_manager/role-assign` (route `form_mode_manager.admin_settings_roles_assign`, form `FormModeManagerRolesForm`, permission `administer site configuration`), where each user form mode can be mapped to a list of role ids. It requires the parent Form Mode Manager module plus core `field` and `user`. Note it pre-populates the roles on the form (defaults), building on top of Form Mode Manager's user form-mode routes.

---

- Auto-assign a "partner" role to users who register through a partner-specific user form mode.
- Give members signing up via a dedicated form mode a default role without manual admin steps.
- Pre-select roles on the `/admin/people/create/<mode>` form for a given user form mode.
- Streamline onboarding by mapping each registration form mode to its appropriate roles.
- Grant a "contributor" role automatically on a contributor registration form mode.
- Assign multiple roles at once for a specialized registration flow.
- Differentiate role defaults between the standard register form and a custom form mode.
- Reduce human error in role assignment for high-volume, role-specific signups.
- Configure role-per-form-mode mappings as exported configuration.
- Support B2B/partner portals where each signup path implies a role.
- Pair with per-form-mode permissions to fully gate a registration workflow.
- Set default roles for staff created through an internal user form mode.
- Keep public self-registration role-free while a special form mode grants roles.
- Map a "reviewer" form mode to a reviewer role for editorial signups.
- Provide event-specific registration form modes that assign attendee roles.
- Adjust which roles a form mode grants by editing one settings form.
- Ensure newly registered users land with the correct permissions immediately.
- Model tiered membership signups (basic vs premium) via distinct form modes and roles.
- Delegate role provisioning to the registration path rather than post-hoc admin edits.
- Test role-assignment flows by mapping a scratch form mode to a scratch role.

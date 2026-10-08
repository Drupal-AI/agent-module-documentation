Multiple Registration lets you create a separate user-registration page for each role, at `/user/register/{role}`, each with its own URL alias, redirect, form mode, and visibility — so different kinds of users sign up through different forms and are granted the right role.

---

For every non-locked role you can create a dedicated registration page. Each page lives at
`/user/register/{rid}` (a route added per role) and, on submit, registers the user and assigns
that role. Pages are configured from *Configuration › People › Multiple registration pages*
(route `multiple_registration.multiple_registration_list_index`); adding one lets you set a **path
alias**, a **redirect path** after submission, the **form modes** used to render the register and
edit forms, and a **hidden** flag (page reachable only by its URL, with no tab). All page
definitions are stored in the config object
`multiple_registration.create_registration_page_form_config`, keyed by role id, each holding
`path`, `url`, `redirect_path`, `hidden`, `form_mode_register`, and `form_mode_edit`; the module
also creates a `path_alias` for the page. Two more config objects hold global options:
`multiple_registration.common_settings_page_form_config` (disable the main `/user/register` page,
redirect authenticated users to their profile, add "Add user" buttons on the People page) and
`multiple_registration.access_settings_page_form_config` (which registration pages anonymous users
may reach). It also adds per-field third-party settings so specific fields can be shown/required
only for specific roles' registration forms. It requires `path_alias`, defines the
`administer multiple_registration` permission, and provides a service
(`multiple_registration.service`) for listing available roles and configured pages.

---

- Create a separate signup page for "vendors" that grants the vendor role.
- Offer a distinct "student" registration form at a friendly URL like `/student-signup`.
- Register "partners" through their own page and auto-assign the partner role.
- Use different form modes so each role's registration form shows different fields.
- Redirect a role's new registrants to a role-specific landing page after signup.
- Hide a registration page from tabs so it is reachable only via its direct URL.
- Give each registration page a clean path alias instead of `/user/register/{rid}`.
- Disable the default `/user/register` page so users must pick a role-specific page.
- Control which registration pages anonymous visitors are allowed to access.
- Add "Add user" buttons per role on the admin People page for quick creation.
- Redirect already-logged-in users away from registration pages to their profile.
- Show or require a particular profile field only on certain roles' registration forms.
- Build separate onboarding flows for B2B vs B2C users.
- Provide a members-only registration page linked from an invitation email.
- Assign multiple audiences their correct role at signup without manual role edits.
- Use a custom "edit" form mode for a role after registration.
- Keep marketing-specific fields off the generic registration form.
- Create role-targeted campaigns each pointing to a dedicated registration URL.
- Programmatically list configured registration pages via the module service.
- Restrict registration so only invited roles have a public signup page.
- Localize or brand each registration page path per audience.
- Manage all per-role registration pages from one admin listing.

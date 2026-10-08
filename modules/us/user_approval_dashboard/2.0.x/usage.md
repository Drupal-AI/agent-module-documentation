<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Approval Dashboard provides an admin dashboard (a View) plus a confirmation form to approve/activate pending user accounts.

---

User Approval Dashboard ships a `dashboard` View listing user accounts and a confirmation form at `/admin/config/dashboard/user-approval` (permission `administer site configuration`). The form reads a user id from the request `id` parameter, loads that user, calls `activate()` and saves, then redirects back to the dashboard - the mechanism admins use to approve accounts created under 'administrator approval' registration. The bundled `user_export` submodule adds a View that exports user field data as JSON/XML/CSV (depends on `rest`, `serialization`, `csv_serialization`). Approval is gated by the admin permission and the form uses the standard Form API (CSRF token), so activation is restricted to authorized admins.

---

- List pending user accounts on a dashboard View.
- Approve (activate) a blocked user account.
- Confirm approval via a dedicated form.
- Redirect back to the dashboard after approving.
- Support administrator-approval registration workflows.
- Restrict approval to admins via permission.
- Load the target account by request id parameter.
- Use standard Form API CSRF protection.
- Export user field data with the submodule.
- Export users as CSV, JSON or XML.
- Review new registrations in one place.
- Activate accounts without editing each user form.
- Provide a reporting View of accounts.
- Bundle export behind rest/serialization deps.
- Manage the account approval queue efficiently.

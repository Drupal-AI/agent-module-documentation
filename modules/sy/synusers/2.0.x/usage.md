<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Synusers adds an admin-only page that exports the site's user list to an Excel (XLSX) spreadsheet.

---

Synusers (package **SynapseF**) is a small, vendor-specific utility that turns a Views listing of
users into a downloadable Excel file. It ships one route, **`/users-xls`** (`synusers.page`,
permission **`administer users`**), whose controller loads a bundled Views view named **`cml_users`**
(the `page` display), runs it with the current exposed-filter values, and writes the visible field
columns to `public://Excel/users.xlsx` using the **PhpSpreadsheet** library, returning the file as a
download. A `hook_views_pre_view()` implementation injects a **"Download Excel"** link into the header
of that view so operators can export the currently filtered list in one click. Despite the page title
"Users upload", the module only **exports** — there is no import/upload path in 2.0.7. The bundled
`cml_users` view is shipped as *optional* config and depends on three custom user fields
(`field_user_name`, `field_user_surname`, `field_user_phone`); on a site without those fields the view
is never installed and both the view page and the export route are non-functional. Requires the core
**Views** module (used by the controller and hook but not declared in `info.yml`) and the
`phpoffice/phpspreadsheet` Composer library.

---

- Export the full user roster to an `.xlsx` file from an admin page.
- Give user administrators a one-click "Download Excel" button on a Users view.
- Produce a spreadsheet of logins, first/last names, phone and email for offline use.
- Hand a user list to non-technical staff who work in Excel.
- Export only the users matching the view's current exposed filters (e.g. active users).
- Generate a users.xlsx snapshot for reporting or archival.
- Feed user data into external tools that consume XLSX.
- Bundle a ready-made "Users" Views listing (the `cml_users` view) with an export action.
- Add an export link into an existing Views user listing via `hook_views_pre_view()`.
- Provide a vendor (SynapseF) suite component for user-list export.
- Restrict export to holders of the `administer users` permission.
- Reuse Views exposed filters/sorts to shape what gets exported.
- Produce column headers from the view's field labels automatically.
- Exclude the operations and status columns from the exported sheet.
- Serve as a lightweight alternative to a full Views data-export display for user data.
- Support Drupal 11 and 12 sites.
- Integrate PhpSpreadsheet into a Drupal user-management workflow.
- Act as an example of driving a Views view programmatically from a controller.
- Deliver an `users.xlsx` download to an administrator on demand.
- Pair with three custom user profile fields (name/surname/phone) that the bundled view expects.

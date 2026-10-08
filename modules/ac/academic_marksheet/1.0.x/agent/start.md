<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Academic Marksheet (academic_marksheet) — agent index

A minimal student-records + grading module. It does **not** use Drupal entities for its domain
data — instead `hook_schema` (`academic_marksheet.install`) creates four custom DB tables, and
`hook_install` creates three taxonomy vocabularies. Package `Other`. Core `^10 || ^11`.
Dependencies: core **`views`, `field`, `user`, `taxonomy`**. License GPL-2.0-or-later. Version 1.0.2.
No config settings form, no config schema, no services, no Drush, no plugins.

- **Data model — the four tables + three vocabularies + the install/uninstall hooks** →
  [schema/data-model.md](schema/data-model.md)
- **Routes, permissions, forms, controllers, CSV import and the PDF export** →
  [routes/dashboards-and-results.md](routes/dashboards-and-results.md)

## What it actually is (from source)

- **Storage:** `academic_marksheet_schema()` defines `student_details`, `faculty`, `students_data`
  and an unused `marks` table (all `serial` PK). `academic_marksheet_install()` creates vocabularies
  `courses`, `semesters`, `academic_year`; `academic_marksheet_uninstall()` deletes them.
- **Permissions** (`academic_marksheet.permissions.yml`, all `restrict access: TRUE`):
  `administer marksheet`, `assign marks`, `view own results`. Note: `view own results` is **declared
  but never referenced** by any route.
- **Routes** (`academic_marksheet.routing.yml`): three `_form` dashboards
  (`/admin/marksheet`, `/teacher/marksheet`, `/student/details`) and five controller routes for
  listing, view result, PDF, update and delete. Full route/permission table in the routes doc.
- **Forms** (`src/Form/`): `AdminDashboardForm` (add faculty + AJAX list), `TeacherDashboardForm`
  (assign marks), `StudentDetailsForm` (manual add + CSV import, injects `request_stack`),
  `StudentUpdateForm`, `StudentDeleteForm`.
- **Controllers** (`src/Controller/`): `StudentResultController` (`studentResultPage`,
  `studentResultPdf` — uses `\TCPDF`), `StudentListingController`, `StudentUpdateController`,
  `StudentDeleteController` (the last two just fetch a row and hand off to a form).
- **Templates** (`templates/*.twig`): `student-result-page.html.twig`, `student-results.html.twig`
  ship with the module but the controllers build markup as strings; no `#theme` hook is registered
  for them, so they are effectively unused dead assets.
- **Hooks** (`academic_marksheet.module`): only `hook_help`.

## Key facts for an agent

- All queries use the DB API (`\Drupal::database()->select/insert/update/delete`) with
  `->condition()` placeholders.
- The **PDF route needs the TCPDF library at runtime** (`new \TCPDF()`), which the module does not
  declare in a composer.json — install `tecnickcom/tcpdf` or the route fatals.
- `student_id` route params are `\d+`-constrained. See the routes doc for each route's path,
  handler, and permission.

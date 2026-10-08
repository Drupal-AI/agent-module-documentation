<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions, forms & controllers

Source: `academic_marksheet.routing.yml`, `academic_marksheet.permissions.yml`, `src/Form/*`,
`src/Controller/*`.

## Permissions (`*.permissions.yml`)

All three declare `restrict access: TRUE`:

- `administer marksheet` — "Administer marksheet" (manage teachers, subjects, results).
- `assign marks` — "Assign marks to students".
- `view own results` — "View own results".

## Routes

| Route id | Path | Handler | Permission requirement |
|---|---|---|---|
| `academic_marksheet.admin_dashboard` | `/admin/marksheet` | `Form\AdminDashboardForm` | `administer marksheet` |
| `academic_marksheet.teacher_dashboard` | `/teacher/marksheet` | `Form\TeacherDashboardForm` | `assign marks` |
| `academic_marksheet.student_dashboard` | `/student/details` | `Form\StudentDetailsForm` | `assign marks` |
| `student_result.page` | `/student-result/{student_id}` | `StudentResultController::studentResultPage` | `access content` |
| `student_listing.page` | `admin/student-listing` | `StudentListingController::studentListingPage` | `access content` |
| `student_update.page` | `/student/update/{student_id}` | `StudentUpdateController::updateStudentPage` | `administer site configuration` |
| `student_delete.page` | `/student/delete/{student_id}` | `StudentDeleteController::deleteStudentPage` | `administer site configuration` |
| `academic_marksheet.student_result_pdf` | `/student-result/pdf/{student_id}` | `StudentResultController::studentResultPdf` | `access content` |

`{student_id}` is constrained `\d+` on the result and PDF routes (not on update/delete). There are
**no** `academic_marksheet.links.menu/task/action.yml` files — no menu links or local tasks are
registered; reach the pages by their paths.

## Forms (`src/Form/`)

- **`AdminDashboardForm`** (`admin_dashboard_form`): three required textfields (`teacher_name`,
  `subject_name`, `subject_code`); `submitForm()` inserts into `faculty`. An AJAX button
  (`viewExistingCallback`) renders a table of existing faculty from `getExistingTeachersAndSubjects()`
  (each cell run through `htmlspecialchars()`).
- **`TeacherDashboardForm`** (`teacher_dashboard_form`): student `select` (from `student_details`),
  subject `select` (from `faculty`), required `number` `marks_obtained`; inserts into `students_data`.
- **`StudentDetailsForm`** (`student_details_form`): injects `request_stack` via `create()`. Manual
  fields (name, roll_no, date `dob`, address, and course/semester/academic-year `select`s populated
  by `getTaxonomyOptions()` which calls `loadTree($vocabulary)`). Two submit buttons:
  - **Add Student** → `submitForm()`: validates required fields, rejects a duplicate `roll_no`
    (SELECT on `student_details`), else inserts. Taxonomy selections are cast `(int)`.
  - **Upload CSV** → `uploadCsvSubmit()`: reads the uploaded file via
    `request_stack->getCurrentRequest()->files->get('files')['student_csv']`,
    `file_system->realpath(...)`, then `fgetcsv($handle, 1000, ',')`. Expects **7 columns**
    (Name, Roll No, DOB, Address, Course, Semester, Academic Year); `getTermIdByName()` looks up or
    **creates** the course/semester/academic-year terms; duplicate roll numbers are skipped with a
    warning. Malformed row counts and invalid terms emit messenger errors.
- **`StudentUpdateForm`** (`student_update_form`): pre-fills from `student_details` (keyed by
  `$student_id['id']`), updates name/roll_no/dob/address, redirects to `student_listing.page`.
- **`StudentDeleteForm`** (`student_delete_form`): a plain `FormBase` (not `ConfirmFormBase`) showing
  an "Are you sure?" markup + Delete submit; `submitForm()` deletes the `student_details` row by
  `id` and redirects to the listing. Being a Drupal form, the delete is a POST protected by the core
  form CSRF token.

## Controllers (`src/Controller/`)

- **`StudentListingController::studentListingPage()`** — selects `id`, `student_name` from
  `student_details`, builds a `#theme => 'table'` with View / Update / Delete `Link`s per row (table
  theme escapes the plain-string cells).
- **`StudentResultController::studentResultPage($student_id)`** — selects the student row, resolves
  course/sem/year terms to names, selects marks from `students_data`, resolves subject names from
  `faculty` (`IN` condition), sums `marks_obtained`, and returns a `#markup` string built with
  inline HTML. Every interpolated value is wrapped in `htmlspecialchars()`. Ends with a "Download PDF"
  link to the PDF route.
- **`StudentResultController::studentResultPdf($student_id)`** — same data assembly, then
  `new \TCPDF()`, `writeHTML($content)`, `Output('', 'S')`, returned as a `Response` with
  `Content-Type: application/pdf` and an attachment `Content-Disposition`. **Requires the TCPDF
  library** (undeclared dependency) or it fatals.
- **`StudentUpdateController` / `StudentDeleteController`** — fetch the `student_details` row (update)
  or pass the raw `$student_id` (delete) into the corresponding form via `formBuilder()->getForm()`.

## Operating notes

- No settings/config route exists; `data.json.configure` is null. Data lives in the custom tables
  from [../schema/data-model.md](../schema/data-model.md).
- The shipped Twig templates are not wired to a theme hook and are unused; markup is built in the
  controllers.
- To grant a teacher access to enter students and assign marks, give the `assign marks` permission;
  faculty/subject administration needs `administer marksheet`; editing/deleting students needs
  `administer site configuration`.

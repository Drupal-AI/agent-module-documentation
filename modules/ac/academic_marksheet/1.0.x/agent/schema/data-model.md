<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data model — tables & vocabularies

Defined in `academic_marksheet.install`. This module stores domain data in **custom DB tables**,
not entities, and provisions taxonomy vocabularies for classification.

## Install / enable

```bash
composer require drupal/academic_marksheet
drush en academic_marksheet -y
```

Dependencies pulled in: core `views`, `field`, `user`, `taxonomy`. For the PDF route to work you
also need the TCPDF PHP library available (e.g. `composer require tecnickcom/tcpdf`) — it is used as
`new \TCPDF()` but is **not declared** by the module.

## Tables (`academic_marksheet_schema()`)

All tables have an autoincrement `id` (`serial`) primary key.

| Table | Columns | Purpose |
|---|---|---|
| `student_details` | `id`, `student_name` (varchar 255), `roll_no` (varchar 20), `dob` (varchar 10, nullable), `address` (text), `sem_id` (int), `course` (int), `academic_year` (int) | One row per student. `sem_id` / `course` / `academic_year` hold **taxonomy term IDs** (tids). |
| `faculty` | `id`, `teacher_name` (varchar 255), `subject_name` (varchar 255), `subject_code` (varchar 50) | One row per teacher+subject. A subject is identified by its `faculty.id`. |
| `students_data` | `id`, `student_id` (int → `student_details.id`), `subject_id` (int → `faculty.id`), `marks_obtained` (int) | One row per (student, subject) mark. This is the table actually read/written for results. |
| `marks` | `id`, `student_id`, `subject_id`, `marks_obtained`, `maximum_marks` | Declared in schema but **never read or written** by any code — dead table (the `maximum_marks` concept is unused). |

There are no foreign-key constraints, no indexes beyond the primary keys, and no config schema
(these are DB tables, not configuration).

## Vocabularies (`academic_marksheet_install()`)

Created if absent, via `Vocabulary::create()`:

- `courses` — "Courses"
- `semesters` — "Semesters"
- `academic_year` — "Academic Year"

`academic_marksheet_uninstall()` loads and `->delete()`s each of these three vocabularies on
uninstall (which also removes their terms). The custom tables are dropped automatically by core
schema teardown; the module does not implement custom uninstall for them.

Term IDs are stored as ints in `student_details`; the result controllers resolve them back to names
with `Term::load($tid)->getName()`, falling back to the literal string `Unknown` when the term is
missing.

## How data flows

1. `AdminDashboardForm` inserts into `faculty`.
2. `StudentDetailsForm` inserts into `student_details` (manual or CSV). CSV import auto-creates
   missing course/semester/academic-year terms via `getTermIdByName()`.
3. `TeacherDashboardForm` inserts into `students_data` (a mark for a student+subject).
4. `StudentResultController` joins `student_details` + `students_data` + `faculty` (via separate
   selects, not SQL joins) to render/print the marksheet, summing `marks_obtained` for the total.

See [../routes/dashboards-and-results.md](../routes/dashboards-and-results.md) for the routes,
permissions and form/controller detail.

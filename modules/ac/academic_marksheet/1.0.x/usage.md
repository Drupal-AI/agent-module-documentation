Academic Marksheet manages student records, subjects and per-subject marks, then renders and exports each student's result as an on-screen marksheet and a downloadable PDF.

---

The module stores its data in four custom database tables it creates on install (`student_details`, `faculty`, `students_data`, and an unused `marks` table) rather than in Drupal entities, and it creates three taxonomy vocabularies — `courses`, `semesters`, `academic_year` — for classifying students. Administrators use an Admin Dashboard to register teachers with their subject and subject code; teachers use a Teacher Dashboard to assign a numeric mark to a student for a chosen subject; and student records are captured either through the Student Details form (with course/semester/academic-year taxonomy dropdowns) or by uploading a seven-column CSV that auto-creates missing taxonomy terms and skips duplicate roll numbers. A student-listing page lists every student with View/Update/Delete actions, and a result page assembles the student's details plus a marks table with a computed total, offering a "Download PDF" link that regenerates the same marksheet through TCPDF. It targets small schools/colleges that need a minimal marks-and-results workflow without building custom entities, and depends only on core `views`, `field`, `user` and `taxonomy`.

---

- Register a faculty member with their subject name and subject code from the Admin Dashboard at `/admin/marksheet`.
- Review all previously added teachers and subjects inline via the dashboard's AJAX "View Existing Teachers and Subjects" button.
- Let a teacher assign a numeric mark to a student for a specific subject at `/teacher/marksheet`.
- Add a single student record (name, roll number, DOB, address, course, semester, academic year) at `/student/details`.
- Prevent duplicate students by rejecting a roll number that already exists on manual entry.
- Bulk-import students from a CSV with columns Name, Roll Number, DOB, Address, Course, Semester, Academic Year.
- Auto-create taxonomy terms for course/semester/academic-year names found in an imported CSV that don't yet exist.
- Skip (with a warning) CSV rows whose roll number already exists so re-uploads don't duplicate students.
- Classify students by Course using the auto-provisioned `courses` vocabulary.
- Classify students by Semester using the `semesters` vocabulary.
- Track a student's Academic Year using the `academic_year` vocabulary.
- Browse an admin table of all students with per-row View / Update / Delete links at `admin/student-listing`.
- View a formatted on-screen marksheet for a student (details, subject/marks table, and total) at `/student-result/{student_id}`.
- Download that marksheet as a PDF at `/student-result/pdf/{student_id}` (requires the TCPDF library at runtime).
- Show a computed total of all marks obtained for a student on both the HTML and PDF marksheets.
- Edit a student's name, roll number, DOB and address at `/student/update/{student_id}`.
- Delete a student record with a confirmation step at `/student/delete/{student_id}`.
- Gate the admin dashboard behind the `administer marksheet` permission and the teacher/student data-entry forms behind `assign marks`.
- Uninstall cleanly by having the module drop the three vocabularies it created (`hook_uninstall`).
- Provide a help blurb on the module's help page via `hook_help`.
- Serve as a starting point for a custom grade-book by reusing its four-table schema (marks, faculty, students_data, student_details).

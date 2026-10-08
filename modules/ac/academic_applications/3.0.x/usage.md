<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Academic Applications turns Webform into an academic-position application system: applicants submit a program form, references are invited to a secure upload form, and the answers plus recommendation PDFs are merged into one downloadable PDF.
---
The module solves the problem of collecting an application together with confidential letters of recommendation and assembling them into a single reviewable document. An admin defines a "workflow" (config entity `academic_applications_workflow`) that links an application webform to a letters-of-recommendation webform. The recommendation form is reached through a link containing the application submission's UUID in a `wt` query parameter (an unguessable per-submission token), so each recommender uploads against the correct application. A `Bundle` local task on a webform submission (`/admin/structure/webform/manage/{webform}/submission/{webform_submission}/bundle`) runs `SubmissionBundler`, which finds attached PDFs via `SubmissionPdfFinder` and merges them with GhostScript (`gs`).

Operationally the module requires the private file system (recommendation PDFs must not be public), Webform >= 6, and a working GhostScript binary executable by PHP. The bundle route is gated by `_entity_access: 'webform_submission.view'`, so only users who can view the submission can build its bundle. The settings form route requires the permission `access academic applications` (note: the module's permissions.yml only declares `administer academic applications`, so the settings route effectively fails closed unless that permission name is granted). Recommendation-form access relies on the secrecy of the submission UUID passed in the `wt` parameter — treat those links as sensitive.
---
- Install Webform and enable Academic Applications.
- Configure the private file system before collecting recommendation PDFs.
- Verify GhostScript (`gs`) is installed and executable by PHP.
- Create an application webform for the program.
- Create a second webform that accepts only PDF uploads for reference letters.
- Enable "Allow elements to be populated using query string parameters" on the letters form.
- Add a hidden element with key `wt` to the letters form.
- Create a workflow linking the application form to the letters form.
- Configure the module at `/admin/config/academic_applications/settings`.
- Send recommenders a link like `[site:url]form/ar?wt=[webform_submission:uuid]`.
- List recommender names on the submission list via a `name` field.
- Add the applicant's name to the bundle filename via a `name` field.
- Open a submission and use the `Bundle` tab to build the merged PDF.
- Enable the Academic Applications Example submodule to try a working setup.
- Restrict who can view/bundle submissions via Webform submission access.
- Manage workflows at `/admin/structure/academic-applications-workflows`.
- Pass extra values to the letters form as additional query parameters.
- Review the collated PDF (application answers + recommendation letters) as one file.
- Rotate/protect recommendation links since access is UUID-token based.
- Audit that recommendation uploads land in private storage only.
<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring application workflows

1. **Private files + GhostScript** — Set up `private://` and confirm `gs` is executable by PHP; bundling merges PDFs with GhostScript.
2. **Application webform** — Build the program application form (any element types).
3. **Letters webform** — Build a second form that accepts only PDF uploads. Enable *Allow elements to be populated using query string parameters* and add a hidden element keyed `wt`.
4. **Workflow entity** — At `/admin/structure/academic-applications-workflows` add a workflow linking the application form to the letters form.
5. **Recommender invite** — From the application form, email recommenders a link such as `[site:url]form/ar?wt=[webform_submission:uuid]`. The `wt` value is the application submission UUID and acts as the access token for that recommender.
6. **Bundle** — On a submission, use the **Bundle** local task to generate the merged PDF (`SubmissionBundler` + `SubmissionPdfFinder`). Add a `name` field to surface recommender names and to name the output file.

**Security note:** access to the letters form is only as strong as the UUID in `wt`; distribute those links privately and keep uploads in `private://`.

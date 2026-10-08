Editoria11y ("editorial accessibility") is an in-page, editor-facing accessibility checker that flags content problems (bad alt text, empty links, skipped headings, quality issues) as authors browse the live site, and aggregates findings into a site-wide dashboard.

---

Unlike code-oriented scanners, Editoria11y runs in the visitor-facing rendered page and targets the mistakes content editors actually make: missing or suspicious image alt text, meaningless link text ("click here"), broken heading outlines, tables without headers, embedded video without captions, and more. It loads a small JavaScript checker (a Drupal integration of the Sa11y/Ed11y library) for users with the checker permission, showing an unobtrusive toggle panel with tooltips pinned to each issue. Editors can dismiss a tooltip as "hidden" (just for them) or "OK" (for everyone, when result sync is enabled), and those decisions plus per-page results are POSTed back to Drupal via CSRF-protected JSON API endpoints and stored in the database. A site-wide dashboard at Admin → Reports → Content Accessibility Issues, built on bundled Views, rolls the data up by page and by issue type so accessibility leads can triage across the whole site. An extensive settings form controls which tests run, theming and panel placement, which page regions to scan, live "editable region" checking inside CKEditor, shadow-DOM detection, ignore selectors, and more — all stored in the `editoria11y.settings` config object. Two alter hooks let developers customize the configuration passed to the front end globally or per request. Companion submodules add community-supported extra test suites plus a contrast checker and custom-test entities (CSA) and filterable bulk CSV exports (Export). It depends on node, taxonomy, user, and views.

---

- Warn editors in real time when an image is missing alt text.
- Flag suspicious alt text (file names, "image of…", redundant text).
- Catch meaningless link text like "click here" or "read more".
- Detect links that open new windows without warning.
- Highlight skipped or out-of-order heading levels on a page.
- Flag tables that lack header cells or a caption.
- Warn about embedded video/audio that may need captions.
- Check content live inside the CKEditor 5 editing area as authors type.
- Give editors a per-page toggle panel listing all detected issues.
- Let an editor dismiss a false positive as "hidden" just for themselves.
- Let a lead mark an issue "OK" for all users when sync is enabled.
- Roll up all site issues in a dashboard grouped by page.
- Roll up issues by test type to find the most common problems.
- Reset or purge stored results for a page after it is fixed.
- Restrict scanning to a specific content region via a CSS selector.
- Exclude decorative or third-party regions from checks via ignore selectors.
- Turn specific tests on or off site-wide (e.g. disable graphic-contrast warnings).
- Choose panel placement (left/right) and visual theme for the checker.
- Support shadow-DOM / web-component content detection.
- Preserve query parameters (search, page, language) when tracking page results.
- Give content editors the checker while hiding it from anonymous visitors.
- Track accessibility debt as a KPI across an editorial team.
- Alter the front-end config per request via `hook_editoria11y_alter_config`.
- Localize the checker UI via the interface translation project.
- Onboard new editors with a built-in demo page of sample issues.
- Bulk-export filtered results to CSV for reporting (with the Export submodule).
- Add contrast checks and developer test suites (with the CSA submodule).

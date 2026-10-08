<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Cleanup is an admin dashboard that scans node text fields for markup problems and rewrites them in place with rule-based cleanup.

---

AI Content Cleanup detects and standardizes messy markup in migrated and legacy node content. From an admin
dashboard it scans the node bundles you choose, flags issues such as broken/unbalanced HTML, inline styles,
skipped heading levels, images missing alt text, empty layout elements and deprecated presentational tags, and
stores each detected issue in its own database table. A side-by-side editor shows the original markup next to a
cleaned version and can apply the cleaned markup back to a node as a new revision. Bulk, reports, templates and
history pages round out the workflow. In this release the cleanup rules are deterministic regular-expression and
DOMDocument transformations configured on the settings form (each rule can be toggled) — the module does not call
an LLM or the drupal/ai module in the current code. It depends only on core `node` and `text`, ships two
permissions, and runs on Drupal 10.3+ and 11.

---

- Scan articles/pages for broken or unbalanced HTML tags after a migration.
- Detect and strip inline `style="..."` attributes from imported markup.
- Standardize heading hierarchy so levels do not skip (e.g. h2 → h5).
- Flag images that are missing `alt` text for accessibility review.
- Remove empty `<p>`/`<div>`/`<span>` wrappers left over from legacy editors.
- Rewrite deprecated `<font>`/`<center>`/`<strike>` tags and map `<b>`/`<i>` to `<strong>`/`<em>`.
- Preview an original-vs-cleaned diff of a node's body before changing anything.
- Apply cleaned markup back to a node as a new revision (with a revision log message).
- Choose exactly which cleanup rules are active on the settings form.
- Choose which node content types are included in scans and reports.
- Set the scan batch size and the default first heading level.
- Track detected issues on a dashboard with counts by issue type and severity.
- Review a results table of open issues with an AI-style confidence score per item.
- Drill into a single issue to see its message, location and suggested fix.
- Save and edit reusable cleanup templates (rule presets) for consistent runs.
- Review a history log of cleanup operations and issues fixed.
- Run cleanup as a content editor after importing content from a legacy CMS.
- Improve markup consistency and accessibility across editorial teams.
- Reduce manual find-and-replace work when modernizing old content.
- Restrict who can apply changes vs. who can only view reports via two permissions.

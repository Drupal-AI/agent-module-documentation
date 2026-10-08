Accessibility Auto Fixer scans Drupal pages for WCAG AA accessibility violations, shows them in an admin dashboard, and applies persistent one-click DOM auto-fixes.

---

The module provides two scanners built without any external accessibility library. A client-side JavaScript scanner (`js/scanner.js`) inspects the live DOM and computed styles for missing image alt text, unlabelled buttons/links/form fields, and colour-contrast failures, then POSTs the results back to Drupal. A server-side PHP scanner (`A11yScannerService`) fetches a URL over HTTP and parses the HTML with `DOMDocument`/`DOMXPath` to detect the same violation classes on markup and inline styles. Findings are stored in the custom `a11y_results` and `a11y_fixes` tables and rendered through an admin dashboard (`/admin/reports/a11y-dashboard`), a full scan log, and a per-scan details page with impact/type filters and per-path history. Each page gets a 0-100 accessibility score (critical -10, serious -5, moderate -2, minor -1). Every node page gains an "Accessibility Scan" local task tab that runs the client scanner and opens a slide-in panel with highlight, fix, and fix-all actions; applied fixes are recorded so they are filtered out of future scans. A "Scan All" action re-scans saved pages or auto-discovers routes (up to 500, expanding canonical entity paths) and scans them server-side. Drush commands (`a11y:scan`, `a11y:scan-all`) support table or JSON output with a non-zero exit code for CI.

---

- Add a "Scan this page" button to any node page via the Accessibility Scan local task tab.
- Detect `<img>` elements missing an `alt` attribute (critical).
- Detect `<button>`, `<select>`, and `<textarea>` elements with no accessible name (serious).
- Detect `<a>` links with no text content and no `aria-label` (serious).
- Detect form `<input>` controls not associated with a `<label>` (serious).
- Detect insufficient colour contrast below the WCAG AA threshold (4.5:1 normal, 3:1 large text).
- Compute a 0-100 accessibility score per page from violation impact levels.
- Apply a one-click auto-fix that sets `alt=""` or suggested text on images.
- Apply a one-click auto-fix that adds `aria-label` to unlabelled buttons, links, and form fields.
- Apply a one-click auto-fix that sets text colour to black on low-contrast text.
- Persist applied fixes in the database so resolved issues do not reappear on re-scan.
- Highlight and scroll to the offending element on the page from the violations panel.
- Review recently scanned pages, scores, and violation counts on the admin dashboard.
- Browse the full scan-log history of every scan at `/admin/reports/a11y-logs`.
- Drill into a single scan's violations, overview breakdown, and history at the details page.
- Filter a scan's violations by impact level or violation type.
- Re-scan all previously scanned pages in one action from the dashboard (server-side).
- Auto-discover all site routes (up to 500, including published node/user/term canonical paths) and scan them.
- Server-side scan an arbitrary URL and store its result via the scan-server endpoint.
- Run a single-URL accessibility scan from the command line with `drush a11y:scan <url>`.
- Batch-scan a file of URLs with `drush a11y:scan-all <file>` for CI pipelines.
- Emit machine-readable JSON scan results with `--format=json` for downstream tooling.
- Fail a CI build automatically: Drush scan commands exit with code 1 when violations are found.
- Restrict the "Scan this page" tab to selected node types via the settings form.
- Exclude specific user roles from auto-scanning via the settings form.
- Toggle individual checks (ARIA, contrast, alt text) and auto-fix behaviours from configuration.

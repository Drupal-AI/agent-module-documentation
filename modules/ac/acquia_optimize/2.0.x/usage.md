<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Web Governance adds an on-demand "Quick Scan" button to Drupal node edit forms (and the Canvas page builder). It renders a preview of the page being edited, collects its HTML and CSS in the browser, sends that to the Acquia Web Governance (Monsido) API, and shows accessibility, SEO, readability and data-privacy findings in a modal. It is a per-page scanner, not a whole-site crawler.

---

The mechanism is worth understanding because the module name ("Optimize") and its marketing suggest continuous governance, but what ships here is a single-page, editor-triggered scan. On a node form, `AcquiaOptimizeFormAlter` adds a panel to the advanced (sidebar) group with one button whose label flips on whether an API key is configured: "Configure API" (redirect to settings) or "Quick Scan". Clicking Quick Scan builds the entity without submitting, stashes the form state in the private tempstore, and opens a modal. The JavaScript (`js/quickScan.js`) fetches a node-preview URL — rendered as the anonymous user by `AcquiaOptimizePreviewController` so the scan sees the public page — hands the markup to a `DataCollector` that ships in the module's Acquia "optimize" library, and POSTs the collected `html`/`css`/`encoded_page` to `/acquia-optimize/api/quick-scan`. The controller's `ApiClient` forwards it to `{api_url}/html_scans` with a `Bearer` API key; a second endpoint, `/acquia-optimize/api/content-quick-scan/{id}`, does server-side polling of `{api_url}/html_scans/{id}` until the scan completes, then renders the results modal server-side. Canvas users get a React extension (`ui/dist/bundle.js`) hitting the same JSON endpoints with a CSRF token. Results are explicitly not saved back to the Acquia account.

Two permissions divide the roles: `scan acquia optimize` (`restrict access: true`) to run scans, which cost time and vendor quota, and `administer acquia optimize` for connection settings. The settings form locks the API URL to an HTTPS `*.monsido.com` host and validates the connection (`GET /account`) before saving. The `api_key` is stored in `acquia_optimize.settings` config; the form masks it on display and keeps the stored value when the masked field is resubmitted — a careful UI, but masking is not storage: the key still lives in config, so it is present in config exports, the repository and database dumps. There is no Key-entity support. Prefer holding the value in an environment variable and referencing it via a `settings.php` config override so exported configuration carries nothing secret. Note `composer.json` declares a conflict with `drupal/experience_builder`.

---

- Give an editor accessibility feedback (WCAG 2.0/2.1/2.2, A/AA/AAA) on the page they are editing.
- Surface SEO issues for a single node before it is published.
- Show a readability score and grade level for the current page's content.
- Flag data-privacy violations found on a page.
- Run an on-demand scan from the node edit form without leaving Drupal.
- Scan a page inside the Canvas page builder via the React extension.
- Choose the WCAG target level (e.g. WCAG21-AA) site-wide.
- Connect an existing Acquia Web Governance / Monsido account by API key and URL.
- Validate the API connection at configuration time before saving credentials.
- Separate who may run scans from who may change connection settings.
- Restrict scanning to control Acquia vendor quota with the `restrict access` permission.
- Preview how a page renders and scores as the anonymous public visitor.
- Link editors straight to their Web Governance dashboard for full reports.
- Re-scan a page after making edits to confirm issues are resolved.
- Provide a one-click quality check for content teams during authoring.
- Audit an individual inherited page's accessibility and SEO on demand.
- Enable debug logging to the JS console while troubleshooting a scan.
- Keep the scanning UI out of forms for users lacking the scan permission.
- Route editors to the settings page when no API key is configured yet.
- Present findings grouped into collapsible accessibility / SEO / readability / data-privacy sections.

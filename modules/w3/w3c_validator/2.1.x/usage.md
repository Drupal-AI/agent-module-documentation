W3C Validator runs your site's pages (front page plus all nodes, optionally admin/router pages) through a W3C Markup Validator instance and reports HTML validity — errors, warnings and info — in an admin report, with a batch "re-validate all" operation.

---

The module wraps the `rexxars/html-validator` PHP library (`HtmlValidator\Validator`) to submit page URLs to a configured W3C validator endpoint (`w3c_validator.settings:validator_url`; the official `validator.nu`/`validator.w3.org` service is discouraged for volume, a self-hosted `w3c_markup_validator` instance is recommended). The report page (`/admin/reports/w3c_validator`, the module's `configure` route) lists every page with a colour-coded validity status and expandable error/warning/info details; results are stored in the `w3c_validator` table. A batch operation (`W3CProcessor::validateAllPages()`) walks `findAllPages()` (front + all `node_field_data` rows; plus router paths when the `admin_pages` setting is on), checks each page is viewable by the chosen validation identity, fetches and validates it, and merges the result. When the `use_token` setting is on, validation runs "as the current (admin) user": a short-lived token is created in `w3c_access_token` and passed as a query parameter so the module's own **global authentication provider** (`W3CTokenAuth`, reading `HTTP_W3C_VALIDATOR_TOKEN`) logs the fetch in as that user, letting the validator see access-restricted pages; otherwise validation runs anonymously. The settings form (`/admin/config/development/w3c_validator`) and all report/confirm routes require `administer w3c_validator` (`restrict access: true`), report/confirm additionally accept `access site reports`. Provides config schema; no Drush.

---

- Validate the HTML of every node on the site against W3C standards in one batch run.
- Point the module at a self-hosted `w3c_markup_validator` instance to avoid the public service's rate limits.
- Use the official `https://validator.w3.org/nu` endpoint for occasional/test validation.
- Get a colour-coded site report of valid / invalid / outdated / unknown pages.
- Drill into a page's specific HTML errors, warnings and info messages with source extracts.
- Include admin and routed pages in validation by enabling the "admin pages" option.
- Validate access-restricted pages "as a logged-in user" via the token option so the validator sees real markup.
- Validate as an anonymous visitor to check the markup the public actually receives.
- Re-validate the whole site after a theme or template change (batch "Re-validate all pages").
- Track which pages regressed to invalid after a deployment.
- Link out to the external validator's own results page for a given URL from the report.
- Feed a QA/accessibility workflow with concrete standards-compliance data.
- Store validation history in the `w3c_validator` table for later inspection.
- Warn editors when they are about to hammer the public W3C service (built-in rate-limit-service notice).
- Provide site owners a "how standards-compliant is my markup" dashboard under Reports.
- Gate all validation behind a restricted admin permission plus optional "access site reports".
- Confirm a large re-validation run before it starts (confirm form).
- Check a fresh install's default theme output for markup errors.
- Audit a subset of content by validating and reviewing only invalid rows.

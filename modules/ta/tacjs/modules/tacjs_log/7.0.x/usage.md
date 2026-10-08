TacJS Log records proof of cookie-consent decisions made through the TacJS / tarteaucitron.js banner into a database table and shows them in an admin overview report.

---

TacJS Log is a submodule of TacJS that adds a lightweight "proof of consent" audit trail. It attaches a small JS file (`tacjs_log/tacjs_log`, depending on `tacjs/tarteaucitron.js`) to every non-admin page which, when a visitor allows a service, POSTs to the route `tacjs_log.report` at `/reports/tacjslog/{service}` (permission `access content`). The `LogController::report()` method inserts a row — timestamp, client IP address and the allowed service string — into the `tacjslog` database table (created by `hook_schema()` in `tacjs_log.install`). Administrators view the collected records at `/admin/config/system/tacjs/overview` (route `tacjs_log.overview`, permission `administer tacjs`, added as a local task tab), which renders a sortable, paged table of timestamp / IP / services allowed. The submodule has no configuration form and no config of its own; its entire state is the `tacjslog` table.

---

- Keep a GDPR "proof of consent" audit trail of who accepted which cookie service and when.
- Record the visitor IP address alongside each consent decision.
- Store the exact tarteaucitron service string the visitor allowed.
- Review all stored consents in a sortable admin table at /admin/config/system/tacjs/overview.
- Page through large consent logs (50 rows per page) in the overview report.
- Demonstrate compliance to a data-protection authority with timestamped consent records.
- Log consent from the front end automatically without extra editor action.
- Capture consent events via the /reports/tacjslog/{service} endpoint.
- Sort consent records by timestamp, IP address or service.
- Provide evidence of opt-in for analytics/marketing cookies.
- Query the tacjslog table directly for reporting or export.
- Add a consent-history tab next to the other TacJS admin forms.
- Restrict the consent overview to users with the 'administer tacjs' permission.
- Allow anonymous visitors to submit their consent record (access content).
- Retain a per-service breakdown of accepted services over time.
- Back a custom compliance dashboard with the stored consent rows.

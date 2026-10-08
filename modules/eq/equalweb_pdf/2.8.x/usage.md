<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EqualWeb PDF Accessibility scans every PDF on a Drupal site against the PDF/UA standard, scores each file with a rule-by-rule report, and can automatically remediate inaccessible PDFs through the EqualWeb service.
---
The admin dashboard at `/admin/reports/equalweb-pdf` lists the site's PDF (and office) files with accessibility scores; the free check needs no account or API key, while paid remediation spends shared EqualWeb credits. All work happens server-side in `AjaxController` — API keys never reach the browser — talking to EqualWeb via `EqualWebClient`. A single POST route `/equalweb-pdf/ajax/{action}` serves every action; it is deliberately gated at the route by the weakest (view) permission and then re-authorizes each action inside `handle()` against an `ACTION_PERMS` map (check, poll, remediate, apply/restore, admin-only settings/register/classification), after validating an `equalweb_pdf` CSRF token. The `Access` helper scopes file visibility: `view any equalweb pdf files` sees all, `view own equalweb pdf files` sees only files the user owns, and `administer equalweb pdf` short-circuits.

The download route (`/equalweb-pdf/download/{fid}`) validates a CSRF token and re-checks `Access::canSee($file)`, returning a 404 (no oracle) when the user may not see the file. The yearly report route uses `_csrf_token: 'TRUE'`. The public `/equalweb-pdf/verify` endpoint (`_access: 'TRUE'`) is a registration handshake that returns only a one-time, time-limited registration nonce from state (or 404 when none is pending) with `Cache-Control: no-store` — it exposes no user data and performs no state change or server-side fetch, so it cannot be abused to forge verification or trigger SSRF. Set up by opening the dashboard, registering the site, and running checks/remediation.
---
- Scan every PDF on the site against the PDF/UA accessibility standard
- Get a per-file accessibility score and rule-by-rule report
- Run free accessibility checks without an account or API key
- Remediate inaccessible PDFs automatically via EqualWeb (paid credits)
- Replace a live PDF with its accessible version, keeping a restorable backup
- Save an accessible copy as a new file instead of replacing
- Restore the original file from backup after a remediation
- Download the remediated/accessible PDF via a CSRF-protected link
- View a yearly executive accessibility report (CSRF-protected)
- Scope the dashboard to only files a user owns vs. all files
- Grant granular permissions: check, remediate, replace, view own/any, admin
- Register the site with EqualWeb from the admin UI
- Check the remaining EqualWeb credit balance
- Tag/classify files to change remediation priority (admin)
- Ignore files to hide them from every viewer (admin, reversible/logged)
- Bulk-tag or bulk-untag files by classification
- Set archive-year thresholds for classification
- Poll a running check or remediation to completion
- Keep API keys server-side, never exposed to the browser
- Track PDF accessibility across the whole site as an audit inventory
